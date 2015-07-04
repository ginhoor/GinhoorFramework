//
//  IconTableCell.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/6/15.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "IconTableCell.h"

@interface IconTableCell()
@property (strong, nonatomic) UIImageView *iconImageView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *indicator;
@property (strong, nonatomic) UIView *separator;

@end

@implementation IconTableCell


- (void)setup
{
    [super setup];
    
    [self.cellContentView addSubview:self.iconImageView];
    [self.cellContentView addSubview:self.titleLabel];
    [self.cellContentView addSubview:self.indicator];
    [self.cellContentView addSubview:self.separator];

    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
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
        make.height.offset(ONE_PHYSICAL_PX);
    }];
    
    [super updateConstraints];
}

- (void)setIcon:(UIImage *)image title:(NSAttributedString *)title showIndicator:(BOOL)showIndicator showSeparator:(BOOL)showSeparator
{
    self.iconImageView.image = image;
    self.titleLabel.attributedText = title;
    
    self.indicator.hidden = !showIndicator;
    self.separator.hidden = !showSeparator;
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
        _indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"list_icon_arrow_44x44"]];
    }
    return _indicator;
}

- (UIView *)separator
{
    if (!_separator) {
        _separator = [[UIView alloc] init];
        _separator.backgroundColor = [UIColor lightGrayColor];
        _separator.hidden = YES;
    }
    return _separator;
}


+ (CGFloat)viewHeight
{
    return 50;
}

@end
