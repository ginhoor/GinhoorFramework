//
//  GinPageViewController.h
//  demo4Page
//
//  Created by Ginhoor on 14-3-12.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"

@interface GinTabsViewController : UIViewController

@property (strong, nonatomic) HMSegmentedControl *segmentedControl;
@property (strong, nonatomic) UIPageViewController *pageController;


@property (assign, nonatomic) NSInteger selectedIndex;

- (void)setSections:(NSArray *)sections contentViewControllers:(NSArray *)contentViewControllers;

+ (instancetype)controllerWithSections:(NSArray *)sections controllers:(NSArray *)contentViewControllers beginIndex:(NSInteger)index;

@end
