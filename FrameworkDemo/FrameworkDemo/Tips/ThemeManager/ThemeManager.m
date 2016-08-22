//
//  ThemeManager.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/20.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "ThemeManager.h"

NSString * const kDefaultTheme = @"defaultTheme";
NSString * const kNightTheme = @"nightTheme";

NSString * const kDefaultButtonBackgroundColor = @"default_button_background";
NSString * const kDefaultButtonTitleColor = @"default_button_title";

NSString * const kDefaultImage1 = @"image1";
NSString * const kDefaultImage2 = @"image2";

NSString * const kDefaultAlpha = @"alpha";

@implementation ThemeManager

+ (void)load
{
    [super load];
    [ThemeManager sharedInstance];
}

+ (instancetype)sharedInstance
{
    static ThemeManager* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ThemeManager alloc] init];
    });

    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    // 加载默认主题
    NSString *jsonFilePath = [NSString stringWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"default_theme_config.json"] encoding:NSUTF8StringEncoding error:nil];
    
    [LEETheme addThemeConfigJson:jsonFilePath WithTag:kDefaultTheme WithResourcesPath:nil];
    
    // 加载夜间主题
    jsonFilePath = [NSString stringWithContentsOfFile:[[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:@"night_theme_config.json"] encoding:NSUTF8StringEncoding error:nil];
    [LEETheme addThemeConfigJson:jsonFilePath WithTag:kNightTheme WithResourcesPath:nil];

    //设置默认主题
    [LEETheme defaultTheme:kDefaultTheme];
    
    //设置默认改变主题的动画时长
//    [LEETheme defaultChangeThemeAnimationDuration:0.1f];
    
}

@end
