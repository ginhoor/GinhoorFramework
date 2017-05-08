//
//  GinCameraCaptureManager.h
//  GinCamera
//
//  Created by JunhuaShao on 2017/4/6.
//  Copyright © 2017年 GinhoorHome. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface GinCameraCaptureManager : NSObject

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position;

- (void)switchCameraDevice:(AVCaptureSession *)session completion:(void(^)(AVCaptureDeviceInput *newInput, AVCaptureDevicePosition position))completion;

- (AVCaptureConnection *)getVideoConnection:(AVCaptureOutput *)captureOutput;

- (void)getVideoAuthorization:(void(^)())successBlock failture:(void(^)())failtureBlock;

@end
