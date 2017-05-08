//
//  CECapturePhotoView.h
//  CarEagle
//
//  Created by JunhuaShao on 2017/4/24.
//  Copyright © 2017年 CarEagle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CECapturePhotoView : UIView

// 顶部View
@property (strong, nonatomic) UIView *topView;
@property (strong, nonatomic) UIButton *deviceBtn;
@property (strong, nonatomic) UIButton *flashBtn;
@property (strong, nonatomic) UIButton *photoLibraryBtn;

// 取景View
@property (strong, nonatomic) UIView *cameraView;
@property (strong, nonatomic) UIImageView *capturedImageView;

// 底部View
@property (strong, nonatomic) UIView *controlView;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) UIButton *cameraBtn;
@property (strong, nonatomic) UIButton *doneBtn;

// 聚焦View
@property (strong, nonatomic) UIImageView *focusCursorImageView;


@end
