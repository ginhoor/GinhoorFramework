//
//  ImageWithTitleCollectionCell.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/6/27.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "Masonry.h"
#import "ImageWithTitleCollectionCell.h"

@implementation ImageWithTitleCollectionCell


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
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.titleLabel];

    [self setConstraints];
}

// 设置 view 的初次约束
- (void)setConstraints
{
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.offset(5);
        make.size.sizeOffset(CGSizeMake(40, 40));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.offset(0);
        make.top.equalTo(self.imageView.mas_bottom).offset(5);
        make.left.offset(0);
        make.right.offset(0);
    }];
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.layer.cornerRadius = 20;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:0.600f green:0.600f blue:0.600f alpha:1.000f];
    }
    return _titleLabel;
}


@end
