//
//  BaseNoContentCell.m
//  LOLBox
//
//  Created by Ginhoor on 14-1-16.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "GinBaseNoContentTabCell.h"

@interface GinBaseNoContentTabCell()


@end

@implementation GinBaseNoContentTabCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
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
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.noContentTipLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.noContentTipLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
}


- (UILabel *)noContentTipLabel
{
    if (!_noContentTipLabel) {
        _noContentTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 260, 20)];
        _noContentTipLabel.text = @"无法获得内容，请下拉刷新!";
        _noContentTipLabel.textAlignment = NSTextAlignmentCenter;
        _noContentTipLabel.numberOfLines = 0;
    }
    return _noContentTipLabel;
}

+ (CGSize)cellSize
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 120);
}


@end