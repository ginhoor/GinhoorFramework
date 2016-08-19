//
//  AppRouter+Networking.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/19.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppRouter+Networking.h"

NSString * const kTargetNetworkingAction = @"NetworkingAction";
NSString * const kActionNetworkingController = @"networkingController";


@implementation AppRouter (Networking)

- (UIViewController *)networkingController
{
    return [self performTargetName:kTargetNetworkingAction actionName:kActionNetworkingController params:nil];
}

@end
