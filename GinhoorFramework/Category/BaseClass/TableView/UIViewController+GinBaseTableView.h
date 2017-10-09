//
//  UIViewController+BaseTableView.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/16.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "UIViewController+GinBaseClass.h"

#import "UITableView+GinBaseClass.h"

@interface UIViewController (GinBaseTableView)

@property (strong, nonatomic) NSMutableArray *cellDataList;
@property (strong, nonatomic) UITableView *tableView;
/**
 *   default value is 1.(request use setup_GinBaseTableView)
 */
@property (assign, nonatomic) NSUInteger startIndex;
@property (assign, nonatomic) NSUInteger currentPageIndex;


- (void)setup_GinBaseTableView;
- (void)cleanup_GinBaseTableView;


@end
