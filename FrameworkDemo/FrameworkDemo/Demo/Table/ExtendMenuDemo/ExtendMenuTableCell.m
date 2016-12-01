//
//  ExtendMenuCell.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/24.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//
#import <Masonry.h>

#import "ExtendMenuTableCell.h"

@interface ExtendMenuTableCell ()
@property (nonatomic, strong) UIButton *button;
@end

@implementation ExtendMenuTableCell

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
    self.cellContentView.backgroundColor = [UIColor orangeColor];
    
    [self.cellContentView addSubview:self.button];
    [self setConstraints];
}

// 设置 view 的初次约束
- (void)setConstraints
{
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.left.offset(40);
        make.size.sizeOffset(CGSizeMake(120, 40));
    }];
}


- (UIButton *)button
{
    if (!_button) {
        _button = [[UIButton alloc]init];
        [_button setTitle:@"电机按钮" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(butnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _button;
}

- (void)butnClick:(id)sender
{
    if (self.buttonClickBlock) {
        self.buttonClickBlock();
    }
}


+ (CGFloat)viewHeight
{
    return 0;
}

@end
