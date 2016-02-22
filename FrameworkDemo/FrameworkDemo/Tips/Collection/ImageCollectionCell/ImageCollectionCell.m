//
//  ImageCollectionCell.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/5/23.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "Masonry.h"
#import "ImageCollectionCell.h"

@implementation ImageCollectionCell


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
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

@end
