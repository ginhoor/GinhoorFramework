//
//  UIViewController+BaseTableView.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/16.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "NSObject+SetterAndGetter.h"

#import "UIViewController+BaseTableView.h"

@implementation UIViewController (BaseTableView)

- (void)deallocSwizzle
{
    self.cellDataList = nil;
    self.tableView.delegate = nil;
    [self deallocSwizzle];
}

- (void)awakeFromNibSwizzle
{
    [self awakeFromNibSwizzle];
    [self setup];
}


- (instancetype)initSwizzle
{
    self = [self initSwizzle];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.currentPageIndex = self.startIndex = 1;
}


- (void (^)())GinSetupCellDataSuccessBlock:(UITableView *)tableView
{
    return ^(NSArray *dataList) {
        if (dataList && dataList.count > 0) {
            self.cellDataList = dataList;
        } else {
            self.cellDataList = @[];
        }
        [tableView reloadData];
        [self endRefreshing];
        
        self.currentPageIndex = self.startIndex;
        
        if (self.finishLoadData) {
            self.finishLoadData(tableView);
        }
    };
}

- (void (^)())GinSetupCellDataFailureBlock:(UITableView *)tableView
{
    return ^(NSError *error) {
        [self endRefreshing];
        if (self.finishLoadData) {
            self.finishLoadData(tableView);
        }
    };
}

- (void (^)())GinAddNewCellDataSuccessBlock:(UITableView *)tableView
{
    return ^(NSArray *dataList) {
        
        if (dataList && dataList.count > 0) {
            NSMutableArray *mArray = [NSMutableArray arrayWithArray:self.cellDataList];
            [mArray addObjectsFromArray:dataList];
            self.cellDataList = mArray;
            
            [tableView reloadData];
            [self endRefreshing];
            
        } else {
            [self endRefreshing];
        }
        
        self.currentPageIndex++;
        if (self.finishLoadData) {
            self.finishLoadData(tableView);
        }
    };
}

- (void (^)())GinAddNewCellDataFailureBlock:(UITableView *)tableView
{
    return [self GinSetupCellDataFailureBlock:tableView];
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

- (void)setFinishLoadData:(void (^)(UITableView *))finishLoadData
{
    [self setValue:finishLoadData key:@"finishLoadData" policy:OBJC_ASSOCIATION_COPY_NONATOMIC owner:self];
}

- (void (^)(UITableView *))finishLoadData
{
    return [self getValueForKey:@"finishLoadData"];
}

- (void)setCurrentPageIndex:(NSUInteger)currentPageIndex
{
    [self setValue:@(currentPageIndex) forKey:@"currentPageIndex"];
}
- (NSUInteger)currentPageIndex
{
    NSNumber *number = [self getValueForKey:@"currentPageIndex"];
    return number.unsignedIntegerValue;
}


- (void)setStartIndex:(NSUInteger)startIndex
{
    [self setValue:@(startIndex) forKey:@"startIndex"];
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
        tableView = [[UITableView alloc] init];
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.tableFooterView = [[UIView alloc]init];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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

#pragma mark- 交换方法实现

+ (void)load
{
    //    交换deallac方法
    Method dealloc = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method deallocSwizzle = class_getInstanceMethod([self class], @selector(deallocSwizzle));
    method_exchangeImplementations(dealloc, deallocSwizzle);
    
    //    交换awakeFromNib方法
    Method awakeFromNib = class_getInstanceMethod([self class], NSSelectorFromString(@"awakeFromNib"));
    Method awakeFromNibSwizzle = class_getInstanceMethod([self class], @selector(awakeFromNibSwizzle));
    method_exchangeImplementations(awakeFromNib, awakeFromNibSwizzle);
    
    //    交换deallac方法
    Method init = class_getInstanceMethod([self class], NSSelectorFromString(@"init"));
    Method initSwizzle = class_getInstanceMethod([self class], @selector(initSwizzle));
    method_exchangeImplementations(init, initSwizzle);
    
}

@end
