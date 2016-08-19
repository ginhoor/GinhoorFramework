//
//  GinPageViewController.m
//  demo4Page
//
//  Created by Ginhoor on 14-3-12.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "Masonry.h"
#import "GinTabsViewController.h"

@interface GinTabsViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate>
@property (copy, nonatomic)   NSArray *contentViewControllers;
@property (copy, nonatomic)   NSArray *sections;

@end

@implementation GinTabsViewController

+ (instancetype)controllerWithSections:(NSArray *)sections controllers:(NSArray *)contentViewControllers beginIndex:(NSInteger)index{
    
    GinTabsViewController *controller = [[GinTabsViewController alloc] init];
    [controller setSections:sections contentViewControllers:contentViewControllers];
    controller.selectedIndex = index;
    return controller;
}

- (void)dealloc
{
    self.contentViewControllers = nil;
    self.sections = nil;
    self.pageController.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.segmentedControl];
    [self.segmentedControl addTarget:self action:@selector(segmentedContolValueChangeAction:) forControlEvents:UIControlEventValueChanged];
    
    
    self.segmentedControl.selectedSegmentIndex = self.selectedIndex;
    
    __weak GinTabsViewController *weakSelf = self;
    
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {

        UIPageViewControllerNavigationDirection direction;
        if (index > weakSelf.selectedIndex) {
            direction = UIPageViewControllerNavigationDirectionForward;
        } else {
            direction = UIPageViewControllerNavigationDirectionReverse;
        }
        weakSelf.selectedIndex = index;
        
        [weakSelf.pageController setViewControllers:@[weakSelf.contentViewControllers[weakSelf.selectedIndex]] direction:direction animated:YES completion:^(BOOL finished) {

            // Set the current page again to obtain synchronisation between tabs and content
            // 防止标签跳动切换

            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.pageController setViewControllers:@[weakSelf.contentViewControllers[weakSelf.selectedIndex]] direction:direction animated:NO completion:nil];
            });
        }];
    }];
    
    [self addChildViewController:self.pageController];
    [self.view insertSubview:self.pageController.view belowSubview:self.segmentedControl];
    [self.pageController didMoveToParentViewController:self];
    [self setConstraints];
}

// 设置 view 的初次约束
- (void)setConstraints
{
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.offset(50);
    }];
    
    [self.pageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentedControl.mas_bottom);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
    }];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)setSections:(NSArray *)sections contentViewControllers:(NSArray *)contentViewControllers
{
    NSAssert(sections.count == contentViewControllers.count, @"contentViewControllers.count must be equal to sections.count");
    NSAssert(contentViewControllers && contentViewControllers.count > 0, @"contentViewControllers cann't be set to nil");
    NSAssert(sections &&  sections.count > 0, @"sections cann't be set to nil");

    _sections = sections;
    _contentViewControllers = contentViewControllers;
    [self.pageController setViewControllers:@[self.contentViewControllers[self.selectedIndex]]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:nil];
    self.segmentedControl.sectionTitles = self.sections;
}

- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (_selectedIndex == selectedIndex)
        return;
    _selectedIndex = selectedIndex;
    NSAssert(self.contentViewControllers && self.contentViewControllers.count > 0, @"contentViewControllers cann't be set to nil");

    [self.pageController setViewControllers:@[self.contentViewControllers[self.selectedIndex]]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:nil];
    [self.segmentedControl setSelectedSegmentIndex:selectedIndex animated:YES];
}


- (HMSegmentedControl *)segmentedControl
{
    if (!_segmentedControl) {
        _segmentedControl = [[HMSegmentedControl alloc] init];
        _segmentedControl.backgroundColor = [UIColor whiteColor];
        _segmentedControl.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor colorWithWhite:0.7 alpha:1]};
        _segmentedControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName: [UIColor greenColor]};
        _segmentedControl.selectionIndicatorColor = [UIColor redColor];
        
        _segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
        
        _segmentedControl.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
        
        _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        
        CGFloat widthOffset = 10;
        _segmentedControl.selectionIndicatorEdgeInsets = UIEdgeInsetsMake(0, -widthOffset, 0, -widthOffset*2);
        
    }
    return _segmentedControl;
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

- (void)segmentedContolValueChangeAction:(UISegmentedControl *)sender
{
    NSUInteger index = sender.selectedSegmentIndex;
    
    UIPageViewControllerNavigationDirection direction;
    if (index > self.selectedIndex) {
        direction = UIPageViewControllerNavigationDirectionForward;
    } else {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    self.selectedIndex = index;
    __weak GinTabsViewController *weakSelf = self;
    [self.pageController setViewControllers:@[self.contentViewControllers[self.selectedIndex]] direction:direction animated:YES completion:^(BOOL finished) {
        // 防止标签跳动切换
        // Set the current page again to obtain synchronisation between tabs and content
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.pageController setViewControllers:@[weakSelf.contentViewControllers[weakSelf.selectedIndex]] direction:direction animated:NO completion:nil];
        });
    }];
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
    [self.segmentedControl setSelectedSegmentIndex:index animated:YES];
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (!completed) {
        NSUInteger index = [self.contentViewControllers indexOfObject:previousViewControllers[0]];
        [self.segmentedControl setSelectedSegmentIndex:index animated:YES];
    }
}

@end
