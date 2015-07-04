//
//  BaseTableViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/4.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)dealloc
{
    [self cleanup_GinBaseTableView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup_GinBaseTableView];
}

@end
