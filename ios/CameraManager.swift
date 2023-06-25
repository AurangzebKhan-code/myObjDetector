import Foundation
import UIKit
import AVFoundation
import Vision


@objc(CameraManager)
class CameraManager: NSObject {
  
  
  @objc func view() -> UIView! {
    return CameraView()
  }
  
  
  @objc static func requiresMainQueueSetup() -> Bool {
    return true
  }
}
