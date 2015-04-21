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

+ (void)checkInStore:(BOOL)needAllTips AppID:(unsigned long)AppID;

+ (void)jumpToAppStore:(unsigned long)App_ID;


@end
