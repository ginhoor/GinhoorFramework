//
//  NSString+DEBUG.h
//  LOLBox
//
//  Created by JunhuaShao on 15/3/24.
//  Copyright (c) 2015年 Ginhoor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (GinDebug)

+ (NSString *)stringForSize:(CGSize)size;
+ (NSString *)stringForFrame:(CGRect)frame;

@end
