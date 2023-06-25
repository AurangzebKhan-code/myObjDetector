
import Foundation
import UIKit
import AVFoundation
import Vision

class CameraView: UIView, AVCaptureVideoDataOutputSampleBufferDelegate {
  
  private var previewLayer: AVCaptureVideoPreviewLayer?
  private var captureSession: AVCaptureSession?
  
  @objc var onBoundingBox: (([String : Any]?) -> Void)!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.startCaptureSession()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func startCaptureSession() {
    self.captureSession = AVCaptureSession()
    self.captureSession?.sessionPreset = .photo
    
    guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
      print("Error: No back camera available")
      return
    }
    
    guard let input = try? AVCaptureDeviceInput(device: device) else {
      print("Error: Problem with input device")
      return
    }
    
    self.captureSession?.addInput(input)
    self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession!)
    self.previewLayer?.frame = self.bounds
    self.previewLayer?.videoGravity = .resizeAspectFill
    self.layer.addSublayer(self.previewLayer!)
    let output = AVCaptureVideoDataOutput()
    output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera.frame.processing.queue"))
    self.captureSession?.addOutput(output)
    self.captureSession?.startRunning()
  }
  
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
    let request = VNDetectRectanglesRequest { [weak self] request, error in
      guard error == nil else { return }
      if let results = request.results as? [VNRectangleObservation] {
        DispatchQueue.main.async {
          for rectangle in results {
            self?.onBoundingBox([
              "x": rectangle.boundingBox.origin.x,
              "y": rectangle.boundingBox.origin.y,
              "width": rectangle.boundingBox.size.width,
              "height": rectangle.boundingBox.size.height,
            ])
          }
        }
      }
    }
    let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
    do {
      try handler.perform([request])
    } catch {
      print(error)
    }
  }
}

