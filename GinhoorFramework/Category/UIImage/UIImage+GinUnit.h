//
//  UIImage+GinUnit.h
//  LOLBox
//
//  Created by Ginhoor on 14-8-16.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (GinUnit)

// 截取部分图片
- (void)savePartImage:(NSString *)path rect:(CGRect)r;

// 改变image的颜色（对单色image比较有用）
- (UIImage *)changeColor:(UIColor*)color;
// 获得纯色图片
+ (UIImage *)imageByColor:(UIColor *)color;
+ (UIImage *)imageByColor:(UIColor *)color size:(CGSize)imageSize;
// 灰度图片
- (UIImage *)getGrayImage;

// 缩放图片大小
- (UIImage *)scaleToSize:(CGSize)size;
- (UIImage *)scaleToSize:(CGSize)size maxQuality:(CGFloat)maxQuality;

- (UIImage *)scaleImageto:(CGFloat)scaleSize;
- (UIImage *)scaleImageByWidth:(CGFloat)width;

// 改变图片方向
- (UIImage *)changeOrientationTo:(UIImageOrientation)orientation;
// 解决保存图片或重绘图片后旋转90度的方法
- (UIImage *)fixOrientation;

// 压缩图片到指定文件大小
- (NSData *)compressToMaxDataSizeKBytes:(CGFloat)size maxQuality:(CGFloat)maxQuality;

// 裁剪图片到指定大小
- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;

// 圆角图片
- (UIImage *)addRoundedRectImageByRadius:(NSInteger)r;

@end
