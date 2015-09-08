//
//  NSString+GinUnit.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/7.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>

// 格式化字符串
#define ComboString(string, args...)[NSString stringWithFormat:string,args]
#define AppendString(str1,str2)     [NSString stringWithFormat:@"%@%@",str1,str2]

#define isBlankString(string) (string==nil || string==NULL || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)

@interface NSString (GinUnit)

- (BOOL)isImageType;
- (BOOL)isGif;


@end
