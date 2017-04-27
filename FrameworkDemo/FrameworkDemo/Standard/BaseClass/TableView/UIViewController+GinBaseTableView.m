//
//  UIViewController+BaseTableView.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/16.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "NSObject+GinSetterAndGetter.h"

#import "UIViewController+GinBaseTableView.h"

@implementation UIViewController (GinBaseTableView)

- (void)cleanup_GinBaseTableView
{
    self.tableView.delegate = nil;
    self.cellDataList = nil;
}

- (void)setup_GinBaseTableView
{
    self.currentPageIndex = self.startIndex = 1;
}

- (void (^)(NSArray *dataList))GinSetupTableDataBlock
{
    return ^(NSArray *dataList) {
        if (dataList && dataList.count > 0) {
            self.cellDataList = dataList;
            [self.tableView.mj_footer resetNoMoreData];
        } else {
            self.cellDataList = @[];
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [self.tableView reloadData];
        [self endTableDataRefreshing];
        
        self.currentPageIndex = self.startIndex;
        
        if (self.finishLoadData) {
            self.finishLoadData(self.tableView);
        }
    };
}

- (void (^)(NSError *error))GinSetupTableDataFailureBlock
{
    return ^(NSError *error) {
        [self endTableDataRefreshing];
        if (self.finishLoadData) {
            self.finishLoadData(self.tableView);
        }
    };
}

- (void (^)(NSArray *dataList))GinSetupTableDataWithPageIndexBlock:(NSUInteger)pageIndex
{
    
    if (pageIndex == self.startIndex) {
        return [self GinSetupTableDataBlock];
    }
    return ^(NSArray *dataList) {
        
        if (dataList && dataList.count > 0) {
            NSMutableArray *mArray = [NSMutableArray arrayWithArray:self.cellDataList];
            [mArray addObjectsFromArray:dataList];
            self.cellDataList = mArray;
            [self.tableView reloadData];
            self.currentPageIndex++;
        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self endTableDataRefreshing];
        
        if (self.finishLoadData) {
            self.finishLoadData(self.tableView);
        }
    };
}

- (void)endTableDataRefreshing
{
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.isRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}


#pragma mark- setter&getter

- (void)setFinishLoadData:(void (^)(UITableView *tableView))finishLoadData
{
    [self setValue:finishLoadData key:@"GinBaseTableFinishLoadData" policy:OBJC_ASSOCIATION_COPY_NONATOMIC owner:self];
}

- (void (^)(UITableView *))finishLoadData
{
    return [self getValueForKey:@"GinBaseTableFinishLoadData"];
}

- (void)setCurrentPageIndex:(NSUInteger)currentPageIndex
{
    [self setValue:@(currentPageIndex) key:@"GinBaseTableCurrentPageIndex" policy:OBJC_ASSOCIATION_ASSIGN owner:self];
}
- (NSUInteger)currentPageIndex
{
    NSNumber *number = [self getValueForKey:@"GinBaseTableCurrentPageIndex"];
    return number.unsignedIntegerValue;
}


- (void)setStartIndex:(NSUInteger)startIndex
{
    [self setValue:@(startIndex) key:@"GinBaseTableStartIndex" policy:OBJC_ASSOCIATION_ASSIGN owner:self];
    
}
- (NSUInteger)startIndex
{
    NSNumber *number = [self getValueForKey:@"GinBaseTableStartIndex"];
    return number.unsignedIntegerValue;
}


- (void)setTableView:(UITableView *)tableView
{
    [self setValue:tableView key:@"GinBaseTableView" policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC owner:self];
}
- (UITableView *)tableView
{
    UITableView *tableView = [self getValueForKey:@"GinBaseTableView"];
    
    if (!tableView) {
        tableView = [UITableView defaultTableView];
        
        [self setValue:tableView key:@"GinBaseTableView" policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC owner:self];
    }
    return tableView;
}


- (void)setCellDataList:(NSArray *)cellDataList
{
    [self setValue:cellDataList key:@"GinBaseTableCellDataList" policy:OBJC_ASSOCIATION_COPY_NONATOMIC owner:self];
}
- (NSArray *)cellDataList
{
    return [self getValueForKey:@"GinBaseTableCellDataList"];
}

@end
