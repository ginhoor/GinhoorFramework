//
//  BaseTableViewController.m
//  LOLBox
//
//  Created by Ginhoor on 14-8-6.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "BaseTableViewController.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController

- (void)dealloc
{
    self.cellDataList = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 新开始index = 1，再次加载从index = 2开始。
        self.currentPageIndex = 1;
    }
    return self;
}

- (void (^)())setupCellDataSuccessBlock:(UITableView *)tableView
{
    return ^(NSArray *dataList) {
        self.cellDataList = dataList;
        if (self.finishLoadData) {
            self.finishLoadData(tableView);
        }
        // 新开始index = 1，再次加载从index = 2开始。
        self.currentPageIndex = 1;
    };
}
- (void (^)())setupCellDataFailureBlock:(UITableView *)tableView
{
    return ^(NSError *error) {
        if (self.finishLoadData) {
            self.finishLoadData(tableView);
        }
    };
}


- (void (^)())addNewCellDataSuccessBlock:(UITableView *)tableView
{
    return ^(NSArray *dataList) {
        
        if (dataList.count > 0) {
            NSMutableArray *mArray = [NSMutableArray arrayWithArray:self.cellDataList];
            [mArray addObjectsFromArray:dataList];
            self.cellDataList = mArray;
            
            [tableView reloadData];
            if (self.finishLoadData) {
                self.finishLoadData(tableView);
            }
            self.currentPageIndex++;
        }
    };
}
- (void (^)())addNewCellDataFailureBlock:(UITableView *)tableView
{
    return ^(NSError *error) {
        if (self.finishLoadData) {
            self.finishLoadData(tableView);
        }
    };
}



@end
