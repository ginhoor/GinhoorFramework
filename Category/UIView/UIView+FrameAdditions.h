//
//  UIView+FrameAdditions.h
//  TVHunting
//
//  Created by Ginhoor on 14-1-3.
//  Copyright (c) 2014年 Zhiping Software. All rights reserved.
//

@import UIKit;

@interface UIView (FrameAdditions)

@property (nonatomic, assign) CGPoint $origin;
@property (nonatomic, assign) CGSize  $size;
@property (nonatomic, assign) CGFloat $x, $y, $width, $height; // normal rect properties
@property (nonatomic, assign) CGFloat $left, $top, $right, $bottom; // these will stretch the rect

- (NSString *)rectInfo;

@end
