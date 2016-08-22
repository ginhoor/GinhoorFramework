//
//  BaseTableViewCell.m
//  shuangdaojia
//
//  Created by JunhuaShao on 15/5/24.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.cellContentView];
}


- (UIView *)cellContentView
{
    if (!_cellContentView) {
        _cellContentView = [[UIView alloc] init];
        _cellContentView.backgroundColor = [UIColor whiteColor];
    }
    return _cellContentView;
}

+ (CGFloat)viewHeight
{
    return 150;
}

@end
