//
//  TabsViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/25.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "Masonry.h"

#import "TabsViewController.h"
#import "GinTabsViewController.h"
#import "page1Controller.h"
#import "page2Controller.h"
#import "page3Controller.h"

@interface TabsViewController()
@property (strong, nonatomic) GinTabsViewController *tabsController;
@end

@implementation TabsViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.tabsController setSections:@[@"2人间",@"3人间",@"4人间"] contentViewControllers:@[[[page1Controller alloc] init],[[page2Controller alloc] init],[[page3Controller alloc] init]]];
    
    [self.view addSubview:self.tabsController.view];
    [self addChildViewController:self.tabsController];
    [self.tabsController didMoveToParentViewController:self];

    [self setConstraints];
}

// 设置 view 的初次约束
- (void)setConstraints
{
    [self.tabsController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
    }];
}

- (GinTabsViewController *)tabsController
{
    if (!_tabsController) {
        _tabsController = [[GinTabsViewController alloc] init];
         }
    return _tabsController;
}

@end
