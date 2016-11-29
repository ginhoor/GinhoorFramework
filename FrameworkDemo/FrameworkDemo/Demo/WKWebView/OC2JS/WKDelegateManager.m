//
//  WKDelegateManager.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 2016/11/29.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "WKDelegateManager.h"

@implementation WKDelegateManager


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    if ([self.delegate respondsToSelector:@selector(userContentController:didReceiveScriptMessage:)]) {
        [self.delegate userContentController:userContentController didReceiveScriptMessage:message];
    }
}

@end
