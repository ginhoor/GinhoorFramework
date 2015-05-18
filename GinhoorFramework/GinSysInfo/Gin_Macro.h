//
//  NSObject_Gin_Prefix.h
//  LOLBook
//
//  Created by Ginhoor on 13-5-25.
//  Copyright (c) 2013年 ginhoor_home. All rights reserved.
//

#import "AppDelegate.h"

///////////////////////////////////////////
// Device & OS
//////////////////////////////////////////
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#define ONE_PHYSICAL_PX 1.f/[UIScreen mainScreen].scale

#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define isRetina ([UIScreen mainScreen].scale > 1.0f)

#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define isPad     ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define isPhone   ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

//tmp 目录
#define TMP_PATH [NSHomeDirectory() stringByAppendingPathComponent:@"tmp"]


///////////////////////////////////////////
// G C D
//////////////////////////////////////////

#define DO_IN_BACKGROUND(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)

#define DO_IN_MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

#define DO_AFTER(delayInSeconds,block) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);

///////////////////////////////////////////
// Object
//////////////////////////////////////////

//user defaults
#define USER_DEFAULTS ([NSUserDefaults standardUserDefaults])
//file manager
#define FILE_MANAGER ([NSFileManager defaultManager])
//notification center
#define NOTIFICATION_CENTER ([NSNotificationCenter defaultCenter])
//UIApplication
#define APP_DELEGATE ((AppDelegate*)[[UIApplication sharedApplication] delegate])


///////////////////////////////////////////
// Category
///////////////////////////////////////////

// 格式化字符串
#define ComboString(string, args...)[NSString stringWithFormat:string,args]
#define AppendString(str1,str2)     [NSString stringWithFormat:@"%@%@",str1,str2]
//image
#define ImageByName(name)           [UIImage imageNamed:name]
#define UIColorFromRGBA(r,g,b,a)    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define PointValue(x,y) [NSValue valueWithCGPoint:CGPointMake(x, y)]

///////////////////////////////////////////
// degrees/radian
///////////////////////////////////////////

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIAN_TO_DEGREES(radian) (radian*180.0)/(M_PI)

///////////////////////////////////////////
// TODO
///////////////////////////////////////////

#define STRINGIFY(S) #S
#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
//延时展开一次
#define DEFER_STRINGIFY(S) STRINGIFY(S)

#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "]" MSG "\n" \
DEFER_STRINGIFY(__FILE__) "\n" \
" line " DEFER_STRINGIFY(__LINE__)
#define KEYWORDIFY try{} @catch (...) {}

#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))


