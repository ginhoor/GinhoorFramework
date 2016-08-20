//
//  ThemeManager.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/20.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LEETheme.h>

extern NSString * const kDefaultTheme;
extern NSString * const kNightTheme;

// Color
extern NSString * const kDefaultButtonBackgroundColor;
extern NSString * const kDefaultButtonTitleColor;

// Image
extern NSString * const kDefaultImage1;
extern NSString * const kDefaultImage2;

// Other
extern NSString * const kDefaultAlpha;

@interface ThemeManager : NSObject

+ (instancetype)sharedInstance;

@end
