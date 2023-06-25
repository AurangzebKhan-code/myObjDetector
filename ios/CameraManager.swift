import Foundation
import UIKit
import AVFoundation
import Vision

// This class is responsible for the camera view
@objc(CameraManager)
class CameraManager: NSObject {
  
  // Returns a new CameraView instance
  @objc func view() -> UIView! {
    return CameraView()
  }
  
  // If the app requires any setup on the main queue, this function returns true
  @objc static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
