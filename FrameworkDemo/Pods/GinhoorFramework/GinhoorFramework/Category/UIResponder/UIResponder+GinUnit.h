//
//  UIResponder+GinUnit.h
//  LOLBox
//
//  Created by JunhuaShao on 15/3/3.
//  Copyright (c) 2015年 Ginhoor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (GinUnit)

- (UIViewController *)recentlyController;
- (UIViewController *)controlerByClass:(Class)mClass;
- (UINavigationController *)recentlyNavigationContoller;

@end
