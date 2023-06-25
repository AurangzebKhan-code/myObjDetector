// CameraManagerBridge.m
#import "React/RCTViewManager.h"

// This class serves as a bridge between React Native and the native CameraManager class
@interface RCT_EXTERN_REMAP_MODULE(CameraManager, CameraManager, RCTViewManager)

// Exposing the onBoundingBox property to React Native
RCT_EXPORT_VIEW_PROPERTY(onBoundingBox, RCTBubblingEventBlock)

// Exposing the view method to React Native
RCT_EXTERN_METHOD(view)

// Exposing the requiresMainQueueSetup method to React Native
RCT_EXTERN_METHOD(requiresMainQueueSetup)

@end
