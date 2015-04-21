//
//  CheckAppVersion.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/21.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "CheckAppVersion.h"
#import "GinPopup+Unit.h"
#import "NSString+Json.h"
@implementation CheckAppVersion

+ (void)checkInStore:(BOOL)needAllTips AppID:(unsigned long)AppID
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        //CFShow((__bridge CFTypeRef)(infoDic));
        NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
        
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
                    
                    [GinPopup showTitle:@"有新版本更新" text:releaseNotes submitButton:@"更新" onClick:^{
                        NSString *trackViewUrl = [releaseInfo objectForKey:@"trackViewUrl"];
                        NSURL *url = [NSURL URLWithString:trackViewUrl];
                        [[UIApplication sharedApplication]openURL:url];
                    }];
                });
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(),^{
                    if (needAllTips) {
                        [GinPopup showTitle:@"此版本为最新版本" text:@"启禀陛下，当前确是最新版本！"];
                    }
                });
            }
        }
    });
}

+ (void)jumpToAppStore:(unsigned long)App_ID
{
    //    [SVProgressHUD showWithStatus:@"页面跳转中" maskType:SVProgressHUDMaskTypeBlack];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *URL = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%lu",App_ID];
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
