//
//  BaseTableViewController.h
//  hme.ios.cn
//
//  Created by JunhuaShao on 15/3/20.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
#import "UITableView+BaseClass.h"

@interface GinBaseTableViewController : UIViewController

@property (strong, nonatomic) NSArray *cellDataList;
@property (strong, nonatomic) UITableView *tableView;

// default is 1
@property (assign, nonatomic) NSUInteger startIndex;
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
