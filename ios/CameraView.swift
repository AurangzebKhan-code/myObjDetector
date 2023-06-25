import Foundation
import UIKit
import AVFoundation
import Vision

// CameraView class, where we setup and manage our camera view
class CameraView: UIView, AVCaptureVideoDataOutputSampleBufferDelegate {
  
  // previewLayer is where we will display the camera capture
  private var previewLayer: AVCaptureVideoPreviewLayer?
  
  // captureSession is the instance managing the capture activity and coordinating the data flow from the input devices to outputs
  private var captureSession: AVCaptureSession?
  
  // Closure called when a bounding box is detected
  @objc var onBoundingBox: (([String : Any]?) -> Void)!
  
  // Initializer for the camera view
  override init(frame: CGRect) {
    super.init(frame: frame)
    // Starts the capture session on the main queue to avoid blocking
    DispatchQueue.main.async {
      self.startCaptureSession()
    }
  }
  
  // Required initializer from NSCoder not implemented
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // This function starts the capture session
  private func startCaptureSession() {
    // Initializing capture session and setting session preset
    self.captureSession = AVCaptureSession()
    self.captureSession?.sessionPreset = .photo
    
    // Guard statement to check if device has a back camera
    guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
      // handle error here
      return
    }
    
    // Guard statement to check if the device input is available
    guard let input = try? AVCaptureDeviceInput(device: device) else {
      // handle error here
      return
    }
    
    // Adding input to the capture session
    self.captureSession?.addInput(input)
    
    // Setting up preview layer
    self.previewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession!)
    self.previewLayer?.frame = self.bounds
    self.previewLayer?.videoGravity = .resizeAspectFill
    self.layer.addSublayer(self.previewLayer!)
    
    // Output instance of AVCaptureVideoDataOutput
    let output = AVCaptureVideoDataOutput()
    
    // Setting delegate for the output and dispatch queue for sample buffer delegate callback
    output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "camera.frame.processing.queue"))
    
    // Adding output to capture session
    self.captureSession?.addOutput(output)
    
    // Starting the capture session
    self.captureSession?.startRunning()
  }
  
  // Delegate method called when a new video frame was written
  func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
    // Extract pixel buffer from sample buffer
    guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
    
    // Rectangle detection request
    let request = VNDetectRectanglesRequest { [weak self] request, error in
      // Handling errors from the rectangle detection request
      guard error == nil else { return }
      
      // Handling detected rectangles
      if let results = request.results as? [VNRectangleObservation] {
        DispatchQueue.main.async {
          for rectangle in results {
            // Call onBoundingBox closure for each detected rectangle
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
    
    // Create an image request handler
    let handler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
    
    do {
      // Perform the rectangle detection request
      try handler.perform([request])
    } catch {
      // handle error here
    }
  }
}

