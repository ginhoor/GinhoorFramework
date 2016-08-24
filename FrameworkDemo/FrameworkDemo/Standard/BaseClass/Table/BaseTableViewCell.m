//
//  BaseTableViewCell.m
//  shuangdaojia
//
//  Created by JunhuaShao on 15/5/24.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "BaseTableViewCell.h"
#import <Masonry/Masonry.h>


@interface BaseTableViewCell ()

@end

@implementation BaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self && [self conformsToProtocol:@protocol(GinBaseTableCell)]) {
        [self setupCell];
    } else {
        NSAssert(NO, @"子类必须要实现GinBaseTableCell这个protocol。");
    }
    return self;
}

- (void)setupCell
{
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.cellContentView];
    [self setCellConstraints];
}

// 设置 view 的初次约束
- (void)setCellConstraints
{
    [self.cellContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}


- (UIView *)cellContentView
{
    if (!_cellContentView) {
        _cellContentView = [[UIView alloc] init];
        _cellContentView.backgroundColor = [UIColor whiteColor];
    }
    return _cellContentView;
}

@end
