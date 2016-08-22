//
//  UIViewController+BaseTableView.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/16.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MJRefresh/MJRefresh.h>
#import "UIViewController+GinBaseClass.h"

#import "UITableView+GinBaseClass.h"

@interface UIViewController (GinBaseTableView)

@property (strong, nonatomic) NSArray *cellDataList;
@property (strong, nonatomic) UITableView *tableView;
/**
 *   default value is 1.(request use setup_GinBaseTableView)
 */
@property (assign, nonatomic) NSUInteger startIndex;
@property (assign, nonatomic) NSUInteger currentPageIndex;

@property (copy, nonatomic) void(^finishLoadData)(UITableView *tableView);


- (void)setup_GinBaseTableView;
- (void)cleanup_GinBaseTableView;

// 初始化celldata
- (void (^)(NSArray *dataList))GinSetupTableDataBlock;
// 获得celldata失败
- (void (^)(NSError *error))GinSetupTableDataFailureBlock;
// 按页数处理 celldata
- (void (^)(NSArray *dataList))GinSetupTableDataWithPageIndexBlock:(NSUInteger)pageIndex;

- (void)endTableDataRefreshing;


@end
