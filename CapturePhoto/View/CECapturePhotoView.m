//
//  CECapturePhotoView.m
//  CarEagle
//
//  Created by JunhuaShao on 2017/4/24.
//  Copyright © 2017年 CarEagle. All rights reserved.
//

#import "CECapturePhotoView.h"
#import <Masonry/Masonry.h>

@implementation CECapturePhotoView


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
    [self setupViews];

}

- (void)setupViews
{
    //取景
    [self addSubview:self.cameraView];
    [self addSubview:self.capturedImageView];
    
    //头部View
    [self addSubview:self.topView];
    [self.topView addSubview:self.deviceBtn];
    [self.topView addSubview:self.flashBtn];
    [self.topView addSubview:self.photoLibraryBtn];
    
    //底部View
    [self addSubview:self.controlView];
    //取消
    [self.controlView addSubview:self.cancelBtn];
    //拍照
    [self.controlView addSubview:self.cameraBtn];
    
    //完成
    [self.controlView addSubview:self.doneBtn];
    
    [self addSubview:self.focusCursorImageView];
    
    [self setConstraints];
}

// 设置 view 的初次约束
- (void)setConstraints
{
    //顶部
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(60);
    }];
    
    [self.flashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(10);
        make.bottom.offset(0);
        make.width.offset(80);
    }];
    
    [self.deviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.flashBtn);
        make.right.offset(-10);
        make.bottom.offset(0);
        make.width.offset(40);
    }];
    
    [self.photoLibraryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.flashBtn);
        make.centerX.offset(0);
        make.bottom.offset(0);
        make.width.offset(40);
    }];
    
    //底部
    [self.controlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
        make.height.offset(80);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.top.offset(0);
        make.bottom.offset(0);
        make.width.offset(120);
    }];
    
    [self.cameraBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.size.sizeOffset(CGSizeMake(67, 67));
    }];
    
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-25);
        make.top.offset(0);
        make.bottom.offset(0);
        make.width.offset(120);
    }];
    
    //取景
    [self.cameraView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [self.capturedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
}

#pragma - Getter & Setter

- (UIView *)cameraView
{
    if (!_cameraView) {
        _cameraView = [[UIView alloc] init];
        _cameraView.backgroundColor = [UIColor clearColor];
    }
    return _cameraView;
}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _topView;
}

- (UIButton *)photoLibraryBtn
{
    if (!_photoLibraryBtn) {
        _photoLibraryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _photoLibraryBtn.backgroundColor = [UIColor clearColor];
        [_photoLibraryBtn setTitle:@"相册" forState:UIControlStateNormal];
    }
    return _photoLibraryBtn;
}

- (UIButton *)deviceBtn
{
    if (!_deviceBtn) {
        _deviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deviceBtn setImage:[UIImage imageNamed:@"camera_cut"] forState:UIControlStateNormal];
        _deviceBtn.backgroundColor = [UIColor clearColor];
    }
    return _deviceBtn;
}

- (UIButton *)flashBtn
{
    if (!_flashBtn) {
        _flashBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_flashBtn setImage:[UIImage imageNamed:@"flashlight_off"] forState:UIControlStateNormal];
        _flashBtn.backgroundColor = [UIColor clearColor];
        [_flashBtn setTitle:@"关闭" forState:UIControlStateNormal];
    }
    return _flashBtn;
}

- (UIView *)controlView
{
    if (!_controlView) {
        _controlView = [[UIView alloc] init];
        _controlView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _controlView;
}

- (UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
            }
    return _cancelBtn;
}

- (UIButton *)cameraBtn
{
    if (!_cameraBtn) {
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cameraBtn.showsTouchWhenHighlighted = YES;
        _cameraBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_cameraBtn setImage:[UIImage imageNamed:@"camera_shutter"] forState:UIControlStateNormal];
    }
    return _cameraBtn;
}

- (UIButton *)doneBtn
{
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_doneBtn setTitle:@"完成" forState:UIControlStateNormal];
        _doneBtn.alpha = 0;
    }
    return _doneBtn;
}

- (UIImageView *)capturedImageView
{
    if (!_capturedImageView) {
        _capturedImageView = [[UIImageView alloc] init];
        _capturedImageView.alpha = 0;
    }
    return _capturedImageView;
}

- (UIImageView *)focusCursorImageView
{
    if (!_focusCursorImageView) {
        _focusCursorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"focus"]];
        _focusCursorImageView.alpha = 0;        
    }
    return _focusCursorImageView;
}


@end
