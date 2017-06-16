//
//  CheckAppVersion.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/21.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "CheckAppVersion.h"
#import "NSString+GinJSON.h"
#import "UIAlertController+GinUnit.h"

@implementation CheckAppVersion

+ (void)checkInStore:(unsigned long)AppID onlyNewVersionAlert:(BOOL)onlyNewVersionAlert completion:(void(^)(BOOL hasNewVersion))completion;
{
    NSString *version = [[NSUserDefaults standardUserDefaults] objectForKey:@"CheckAppVersion"];
    
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    if (version && [version isEqualToString:appVersion]) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
        
        NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
        
        NSString *URL = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%lu",AppID];
        
        [self requestByUrl:[NSURL URLWithString:URL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (!data) {
                return;
            }
            NSDictionary *JSONData = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];

            NSArray *infoArray = [JSONData objectForKey:@"results"];
            if ([infoArray count]) {
                NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
                NSString *lastVersion = [releaseInfo objectForKey:@"version"];
                
                if ([lastVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
                    
                    NSString *releaseNotes = [releaseInfo objectForKey:@"releaseNotes"];
                    
                    dispatch_async(dispatch_get_main_queue(),^{
                        [UIAlertController alert:@"有新版本" message:releaseNotes submitTitle:@"更新" submitBlock:^{
                            
                            NSString *trackViewUrl = [releaseInfo objectForKey:@"trackViewUrl"];
                            NSURL *url = [NSURL URLWithString:trackViewUrl];
                            [[UIApplication sharedApplication]openURL:url];
                            [[NSUserDefaults standardUserDefaults] setObject:appVersion forKey:@"GinCheckAppVersion"];
                            
                        } cancelTitle:@"取消" cancelBlock:^{
                            [[NSUserDefaults standardUserDefaults] setObject:appVersion forKey:@"GinCheckAppVersion"];
                        } completionBlock:^{
                            if (completion) {
                                completion(YES);
                            }
                        }];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(),^{
                        if (!onlyNewVersionAlert) {
                            [UIAlertController alert:@"版本检测" message:@"此版本为最新版本" cancelTitle:@"确认" cancelBlock:nil completionBlock:^{
                                if (completion) {
                                    completion(NO);
                                }
                            }];
                        } else {
                            if (completion) {
                                completion(NO);
                            }
                        }
                    });
                }
            }
        }];
        
    });
}

+ (void)jumpToAppStore:(unsigned long)AppID completion:(void(^)())completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSString *URL = [NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%lu",AppID];
        
        [self requestByUrl:[NSURL URLWithString:URL] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            
            if (!data) {
                return;
            }
            
            NSDictionary *JSONData = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
            
            NSArray *infoArray = [JSONData objectForKey:@"results"];
            
            NSDictionary *releaseInfo = [infoArray objectAtIndex:0];
            NSString *trackViewUrl = [releaseInfo objectForKey:@"trackViewUrl"];
            NSURL *url = [NSURL URLWithString:trackViewUrl];
            [[UIApplication sharedApplication] openURL:url];
            if (completion) {
                completion();
            }
        }];
    });
}

+ (void)requestByUrl:(NSURL *)url completionHandler:(void(^)(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error))completionHandler
{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    [request setHTTPMethod:@"POST"];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:completionHandler];
    [sessionDataTask resume];

}

@end
