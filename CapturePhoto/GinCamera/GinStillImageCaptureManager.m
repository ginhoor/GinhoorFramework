//
//  GinStillImageCaptureManager.m
//  GinCamera
//
//  Created by JunhuaShao on 2017/4/6.
//  Copyright © 2017年 GinhoorHome. All rights reserved.
//

#import "GinStillImageCaptureManager.h"
#import <GinhoorFramework/UIImage+GinUnit.h>

// 照片
@implementation GinStillImage
@end

@interface GinStillImageCaptureManager()

@end

@implementation GinStillImageCaptureManager

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"currentFlashMode" context:nil];
}

+ (BOOL)checkAVAuthorizationStatus
{
    AVAuthorizationStatus authorStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authorStatus == AVAuthorizationStatusRestricted || authorStatus == AVAuthorizationStatusDenied){

        return NO;
    }
    return YES;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self addObserver:self forKeyPath:@"currentFlashMode" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
}

- (void)setupSession
{
    // 图片类
    _cameraImages = [NSMutableArray array];

    //1.创建会话层
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    [_device lockForConfiguration:nil];
    //自动持续对焦
    [_device setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
    //操作完成后，记得进行unlock。
    [_device unlockForConfiguration];
    
    _currentFlashMode  = _device.flashMode;
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:_device error:nil];
    
    // Output
    _captureOutput = [[AVCaptureStillImageOutput alloc] init];
    
    NSDictionary *outputSettings = @{AVVideoCodecKey:AVVideoCodecJPEG,
                                     AVVideoQualityKey:@(0.3)
                                     };
    
    [_captureOutput setOutputSettings:outputSettings];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    // 设置高质量
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    if ([_session canAddInput:_input])
    {
        [_session addInput:_input];
    }
    
    if ([_session canAddOutput:_captureOutput])
    {
        [_session addOutput:_captureOutput];
    }

    [self setupPreviewLayer];
    
}

- (void)setupPreviewLayer
{
    _preview = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"currentFlashMode"]) {
        if (self.currentFlashModeBeforeChangedBlock) {
            self.currentFlashModeBeforeChangedBlock((NSInteger)change[NSKeyValueChangeNewKey], (NSInteger)change[NSKeyValueChangeOldKey]);
        }
    }
}

- (void)switchCurrentCameraDeviceWithcompletion:(void(^)(AVCaptureDeviceInput *newInput, AVCaptureDevicePosition position))completion
{
    [self switchCameraDevice:self.session completion:^(AVCaptureDeviceInput *newInput, AVCaptureDevicePosition position) {
        
        if (position == AVCaptureDevicePositionFront) {
            self.currentFlashMode = _lastFlashMode;
        } else {
            // 前置摄像头不支持闪光灯
            _lastFlashMode = self.currentFlashMode;
            self.currentFlashMode = -1;
        }
        
        if (completion) {
            completion(newInput, position);
        }
    }];
}

//拍照
- (void)captureImageWithCompletion:(void(^)(GinStillImage *image, NSArray *images))completion
{
    AVCaptureConnection *videoConnection = [self getVideoConnection:self.captureOutput];
    
    //get UIImage
    [self.captureOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:
     ^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
         
         NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
         UIImage *t_image = [UIImage imageWithData:imageData];
    
         GinStillImage *image = [[GinStillImage alloc] init];
         image.photoImage = t_image;
         
         image.thumbImage = [UIImage imageWithData:[t_image compressToMaxDataSizeKBytes:500 maxQuality:0.3]];
         
         [self.cameraImages addObject:image];
         
         if (completion) {
             completion(image, self.cameraImages);
         }
    }];
}

- (BOOL)switchFlashMode
{
    BOOL flag = NO;
    
    if ([self.device isFlashModeSupported:self.currentFlashMode]) {
        
        [self.session beginConfiguration];
        
        [self.device lockForConfiguration:nil];
        [self.device setFlashMode:self.currentFlashMode];
        [self.device unlockForConfiguration];
        
        [self.session commitConfiguration];
        
        [self.session startRunning];
        flag = YES;
    }
    return flag;
}

#pragma - Private Method 保存至相册

- (void)saveImageToPhotoAlbum:(UIImage *)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 指定回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"保存照片过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        NSLog(@"照片保存成功.");
    }
}


 // 设置聚焦
- (void)focusWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point{
    
    AVCaptureDevice *captureDevice = self.device;
    // 锁定配置
    [captureDevice lockForConfiguration:nil];
    
    // 设置聚焦
    if ([captureDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
    }
    if ([captureDevice isFocusPointOfInterestSupported]) {
        [captureDevice setFocusPointOfInterest:point];
    }
    
    // 设置曝光
    if ([captureDevice isExposureModeSupported:AVCaptureExposureModeAutoExpose]) {
        [captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
    }
    if ([captureDevice isExposurePointOfInterestSupported]) {
        [captureDevice setExposurePointOfInterest:point];
    }
    
    // 解锁配置
    [captureDevice unlockForConfiguration];
}

/**
 *  压缩图片到指定文件大小
 *
 *  @param image 目标图片
 *  @param size  目标大小（最大值）
 *
 *  @return 返回的图片文件
 */
- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}


@end


