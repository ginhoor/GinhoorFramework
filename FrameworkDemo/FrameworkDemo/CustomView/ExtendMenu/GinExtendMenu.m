//
//  GinExtendMenu.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/5/22.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GinExtendMenu.h"
#import "Masonry.h"

@interface GinExtendMenu()

@property (strong, nonatomic) UIButton *extendButton;

@end

@implementation GinExtendMenu

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.contentViewHeight = 100;
    [self addSubview:self.extendButton];
    [self addSubview:self.contentView];
    
    [self setConstraints];
}

// 设置 view 的初次约束
- (void)setConstraints
{
    [self.extendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(44);
        make.bottom.equalTo(self.contentView.mas_top);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.extendButton.mas_bottom);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(0);
    }];
}

- (UIButton *)extendButton
{
    if (!_extendButton) {
        _extendButton = [[UIButton alloc] init];

        [_extendButton addTarget:self action:@selector(extendAction:) forControlEvents:UIControlEventTouchUpInside];
        [_extendButton setTitle:@"点击打开" forState:UIControlStateNormal];
        [_extendButton setTitle:@"点击收起" forState:UIControlStateSelected];
    }
    return _extendButton;
}

- (void)extendAction:(id)sender
{
//    NSAssert(self.isExtendedBlock, @"isExtendedBlock is nil");
    
    self.extended = self.isExtendedBlock?self.isExtendedBlock():NO;
    
    if (self.extendedCompletedBlock) {
        self.extendedCompletedBlock(self.extended);
    }
}

- (void)setExtended:(BOOL)extended
{
    _extended = extended;

    if (extended) {
        
        [UIView animateWithDuration:0.15 animations:^{
            [self animateExtended:YES animated:YES];
        }];
    } else {
        [UIView animateWithDuration:0.15 animations:^{
            [self animateExtended:NO animated:YES];
        }];
    }
    self.extendButton.selected = extended;
}

- (void)animateExtended:(BOOL)extended animated:(BOOL)animated
{
    if (extended) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(40 + self.contentViewHeight);
        }];

        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(self.contentViewHeight);
        }];
    } else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(40);
        }];

        [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
        }];
    }
    if (animated) {
        [self layoutIfNeeded];
        [self.contentView layoutIfNeeded];
    }
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

@end
