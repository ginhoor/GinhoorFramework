//
//  HTTPRequestOperationManager.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/5/24.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Mantle.h>
#import "HTTPRequestOperationManager.h"


@interface HTTPRequestOperationManager()

@end

@implementation HTTPRequestOperationManager


+ (instancetype)sharedManagerOfServer
{
    static dispatch_once_t onceToken;
    static HTTPRequestOperationManager *sharedManagerOfMyserver = nil;
    dispatch_once(&onceToken, ^{
        NSURL *url = [NSURL URLWithString:API_SERVER_PATH];
        sharedManagerOfMyserver = [[self alloc] initWithBaseURL:url];
        [sharedManagerOfMyserver setupJsonRequestManager:API_SERVER_PATH];
    });
    return sharedManagerOfMyserver;
}


- (void)setupJsonRequestManager:(NSString *)basePath
{
    // set the request serializer to rc serializer
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    // add the aceptable content types
    NSMutableSet *newSet = [self.responseSerializer.acceptableContentTypes mutableCopy];
    [newSet addObjectsFromArray:@[@"text/html", @"text/plain",@"application/json", @"text/json", @"text/javascript"]];
    
    self.responseSerializer.acceptableContentTypes = newSet;
}

- (void)setupHttpRequestManager:(NSString *)basePath
{
    // set the request serializer to rc serializer
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    // set the response serializer to json serializer
    self.responseSerializer = [AFHTTPResponseSerializer serializer];
    // add the aceptable content types
    NSMutableSet *newSet = [self.responseSerializer.acceptableContentTypes mutableCopy];
    [newSet addObjectsFromArray:@[@"text/html", @"text/plain",@"application/json", @"text/json", @"text/javascript"]];
    
    self.responseSerializer.acceptableContentTypes = newSet;
}


- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request success:(void (^)(AFHTTPRequestOperation *, id))success failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure
{
    return [super HTTPRequestOperationWithRequest:request success:success failure:failure];
    //        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //        operation.responseSerializer = self.responseSerializer;
    //        operation.shouldUseCredentialStorage = self.shouldUseCredentialStorage;
    //        operation.credential = self.credential;
    //        operation.securityPolicy = self.securityPolicy;
    //
    //        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, NSDictionary *responseDict) {
    //
    //            //在这里可以重复性的处理 参数解析
    //            success(operation, responseDict);
    //
    //        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    //            // update the new time stamp
    //            failure(operation, error);
    //
    //        }];
    //
    //        return operation;
}


+ (void)GET:(NSString *)url success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
    [[HTTPRequestOperationManager sharedManagerOfServer] GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"operation: %@", [operation request].URL.absoluteString);
        NSLog(@"responseObject: %@", responseObject);
        
        if (successBlock) {
            successBlock(operation, responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"operation: %@", [operation request].URL.absoluteString);
        NSLog(@"error: %@", error);
                
        if (failureBlock) {
            failureBlock(operation, error);
        }
    }];
}

+ (void)POST:(NSString *)url success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))successBlock failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failureBlock
{
    [[HTTPRequestOperationManager sharedManagerOfServer] POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"operation: %@", [operation request].URL.absoluteString);
        NSLog(@"responseObject: %@", responseObject);
        
        if (successBlock) {
            successBlock(operation, responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"operation: %@", [operation request].URL.absoluteString);
        NSLog(@"error: %@", error);
        
        
        if (failureBlock) {
            failureBlock(operation, error);
        }
    }];
}

@end
