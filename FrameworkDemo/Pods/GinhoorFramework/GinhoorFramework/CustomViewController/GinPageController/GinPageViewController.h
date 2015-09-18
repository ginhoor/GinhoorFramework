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
@property (copy, nonatomic) void(^pageDidChanged)(UIPageViewController *pageViewController,NSUInteger index);

+ (instancetype)controllerWithControllers:(NSArray *)contentViewControllers selectedIndex:(NSInteger)index;

- (void)setContentViewControllers:(NSArray *)contentViewControllers selectedIndex:(NSUInteger)selectedIndex;


@end
