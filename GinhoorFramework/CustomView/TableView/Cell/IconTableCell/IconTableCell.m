//
//  IconTableCell.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/6/15.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "IconTableCell.h"

@interface IconTableCell()

@end

@implementation IconTableCell


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
    
    [self.cellContentView addSubview:self.iconImageView];
    [self.cellContentView addSubview:self.titleLabel];
    [self.cellContentView addSubview:self.indicator];
    [self.cellContentView addSubview:self.separator];

    [self setConstraints];
}


// 设置 view 的初次约束
- (void)setConstraints
{
    [self.cellContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.offset(15);
        make.size.sizeOffset(CGSizeMake(40, 40));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.right.equalTo(self.indicator.mas_left).offset(-5);
    }];
    
    [self.indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-10);
        make.centerY.offset(0);
        make.size.sizeOffset(CGSizeMake(44, 44));
    }];
    
    [self.separator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.left.offset(15);
        make.right.offset(-15);
        make.height.offset(1.f/[UIScreen mainScreen].scale);
    }];
}

- (void)setIcon:(UIImage *)image title:(NSAttributedString *)title showIndicator:(BOOL)showIndicator showSeparator:(BOOL)showSeparator
{
    self.iconImageView.image = image;
    self.titleLabel.attributedText = title;
    
    self.indicator.hidden = !showIndicator;
    self.separator.hidden = !showSeparator;
}

- (UIView *)cellContentView
{
    if (!_cellContentView) {
        _cellContentView = [[UIView alloc] init];
        _cellContentView.backgroundColor = [UIColor whiteColor];
    }
    return _cellContentView;
}
- (UIImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

- (UIImageView *)indicator
{
    if (!_indicator) {
        _indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_indicator_arrow"]];
    }
    return _indicator;
}

- (UIView *)separator
{
    if (!_separator) {
        _separator = [[UIView alloc] init];
        _separator.backgroundColor = [UIColor colorWithRed:0.945f green:0.945f blue:0.945f alpha:1.000f];
        _separator.hidden = YES;
    }
    return _separator;
}


+ (CGFloat)viewHeight
{
    return 50;
}

@end
