//
//  AppRouter+PullDownMenu.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/18.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppRouter+PullDownMenu.h"

NSString * const kTargetPullDownMenuVC = @"PullDownMenuVCAction";
NSString * const kActionPullDownMenuController = @"pullDownMenuController";


@implementation AppRouter (PullDownMenu)

- (UIViewController *)pullDownMenuController
{
    return [self performTargetName:kTargetPullDownMenuVC actionName:kActionPullDownMenuController params:nil];
}

@end
