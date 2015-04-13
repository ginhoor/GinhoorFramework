//
//  UIImage+GinUnit.h
//  LOLBox
//
//  Created by Ginhoor on 14-8-16.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GinUnit)

// 改变image的颜色（对单色image比较有用）
- (UIImage *)changeColor:(UIColor*)color;
// 获得纯色图片
+ (UIImage *)imageByColor:(UIColor *)color size:(CGSize)imageSize;
// 缩放图片大小
- (UIImage *)scaleToSize:(CGSize)size;
// 灰度图片
- (UIImage *)getGrayImage;



- (UIImage *)scaleImageto:(CGFloat)scaleSize;
- (UIImage *)scaleImageByWidth:(CGFloat)width;


@end
