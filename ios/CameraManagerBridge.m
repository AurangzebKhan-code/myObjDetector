// CameraManagerBridge.m
#import "React/RCTViewManager.h"

@interface RCT_EXTERN_REMAP_MODULE(CameraManager, CameraManager, RCTViewManager)

RCT_EXPORT_VIEW_PROPERTY(onBoundingBox, RCTBubblingEventBlock)
RCT_EXTERN_METHOD(view)
RCT_EXTERN_METHOD(requiresMainQueueSetup)

@end
