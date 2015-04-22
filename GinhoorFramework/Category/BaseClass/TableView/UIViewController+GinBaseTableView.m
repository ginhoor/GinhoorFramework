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

- (void (^)(NSArray *dataList))GinSetupCellDataSuccessBlock
{
    return ^(NSArray *dataList) {
        if (dataList && dataList.count > 0) {
            self.cellDataList = dataList;
        } else {
            self.cellDataList = @[];
        }
        [self.tableView reloadData];
        [self endRefreshing];
        
        self.currentPageIndex = self.startIndex;
        
        if (self.finishLoadData) {
            self.finishLoadData(self.tableView);
        }
    };
}

- (void (^)(NSError *error))GinSetupCellDataFailureBlock
{
    return ^(NSError *error) {
        [self endRefreshing];
        if (self.finishLoadData) {
            self.finishLoadData(self.tableView);
        }
    };
}

- (void (^)(NSArray *dataList))GinAddNewCellDataSuccessBlock
{
    return ^(NSArray *dataList) {
        
        if (dataList && dataList.count > 0) {
            NSMutableArray *mArray = [NSMutableArray arrayWithArray:self.cellDataList];
            [mArray addObjectsFromArray:dataList];
            self.cellDataList = mArray;
            
            [self.tableView reloadData];
            self.currentPageIndex++;
        }
        
        [self endRefreshing];
        
        if (self.finishLoadData) {
            self.finishLoadData(self.tableView);
        }
    };
}

- (void (^)(NSError *error))GinAddNewCellDataFailureBlock
{
    return [self GinSetupCellDataFailureBlock];
}

- (void)endRefreshing
{
    if (self.tableView.header.isRefreshing) {
        [self.tableView.header endRefreshing];
    }
    if (self.tableView.footer.isRefreshing) {
        [self.tableView.footer endRefreshing];
    }
}


#pragma mark- setter&getter

- (void)setFinishLoadData:(void (^)(UITableView *tableView))finishLoadData
{
    [self setValue:finishLoadData key:@"finishLoadData" policy:OBJC_ASSOCIATION_COPY_NONATOMIC owner:self];
}

- (void (^)(UITableView *))finishLoadData
{
    return [self getValueForKey:@"finishLoadData"];
}

- (void)setCurrentPageIndex:(NSUInteger)currentPageIndex
{
    [self setValue:@(currentPageIndex) key:@"currentPageIndex" policy:OBJC_ASSOCIATION_ASSIGN owner:self];
}
- (NSUInteger)currentPageIndex
{
    NSNumber *number = [self getValueForKey:@"currentPageIndex"];
    return number.unsignedIntegerValue;
}


- (void)setStartIndex:(NSUInteger)startIndex
{
    [self setValue:@(startIndex) key:@"startIndex" policy:OBJC_ASSOCIATION_ASSIGN owner:self];

}
- (NSUInteger)startIndex
{
    NSNumber *number = [self getValueForKey:@"startIndex"];
    return number.unsignedIntegerValue;
}


- (void)setTableView:(UITableView *)tableView
{
    [self setValue:tableView key:@"tableView" policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC owner:self];
}
- (UITableView *)tableView
{
    UITableView *tableView = [self getValueForKey:@"tableView"];
    
    if (!tableView) {
        tableView = [UITableView defaultTableView];

        [self setValue:tableView key:@"tableView" policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC owner:self];
    }
    return tableView;
}


- (void)setCellDataList:(NSArray *)cellDataList
{
    [self setValue:cellDataList key:@"cellDataList" policy:OBJC_ASSOCIATION_COPY_NONATOMIC owner:self];
}
- (NSArray *)cellDataList
{
    return [self getValueForKey:@"cellDataList"];
}

@end
