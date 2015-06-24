//
//  UIViewController+BaseTableView.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/16.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import <MJRefresh.h>
#import "UIViewController+GinBaseClass.h"

#import "UITableView+GinBaseClass.h"

@interface UIViewController (GinBaseTableView)

@property (strong, nonatomic) NSArray *cellDataList;
@property (strong, nonatomic) UITableView *tableView;
/**
 *   default value is 1
 */
@property (assign, nonatomic) NSUInteger startIndex;
@property (assign, nonatomic) NSUInteger currentPageIndex;

@property (copy, nonatomic) void(^finishLoadData)(UITableView *tableView);


- (void)setup_GinBaseTableView;
- (void)cleanup_GinBaseTableView;

// 初始化celldata成功
- (void (^)(NSArray *dataList))GinSetupTableDataSuccessBlock;
// 获得celldata失败
- (void (^)(NSError *error))GinSetupTableDataFailureBlock;
// 获得新增celldata 成功
- (void (^)(NSArray *dataList))GinAddNewTableDataSuccessBlock;
// 获得新增celldata失败
- (void (^)(NSError *error))GinAddNewTableDataFailureBlock;

- (void)endTableDataRefreshing;


@end
