//
//  UIViewController+initController.h
//  LOLBox
//
//  Created by Ginhoor on 14-3-5.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (initController)

+ (instancetype)controller;
+ (instancetype)controllerByDefaultName;
+ (instancetype)controllerByStoryboard:(UIStoryboard *)storyboard;

- (UIViewController *)lastPresentedViewController;

@end
