//
//  NSString+Size.h
//  LOLBox
//
//  Created by Ginhoor on 14-3-13.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//


#import <UIKit/UIKit.h>
@interface NSString (Size)

- (CGSize)getStringSizeWithfont:(UIFont *)font width:(CGFloat)width;
- (CGSize)getStringSizeWithWidth:(CGFloat)width attributes:(NSDictionary *)attributes;

- (CGSize)getStringSizeWithfont:(UIFont *)font height:(CGFloat)height;

@end
