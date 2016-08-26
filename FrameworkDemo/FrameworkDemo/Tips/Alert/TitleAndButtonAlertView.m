//
//  VehicleSelectedAlertView.m
//  WeAreInspector
//
//  Created by JunhuaShao on 16/8/26.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "TitleAndButtonAlertView.h"
#import <Masonry.h>
@implementation TitleAndButtonAlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    NSAssert(NO, @"必须使用 - (instancetype)initWithFrame:(CGRect)frame 初始化");
    
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.cancleButton];
    [self addSubview:self.submitButton];
    
    [self setConstraints];
}
// 设置 view的初次约束
- (void)setConstraints
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.offset(40);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.cancleButton.mas_top).offset(-20);
    }];
    
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.right.equalTo(self.submitButton.mas_left);
        make.bottom.offset(0);
        make.size.sizeOffset(CGSizeMake(self.frame.size.width/2, 50));
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(0);
        make.bottom.equalTo(self.cancleButton);
        make.size.equalTo(self.cancleButton);
    }];
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.0f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _titleLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.font = [UIFont systemFontOfSize:14.0f];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return _contentLabel;
}

- (UIButton *)submitButton
{
    if (!_submitButton) {
        _submitButton = [[UIButton alloc]init];
        [_submitButton setTitle:@"确定" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _submitButton;
}

- (void)submitAction:(id)sender
{
    if (self.submitActionBlock) {
        self.submitActionBlock();
    }
}

- (UIButton *)cancleButton
{
    if (!_cancleButton) {
        _cancleButton = [[UIButton alloc]init];
        [_cancleButton setTitle:@"返回" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _cancleButton;
}

- (void)cancelAction:(id)sender
{
    if (self.cancleActionBlock) {
        self.cancleActionBlock();
    }
}




@end
