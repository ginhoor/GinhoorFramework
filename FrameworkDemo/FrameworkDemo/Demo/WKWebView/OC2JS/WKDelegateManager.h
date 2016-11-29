//
//  WKDelegateManager.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 2016/11/29.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>

/**
    http://www.cocoachina.com/ios/20161121/18142.html
    直接将delegate指向自己，会出现无法释放的 retian cycle 
 */
@interface WKDelegateManager : NSObject <WKScriptMessageHandler>

@property (weak, nonatomic) id<WKScriptMessageHandler> delegate;

@end
