//
//  BaseTitleSectionView.m
//  LOLBox
//
//  Created by Ginhoor on 14-3-15.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "BaseTitleSectionView.h"

@interface BaseTitleSectionView()
@property (strong, nonatomic) UILabel *titleLabel;
@end

@implementation BaseTitleSectionView

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
    self.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self addSubview:self.titleLabel];
    [self setupViewsLayout];
}

- (void)setupViewsLayout
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(5, 20, 5, 10));
    }];
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
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
