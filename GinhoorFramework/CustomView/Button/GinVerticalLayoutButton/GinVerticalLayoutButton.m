//
//  GinTitleAndImageButton.m
//  demo4Button
//
//  Created by JunhuaShao on 15/3/25.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GinVerticalLayoutButton.h"
@interface GinVerticalLayoutButton()

@property (strong, nonatomic) UIView *selectedView;

@property (assign, nonatomic) CGSize titleSize;
@property (assign, nonatomic) CGSize imageSize;

@end

@implementation GinVerticalLayoutButton

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.adjustsImageWhenHighlighted = NO;
    self.adjustsImageWhenDisabled = NO;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.titleLabel setFont:[UIFont systemFontOfSize:12]];
    self.imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:self.selectedView];
}

- (void)layoutSubviews
{
    
    CGFloat one_px = 1.f/[UIScreen mainScreen].scale;
    
    self.selectedView.frame = //CGRectMake(0, self.imageTopOffset + self.imageView.bounds.size.height+5+20+5, self.bounds.size.width, 2);
    CGRectMake(- one_px, self.bounds.size.height - 2, self.bounds.size.width + 2 * one_px, 2);
    
    if (self.showSelectedView) {
        if (self.selected) {
            self.selectedView.hidden = NO;
        } else {
            self.selectedView.hidden = YES;
        }
    }
    [super layoutSubviews];
    
}

- (void)setImageTopOffset:(CGFloat)imageTopOffset
{
    _imageTopOffset = imageTopOffset;
    [self layoutIfNeeded];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, self.imageTopOffset, contentRect.size.width, self.imageSize.height);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, self.imageTopOffset + self.imageView.bounds.size.height+2, contentRect.size.width, 20);
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    self.imageSize = image.size;
    [super setImage:image forState:state];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    NSString *content = self.titleLabel.text;
    CGSize size = [content boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.bounds), 0)  options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
    self.titleSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
    
    [super setTitle:title forState:state];
}


- (void)setSelectedColor:(UIColor *)selectedColor
{
    _selectedColor = selectedColor;
    self.selectedView.backgroundColor = selectedColor;
}

- (UIView *)selectedView
{
    if (!_selectedView) {
        _selectedView = [[UIView alloc] init];
        _selectedView.backgroundColor = [UIColor lightGrayColor];
        _selectedView.hidden = YES;
    }
    return _selectedView;
}

@end
