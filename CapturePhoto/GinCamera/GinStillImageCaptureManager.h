//
//  GinStillImageCaptureManager.h
//  GinCamera
//
//  Created by JunhuaShao on 2017/4/6.
//  Copyright © 2017年 GinhoorHome. All rights reserved.
//

#import "GinCameraCaptureManager.h"

@interface GinStillImage : NSObject
// 压缩图
@property (strong,nonatomic) UIImage *thumbImage;
// 原图
@property (strong,nonatomic) UIImage *photoImage;
@property (strong, nonatomic) NSString *localIdentifier;

@end

@interface GinStillImageCaptureManager : GinCameraCaptureManager

@property (copy, nonatomic) NSMutableArray<GinStillImage *> *cameraImages;

@property (strong, nonatomic, readonly) AVCaptureSession *session;

@property (strong, nonatomic, readonly) AVCaptureStillImageOutput *captureOutput;
@property (strong, nonatomic, readonly) AVCaptureDevice *device;

@property (strong, nonatomic, readonly) AVCaptureDeviceInput *input;
@property (strong, nonatomic, readonly) AVCaptureMetadataOutput *output;

@property (strong, nonatomic, readonly) AVCaptureVideoPreviewLayer *preview;

/**
 * 当值为-1时，表示当前闪光灯不可用。
 */
@property (assign, nonatomic) AVCaptureFlashMode currentFlashMode;
/**
 * 当切换到闪光灯不可用的状态时，保留上一次的状态。
 */
@property (assign, nonatomic, readonly) AVCaptureFlashMode lastFlashMode;

@property (copy, nonatomic) void(^currentFlashModeBeforeChangedBlock) (AVCaptureFlashMode newMode, AVCaptureFlashMode oldMode);


- (void)setupSession;

- (void)switchCurrentCameraDeviceWithcompletion:(void(^)(AVCaptureDeviceInput *newInput, AVCaptureDevicePosition position))completion;

- (void)captureImageWithCompletion:(void(^)(GinStillImage *image, NSArray *images))completion;

- (BOOL)switchFlashMode;

- (void)saveImageToPhotoAlbum:(UIImage *)savedImage;

- (void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point;

+ (BOOL)checkAVAuthorizationStatus;

@end
