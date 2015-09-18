//
//  BaseTitleHeader.m
//  LOLBox
//
//  Created by Ginhoor on 14-3-5.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "GinBaseTitleHeader.h"

@implementation GinBaseTitleHeader

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
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake(20, 0, self.frame.size.width-20, self.frame.size.height);
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

@end
