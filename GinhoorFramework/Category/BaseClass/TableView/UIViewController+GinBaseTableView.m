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
    self.currentPageIndex = self.startIndex = 0;
    self.cellDataList = [NSMutableArray array];
}

#pragma mark- setter&getter

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


- (void)setCellDataList:(NSMutableArray *)cellDataList
{
    [self setValue:cellDataList key:@"GinBaseTableCellDataList" policy:OBJC_ASSOCIATION_COPY_NONATOMIC owner:self];
}
- (NSMutableArray *)cellDataList
{
    return [self getValueForKey:@"GinBaseTableCellDataList"];
}

@end
