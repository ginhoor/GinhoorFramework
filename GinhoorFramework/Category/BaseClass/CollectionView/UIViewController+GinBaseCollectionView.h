//
//  UIViewController+BaseCollectionView.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/16.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import <MJRefresh.h>
#import "UIViewController+GinBaseClass.h"
#import "UICollectionView+GinBaseClass.h"

@interface UIViewController (BaseCollectionView)

@property (strong, nonatomic) NSArray *cellDataList;
@property (strong, nonatomic) UICollectionView *collectionView;

/**
 *   default value is 1
 */
@property (assign, nonatomic) NSUInteger startIndex;
@property (assign, nonatomic) NSUInteger currentPageIndex;

@property (copy, nonatomic) void(^finishLoadData)(UICollectionView *collectionView);

// 初始化celldata成功
- (void (^)(NSArray *dataList))GinSetupCellDataSuccessBlock;
// 获得celldata失败
- (void (^)(NSError *error))GinSetupCellDataFailureBlock;
// 获得新增celldata 成功
- (void (^)(NSArray *dataList))GinAddNewCellDataSuccessBlock;
// 获得新增celldata失败
- (void (^)(NSError *error))GinAddNewCellDataFailureBlock;

- (void)endRefreshing;

@end
