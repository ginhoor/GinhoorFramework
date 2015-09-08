//
//  NSDictionary+GinUnit.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/6/18.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>

#define isEmptyDictionary(dic) !dic || ((NSDictionary*)dic).allKeys.count == 0
#define isHasElementsDictionary(dic) dic && ((NSDictionary*)dic).allKeys.count > 0

@interface NSDictionary (GinUnit)

@end
