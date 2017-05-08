//
//  CECapturePhotoViewController.m
//  CarEagle
//
//  Created by JunhuaShao on 2017/4/24.
//  Copyright © 2017年 CarEagle. All rights reserved.
//

#import "CECapturePhotoViewController.h"
#import <Masonry/Masonry.h>
#import <GinhoorFramework/UIAlertController+GinUnit.h>
#import "CEPhotoCacheService.h"
#import <GinhoorFramework/UIImage+GinUnit.h>
#import <GinhoorFramework/UIAlertController+GinUnit.h>
#import "UIViewController+CENavigation.h"

#define kAnimationDuration 0.15

@interface CECapturePhotoViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation CECapturePhotoViewController

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask) supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (UIInterfaceOrientation) preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeRight;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (![GinStillImageCaptureManager checkAVAuthorizationStatus]){
        [UIAlertController alert:@"未获得授权使用摄像头" message:@"请在 '设置-隐私-相机' 中开启权限。" cancelTitle:@"确定" cancelBlock:^{
            
            [self popWithCompletion:nil];
        
        } completionBlock:^{
            ;
        }];
        return;
    };
    
    self.captureManager = [[GinStillImageCaptureManager alloc] init];
    [self.captureManager setupSession];
    [self.captureView.cameraView.layer insertSublayer:self.captureManager.preview atIndex:0];
    __weak typeof(self) _WeakSelf = self;
    [self.captureManager setCurrentFlashModeBeforeChangedBlock:^(AVCaptureFlashMode newMode, AVCaptureFlashMode oldMode){
        __strong typeof(_WeakSelf) _StrongSelf = _WeakSelf;
        [_StrongSelf updateFlashModeUI];
    }];
    
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.captureManager.session startRunning];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.captureManager.session stopRunning];
}


