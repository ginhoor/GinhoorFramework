//
//  Demo4ExtendMenuCell.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/24.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "DynomicHeightCell.h"
#import <Masonry/Masonry.h>

@interface DynomicHeightCell ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;

@end

@implementation DynomicHeightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup
{
    self.backgroundColor = [UIColor redColor];
    self.cellContentView.backgroundColor = [UIColor orangeColor];
    
    [self.cellContentView addSubview:self.button];
    [self.cellContentView addSubview:self.label];
    
    [self setConstraints];
}

// 设置 view 的初次约束
- (void)setConstraints
{
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(100);
        make.size.sizeOffset(CGSizeMake(120, 50));
    }];
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button.mas_bottom).offset(20);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(20);
    }];
    
}

- (UIButton *)button
{
    if (!_button) {
        _button = [[UIButton alloc]init];
        [_button setTitle:@"测试按钮" forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)btnClick:(id)sender
{
//    [self.cellContentView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.height.offset(400);
//    }];
//    
    
    [self.label mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.button.mas_bottom).offset(20);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(20);
        make.height.offset(300);
    }];
    
    if (self.btnClickBlock) {
        self.btnClickBlock();
    }
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc]init];
        _label.backgroundColor = [UIColor clearColor];
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont systemFontOfSize:14.0f];
        _label.numberOfLines = 0;
        _label.text = @"herehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehereherehere";
    }
    return _label;
}

+ (CGFloat)viewHeight
{
    return 250;
}


@end
