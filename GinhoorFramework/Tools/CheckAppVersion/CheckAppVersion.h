//
//  CheckAppVersion.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/21.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface CheckAppVersion : NSObject

+ (void)checkInStore:(unsigned long)AppID onlyNewVersionAlert:(BOOL)onlyNewVersionAlert completion:(void(^)(BOOL hasNewVersion))completion;

+ (void)jumpToAppStore:(unsigned long)AppID completion:(void(^)())completion;


@end
