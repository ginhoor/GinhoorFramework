//
//  BaseTableViewController.h
//  LOLBox
//
//  Created by Ginhoor on 14-8-6.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController

@property (copy, nonatomic)   NSArray    *cellDataList;
@property (assign, nonatomic) NSUInteger currentPageIndex;
@property (copy, nonatomic) void(^finishLoadData)(UITableView *tableView);

// 初始化celldata成功
- (void (^)())setupCellDataSuccessBlock:(UITableView *)tableView;
// 获得celldata失败
- (void (^)())setupCellDataFailureBlock:(UITableView *)tableView;

// 获得新增celldata 成功
- (void (^)())addNewCellDataSuccessBlock:(UITableView *)tableView;
// 获得新增celldata失败
- (void (^)())addNewCellDataFailureBlock:(UITableView *)tableView;

@end
