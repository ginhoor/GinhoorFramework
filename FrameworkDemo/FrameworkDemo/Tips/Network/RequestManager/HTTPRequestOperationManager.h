//
//  HTTPRequestOperationManager.h
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/5/24.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <AFHTTPRequestOperationManager.h>

// 开发环境
static NSString *const API_SERVER_PATH = @"http://121.43.144.117:8080";
// 本地测试
//static NSString *const API_SERVER_PATH = @"http://192.168.1.199:9090";

// 开发环境
static NSString *const SERVER_KEY = @"l78*#dbv08tr^vw";


@interface HTTPRequestOperationManager : AFHTTPRequestOperationManager


+ (instancetype)sharedManagerOfServer;

+ (void)GET:(NSString *)url success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;
+ (void)POST:(NSString *)url success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock;

@end
