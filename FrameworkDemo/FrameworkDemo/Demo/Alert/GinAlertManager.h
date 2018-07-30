//
//  GinAlertManager.h
//  WeAreInspector
//
//  Created by JunhuaShao on 16/8/26.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GinAlertManager : NSObject

+ (instancetype)sharedInstance;

- (void)showTitle:(NSString *)title content:(NSString *)content submit:(void(^)(void))submitBlock cancel:(void(^)(void)) cancelBlock;

@end
