//
//  CheckAppVersion.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/21.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "CheckAppVersion.h"
#import "UIAlertView+GinUnit.h"
#import "NSString+Json.h"
@implementation CheckAppVersion


+ (void)checkInStore:(unsigned long)AppID needAllTips:(BOOL)needAllTips;
{
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:@"CheckAppVersion"];
    
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    if (version && [version isEqualToString:appVersion]) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        //CFShow((__bridge CFTypeRef)(infoDic));
        NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
        
        NSString *URL = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%lu",AppID];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:URL]];
        [request setHTTPMethod:@"POST"];
        NSHTTPURLResponse *urlResponse = nil;
        NSError *__autoreleasing error = nil;
        NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        
        NSString *results = [[NSString alloc] initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [results jsonDictionary];
        NSArray *infoArray = [dic objectForKey:@"results"];
        if ([infoArray count]) {
            NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
            NSString *lastVersion = [releaseInfo objectForKey:@"version"];
            
            if ([lastVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
                NSString *releaseNotes = [releaseInfo objectForKey:@"releaseNotes"];
                dispatch_async(dispatch_get_main_queue(),^{
                    
                    [UIAlertView alertView:@"有新版本" message:releaseNotes submitTitle:@"更新" submitBlock:^{
                        NSString *trackViewUrl = [releaseInfo objectForKey:@"trackViewUrl"];
                        NSURL *url = [NSURL URLWithString:trackViewUrl];
                        [[UIApplication sharedApplication]openURL:url];
                        [[NSUserDefaults standardUserDefaults] setObject:appVersion forKey:@"CheckAppVersion"];
                    } cancelTitle:@"取消" cancelBlock:^{
                        [[NSUserDefaults standardUserDefaults] setObject:appVersion forKey:@"CheckAppVersion"];
                    }];
                });
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(),^{
                    if (needAllTips) {
                        [UIAlertView alertView:@"版本检测" message:@"此版本为最新版本" cancelTitle:@"确认" cancelBlock:^{}];
                    }
                });
            }
        }
    });
}

+ (void)jumpToAppStore:(unsigned long)AppID
{
    //    [SVProgressHUD showWithStatus:@"页面跳转中" maskType:SVProgressHUDMaskTypeBlack];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *URL = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%lu",AppID];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:URL]];
        [request setHTTPMethod:@"POST"];
        NSHTTPURLResponse *urlResponse = nil;
        NSError *__autoreleasing error = nil;
        NSData *recervedData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        
        NSString *results = [[NSString alloc] initWithBytes:[recervedData bytes] length:[recervedData length] encoding:NSUTF8StringEncoding];
        NSDictionary *dic = [results jsonDictionary];
        NSArray *infoArray = [dic objectForKey:@"results"];
        
        NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
        NSString *trackViewUrl = [releaseInfo objectForKey:@"trackViewUrl"];
        NSURL *url = [NSURL URLWithString:trackViewUrl];
        [[UIApplication sharedApplication] openURL:url];
        
        //        DO_IN_MAIN(^{
        //            [SVProgressHUD dismiss];
        //        });
    });
}

@end