- (void)setupViews
{
    [self.view addSubview:self.captureView];
    [self.captureView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [self.captureView.deviceBtn addTarget:self action:@selector(changeCameraDeviceAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.captureView.flashBtn addTarget:self action:@selector(handleFlashAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.captureView.cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.captureView.cameraBtn addTarget:self action:@selector(captureImage:) forControlEvents:UIControlEventTouchUpInside];
    [self.captureView.doneBtn addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.captureView.photoLibraryBtn addTarget:self action:@selector(showPhotoLibrary:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillLayoutSubviews
{
    self.captureManager.preview.frame = self.view.bounds;
}

#pragma - Getter & Setter

- (CECapturePhotoView *)captureView
{
    if (!_captureView) {
        _captureView = [[CECapturePhotoView alloc] init];
    }
    return _captureView;
}

- (void)showPhotoLibrary:(id)sender
{
    UIImagePickerControllerSourceType sourceType;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    } else {
        sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    // 跳转到相机页面
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.navigationBar.tintColor = [UIColor whiteColor];
    
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = NO;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:^{}];
}

- (void)changeCameraDeviceAction:(id)sender
{
    // 翻转
    [UIView animateWithDuration:0.5f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    } completion:^(BOOL finished) {
        ;
    }];
    
    [self.captureManager switchCurrentCameraDeviceWithcompletion:^(AVCaptureDeviceInput *newInput, AVCaptureDevicePosition position) {
        if (position == AVCaptureDevicePositionFront) {
            self.captureView.flashBtn.enabled = YES;
        } else {
            // 前置摄像头不支持闪光灯
            self.captureView.flashBtn.enabled = NO;
        }
    }];
}

- (void)handleFlashAction:(id)sender
{
    self.captureManager.currentFlashMode++;
}

- (void)cancelAction:(id)sender
{
    if (!self.currentCapturedImage) {
        [self popWithCompletion:nil];
    } else {
        self.currentCapturedImage = nil;
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.captureView.capturedImageView.alpha = 0;
            self.captureView.doneBtn.alpha = 0;
        }];
        [self.captureView.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    }
}

//拍照
- (void)captureImage:(id)sender
{
    [self.captureManager captureImageWithCompletion:^(GinStillImage *image, NSArray *images) {
        self.currentCapturedImage = image;
        self.captureView.capturedImageView.image = image.thumbImage;
        [self updateImageCapturedUI:YES];
    }];
}

- (void)updateImageCapturedUI:(BOOL)animated
{
    [UIView animateWithDuration:animated ? kAnimationDuration : 0 animations:^{
        self.captureView.doneBtn.alpha = 1;
        self.captureView.capturedImageView.alpha = 1;
    }];
    
    [self.captureView.cancelBtn setTitle:@"重拍" forState:UIControlStateNormal];
}

- (void)doneAction:(id)sender
{
    if (self.currentCapturedImage) {
    
        NSDictionary *result = [CEPhotoCacheService saveImage:self.currentCapturedImage.thumbImage];
        NSString *name = result[@"name"];
        NSNumber *success = result[@"success"];
                
        if (!success.boolValue) {
            [UIAlertController alert:@"提示" message:@"相片保存失败!" cancelTitle:@"确认" cancelBlock:^{
                self.currentCapturedImage = nil;
                self.captureView.capturedImageView.image = nil;
                [self updateImageCapturedUI:NO];
            } completionBlock:^{}];
        } else {
            [self popWithCompletion:nil];
        }        
    }
    [self cancelAction:nil];
}


#pragma - Delegate & DataSource
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if(!editedImage) {
        editedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }

    UIImage *savedImage = [UIImage imageWithData:[editedImage compressToMaxDataSizeKBytes:500 maxQuality:0.3]];
    
    
    NSDictionary *result = [CEPhotoCacheService saveImage:savedImage];
    NSString *name = result[@"name"];
    NSNumber *success = result[@"success"];
    
    if (!success.boolValue) {
        [UIAlertController alert:@"提示" message:@"相片保存失败!" cancelTitle:@"确认" cancelBlock:^{
            self.currentCapturedImage = nil;
            self.captureView.capturedImageView.image = nil;
            [self updateImageCapturedUI:NO];
            [picker dismissViewControllerAnimated:YES completion:nil];
        } completionBlock:nil];
    } else {
        self.currentCapturedImage = [[GinStillImage alloc] init];
        self.currentCapturedImage.thumbImage = savedImage;
        self.captureView.capturedImageView.image = savedImage;
        
        [self updateImageCapturedUI:NO];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 获取点击位置
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    //设置有效区域
    CGRect effectiveArea = CGRectMake(0, self.captureView.topView.frame.size.height, self.captureView.cameraView.frame.size.width, self.captureView.cameraView.frame.size.height - self.captureView.topView.frame.size.height - self.captureView.controlView.frame.size.height);
    
    if (!CGRectContainsPoint(effectiveArea, point)) {
        return;
    }
    
    // 把当前位置转换为摄像头点上的位置
    CGPoint cameraPoint = [self.captureManager.preview captureDevicePointOfInterestForPoint:point];
    // 设置聚焦点光标位置
    [self setFocusCursorWithPoint:point];
    // 设置聚焦
    [self.captureManager focusWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
}



#pragma - Private Method

- (void)updateFlashModeUI
{
    if (self.captureManager.currentFlashMode > AVCaptureFlashModeAuto || self.captureManager.currentFlashMode < AVCaptureFlashModeOff) {
        self.captureManager.currentFlashMode = AVCaptureFlashModeOff;
    }
    switch (self.captureManager.currentFlashMode) {
        case AVCaptureFlashModeOn:
            [self.captureView.flashBtn setTitle:@"打开" forState:UIControlStateNormal];
            [self.captureView.flashBtn setImage:[UIImage imageNamed:@"flashlight_on"] forState:UIControlStateNormal];
            break;
        case AVCaptureFlashModeAuto:
            [self.captureView.flashBtn setTitle:@"自动" forState:UIControlStateNormal];
            [self.captureView.flashBtn setImage:[UIImage imageNamed:@"flashlight_on"] forState:UIControlStateNormal];
            break;
        default:
            [self.captureView.flashBtn setTitle:@"关闭" forState:UIControlStateNormal];
            [self.captureView.flashBtn setImage:[UIImage imageNamed:@"flashlight_off"] forState:UIControlStateNormal];
            break;
    }
    
    [self.captureManager switchFlashMode];
    
}

/**
 *  设置聚焦光标位置
 *
 *  @param point 光标位置
 */
- (void)setFocusCursorWithPoint:(CGPoint)point{
    self.captureView.focusCursorImageView.center = point;
    self.captureView.focusCursorImageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    self.captureView.focusCursorImageView.alpha = 1.0;
    
    [UIView animateWithDuration:1.0 animations:^{
        self.captureView.focusCursorImageView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.captureView.focusCursorImageView.alpha = 0;
    }];
}

@end
