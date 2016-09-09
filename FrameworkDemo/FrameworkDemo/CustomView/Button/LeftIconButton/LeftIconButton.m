//
//  LeftIconButton.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/6/1.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "LeftIconButton.h"

@implementation LeftIconButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

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
    self.backgroundColor = [UIColor whiteColor];
  
    self.textLabelOffset = CGPointZero;
    self.leftImageOffset = CGPointZero;
        
    self.adjustsImageWhenHighlighted = NO;
    self.adjustsImageWhenDisabled = NO;
}


- (CGRect)contentRectForBounds:(CGRect)bounds
{
    CGRect frame = [super contentRectForBounds:bounds];

    return frame;
}



- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGRect frame = [super contentRectForBounds:contentRect];
    UIImage *image = [self imageForState:UIControlStateNormal];
    
    CGSize imageSize = CGSizeEqualToSize(CGSizeZero, self.leftImageSize)?image.size:self.leftImageSize;
    
    CGRect leftFrame = CGRectMake(frame.origin.x, (frame.size.height - imageSize.height)/2, imageSize.width, imageSize.height);

    leftFrame = CGRectOffset(leftFrame, self.leftImageOffset.x, self.leftImageOffset.y);
    
    return leftFrame;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGRect frame = [super titleRectForContentRect:contentRect];
    CGRect leftFrame = [self imageRectForContentRect:contentRect];
    
    return CGRectMake(leftFrame.origin.x+leftFrame.size.width+self.textLabelOffset.x, frame.origin.y+self.textLabelOffset.y, frame.size.width, frame.size.height);
}







@end
