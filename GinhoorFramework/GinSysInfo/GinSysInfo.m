//
//  GinSysInfo.m
//  demo4UserSpace
//
//  Created by Ginhoor on 14-8-20.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "GinSysInfo.h"
#import "NSString+Json.h"
#import "GinPopup+Unit.h"


@implementation GinSysInfo

+ (NSString *)iOSSystemVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)appVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (NSString *)appBundleName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"];
}

+ (NSString *)buildVersion
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

+ (NSString *)bundleSeedID {
    NSDictionary *query = [NSDictionary dictionaryWithObjectsAndKeys:
                           (__bridge id)(kSecClassGenericPassword), kSecClass,
                           @"bundleSeedID", kSecAttrAccount,
                           @"", kSecAttrService,
                           (id)kCFBooleanTrue, kSecReturnAttributes,
                           nil];
    CFDictionaryRef result = nil;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status == errSecItemNotFound)
        status = SecItemAdd((__bridge CFDictionaryRef)query, (CFTypeRef *)&result);
    if (status != errSecSuccess)
        return nil;
    NSString *accessGroup = [(__bridge NSDictionary *)result objectForKey:(__bridge id)(kSecAttrAccessGroup)];
    NSArray *components = [accessGroup componentsSeparatedByString:@"."];
    NSString *bundleSeedID = [[components objectEnumerator] nextObject];
    CFRelease(result);
    return bundleSeedID;
}

+ (BOOL)iOS8
{
    return [self iOSSystemVersion].floatValue >= 8.0;
}


+ (BOOL)isJailbrokenUser

{
    /* Cydia.app */
    NSString *cydiaPath = @"/Applications/Cydia.app";
    if ([[NSFileManager defaultManager] fileExistsAtPath:cydiaPath]) {
        return YES;
    }
    
    /* apt */
    NSString *aptPath = @"/private/var/lib/apt/";
    if ([[NSFileManager defaultManager] fileExistsAtPath:aptPath]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isPiratedUser
{
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/iTunesMetadata.plist"];
    NSDictionary *infoDic = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    if (infoDic[@"com.apple.iTunesStore.downloadInfo"][@"accountInfo"][@"AppleID"]) {
        return NO;
    } else if (infoDic[@"appleId"])
    {
        return NO;
    } else {
        return YES;
    }
}

+ (void)onCheckVersion:(BOOL)needAllTips AppID:(unsigned long)AppID
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
