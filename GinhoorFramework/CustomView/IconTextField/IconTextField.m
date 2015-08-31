//
//  IconTextField.m
//  demo4UITextField
//
//  Created by JunhuaShao on 15/6/1.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "IconTextField.h"

@implementation IconTextField


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
    self.borderStyle = UITextBorderStyleNone;
    self.textContentInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    self.leftImageOffset = CGPointMake(10, 0);
    self.leftImageSize = CGSizeZero;
}

- (void)addLeftImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];

    self.leftView = imageView;
    self.leftView.contentMode = UIViewContentModeScaleAspectFit;
    self.leftView.clipsToBounds = YES;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setLeftImage:(void(^)(UIImageView *imageView))settingBlock
{
    if (settingBlock) {
        settingBlock((UIImageView*)self.leftView);
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect frame;
    if (self.leftView && self.leftViewMode != UITextFieldViewModeNever) {
        CGRect leftFrame = [self leftViewRectForBounds:bounds];

        CGFloat xOffset = leftFrame.origin.x+leftFrame.size.width;

        CGRect newFrame = CGRectMake(xOffset, bounds.origin.y, bounds.size.width - (xOffset), bounds.size.height);
        
        frame = UIEdgeInsetsInsetRect(newFrame, self.textContentInsets);
    } else {
        frame = UIEdgeInsetsInsetRect([super textRectForBounds:bounds], self.textContentInsets);
    }
    return frame;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}


- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return [self textRectForBounds:bounds];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds
{
    UIImageView *imageView = (UIImageView *)self.leftView;
    
    CGSize imageSize = CGSizeEqualToSize(CGSizeZero, self.leftImageSize)?imageView.image.size:self.leftImageSize;
    
    CGRect leftFrame = CGRectMake(0, (bounds.size.height - imageSize.height)/2, imageSize.width, imageSize.height);
    
    leftFrame = CGRectOffset(leftFrame, self.leftImageOffset.x, self.leftImageOffset.y);
    
    return leftFrame;
}


@end
