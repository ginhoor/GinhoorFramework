//
//  GinLoggerManager.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/22.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import <CocoaLumberjack/CocoaLumberjack.h>

@interface GinLoggerManager : NSObject

+ (instancetype)sharedInstance;

- (void)setupDDLog;

@end
