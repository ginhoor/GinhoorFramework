//
//  DemoRouter.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/18.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppRouter : NSObject

+ (instancetype)sharedInstance;

- (id)performActionWithUrl:(NSURL *)url completion:(void (^)(NSDictionary *))completion;

- (id)performTargetName:(NSString *)targetClassName actionName:(NSString *)actionName params:(NSDictionary *)params;

@end
