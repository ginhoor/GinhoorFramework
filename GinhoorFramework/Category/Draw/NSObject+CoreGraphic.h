//
//  NSObject+CoreGraphic.h
//  LOLBox
//
//  Created by JunhuaShao on 15/4/2.
//  Copyright (c) 2015年 Ginhoor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSObject (CoreGraphic)

- (UIImage *)maskImage:(CGRect)rect clearRect:(CGRect)clearRect custom:(void (^)(CGRect frame,CGRect clearRect))customBlock;

- (void)drawLine:(CGPoint)start end:(CGPoint)end lineWidth:(CGFloat)lineWitdh LineColor:(UIColor *)color;

@end
