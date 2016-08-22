//
//  GinPageControlViewController.m
//  LOLBox
//
//  Created by Ginhoor on 14-8-15.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "GinPageViewController.h"

@interface GinPageViewController () <UIPageViewControllerDataSource,UIPageViewControllerDelegate>

@property (copy, nonatomic)   NSArray *contentViewControllers;
@property (assign, nonatomic) NSInteger selectedIndex;
@end

@implementation GinPageViewController

+ (instancetype)controllerWithControllers:(NSArray *)contentViewControllers selectedIndex:(NSInteger)index
{
    NSAssert(contentViewControllers&&contentViewControllers.count > 0, @"In this initialize method contentViewControllers can't be nil");

    GinPageViewController *controller = [[GinPageViewController alloc] init];
    [controller setContentViewControllers:contentViewControllers selectedIndex:index];
    
    return controller;
}

- (void)dealloc
{
    self.pageController.delegate = nil;
    self.pageDidChanged = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.pageControl];
    
    [self addChildViewController:self.pageController];
    [self.view insertSubview:self.pageController.view belowSubview:self.pageControl];
    [self.pageController didMoveToParentViewController:self];
}

- (void)setContentViewControllers:(NSArray *)contentViewControllers selectedIndex:(NSUInteger)selectedIndex
{
    self.selectedIndex = selectedIndex;
    self.pageControl.currentPage = selectedIndex;
    self.contentViewControllers = contentViewControllers;

    [self.pageController setViewControllers:@[contentViewControllers[selectedIndex]]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:nil];
}

- (UIPageViewController *)pageController
{
    if (!_pageController) {
        
        _pageController = [[UIPageViewController alloc]
                           initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                           navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                           //页面间隔
                           options:@{UIPageViewControllerOptionInterPageSpacingKey: @5}];
        
        _pageController.dataSource = self;
        _pageController.delegate = self;
    }
    return _pageController;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
    }
    return _pageControl;
}


#pragma mark- PageView data soure
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.contentViewControllers indexOfObject:viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return self.contentViewControllers[index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self.contentViewControllers indexOfObject:viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == self.contentViewControllers.count) {
        return nil;
    }
    return self.contentViewControllers[index];
}

#pragma mark- PageView delegate

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers
{
    NSUInteger index = [self.contentViewControllers indexOfObject:pendingViewControllers[0]];
    self.pageControl.currentPage = index;
    if (self.pageDidChanged) {
        self.pageDidChanged(pageViewController,index);
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (!completed) {
        NSUInteger index = [self.contentViewControllers indexOfObject:previousViewControllers[0]];
        self.pageControl.currentPage = index;
        if (self.pageDidChanged) {
            self.pageDidChanged(pageViewController,index);
        }
    }
}

@end
