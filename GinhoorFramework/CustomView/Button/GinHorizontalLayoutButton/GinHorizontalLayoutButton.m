//
//  GinHorizontalLayoutButton.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/6/26.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GinHorizontalLayoutButton.h"

@interface GinHorizontalLayoutButton()
@property (assign, nonatomic) CGSize titleSize;
@property (assign, nonatomic) CGSize imageSize;
@end

@implementation GinHorizontalLayoutButton

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
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)layoutSubviews
{
    [self updateTitleSize:self.titleLabel.text];
    [super layoutSubviews];
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    if (self.type == GinHorizontalAlignmentTypeLeft) {
        return CGRectMake(0, 0, self.imageSize.width, contentRect.size.height);
    } else {
        return CGRectMake(self.titleSize.width+5, 0, self.imageSize.width, contentRect.size.height);
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    if (self.type == GinHorizontalAlignmentTypeLeft) {
        return CGRectMake(self.imageSize.width+5,0, self.titleSize.width, contentRect.size.height);
    } else {
        return CGRectMake(0,0, self.titleSize.width, contentRect.size.height);
    }
    
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    self.imageSize = image.size;
    [super setImage:image forState:state];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [self updateTitleSize:self.titleLabel.text];
    [super setTitle:title forState:state];
}

- (void)updateTitleSize:(NSString *)content
{
    CGSize size = [content boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.bounds), 0)  options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil].size;
    
    self.titleSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
}
@end
