//
//  TextCollectionCell.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/6/26.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Masonry.h>
#import "TextCollectionCell.h"

@implementation TextCollectionCell

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
    self.backgroundColor = [UIColor clearColor];

    [self.contentView addSubview:self.textLabel];
    
    self.textLabel.backgroundColor = [UIColor whiteColor];
    self.textLabel.layer.cornerRadius = 4;
    self.textLabel.layer.masksToBounds = YES;
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _textLabel;
}

@end
