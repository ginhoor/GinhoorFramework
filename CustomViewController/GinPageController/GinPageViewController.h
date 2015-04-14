//
//  GinPageControlViewController.h
//  LOLBox
//
//  Created by Ginhoor on 14-8-15.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GinPageViewController : UIViewController
@property (strong, nonatomic) UIPageViewController *pageController;
@property (strong, nonatomic) UIPageControl *pageControl;

+ (instancetype)controllerWithControllers:(NSArray *)contentViewControllers beginIndex:(NSInteger)index;


@end
