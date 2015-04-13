//
//  UIView+FrameAdditions.m
//  TVHunting
//
//  Created by Ginhoor on 14-1-3.
//  Copyright (c) 2014年 Zhiping Software. All rights reserved.
//

#import "UIView+FrameAdditions.h"

@implementation UIView (FrameAdditions)

- (CGPoint)$origin {
    return self.frame.origin;
}

- (void)set$origin:(CGPoint)origin {
    self.frame = (CGRect) {.origin=origin, .size=self.frame.size};
}

- (CGFloat)$x {
    return self.frame.origin.x;
}

- (void)set$x:(CGFloat)x {
    self.frame = (CGRect) {.origin.x=x, .origin.y=self.frame.origin.y, .size=self.frame.size};
}

- (CGFloat)$y {
    return self.frame.origin.y;
}

- (void)set$y:(CGFloat)y {
    self.frame = (CGRect) {.origin.x=self.frame.origin.x, .origin.y=y, .size=self.frame.size};
}

- (CGSize)$size {
    return self.frame.size;
}

- (void)set$size:(CGSize)size {
    self.frame = (CGRect) {.origin=self.frame.origin, .size=size};
}

- (CGFloat)$width {
    return self.frame.size.width;
}

- (void)set$width:(CGFloat)width {
    self.frame = (CGRect) {.origin=self.frame.origin, .size.width=width, .size.height=self.frame.size.height};
}

- (CGFloat)$height {
    return self.frame.size.height;
}

- (void)set$height:(CGFloat)height {
    self.frame = (CGRect) {.origin=self.frame.origin, .size.width=self.frame.size.width, .size.height=height};
}

- (CGFloat)$left {
    return self.frame.origin.x;
}

- (void)set$left:(CGFloat)left {
    self.frame = (CGRect) {.origin.x=left, .origin.y=self.frame.origin.y, .size.width=fmaxf(self.frame.origin.x + self.frame.size.width - left, 0), .size.height=self.frame.size.height};
}

- (CGFloat)$top {
    return self.frame.origin.y;
}

- (void)set$top:(CGFloat)top {
    self.frame = (CGRect) {.origin.x=self.frame.origin.x, .origin.y=top, .size.width=self.frame.size.width, .size.height=fmaxf(self.frame.origin.y + self.frame.size.height - top, 0)};
}

- (CGFloat)$right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)set$right:(CGFloat)right {
    self.frame = (CGRect) {.origin=self.frame.origin, .size.width=fmaxf(right - self.frame.origin.x, 0), .size.height=self.frame.size.height};
}

- (CGFloat)$bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)set$bottom:(CGFloat)bottom {
    self.frame = (CGRect) {.origin=self.frame.origin, .size.width=self.frame.size.width, .size.height=fmaxf(bottom - self.frame.origin.y, 0)};
}

- (NSString *)rectInfo
{
    CGRect rect = self.frame;
    return [NSString stringWithFormat:@"%f,%f,%f,%f",rect.origin.x,rect.origin.y,rect.size.width,rect.size.height];
}

@end
