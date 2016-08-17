//
//  UIViewController+BaseCollectionView.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/16.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "MJRefresh.h"
#import "UIViewController+GinBaseClass.h"
#import "UICollectionView+GinBaseClass.h"

@interface UIViewController (GinBaseCollectionView)

@property (strong, nonatomic) NSArray *cellDataList;
@property (strong, nonatomic) UICollectionView *collectionView;

/**
 *   default value is 1
 */
@property (assign, nonatomic) NSUInteger startIndex;
@property (assign, nonatomic) NSUInteger currentPageIndex;

@property (copy, nonatomic) void(^finishLoadData)(UICollectionView *collectionView);

- (void)setup_GinBaseCollectionView;
- (void)cleanup_GinBaseCollectionView;


// 初始化celldata
- (void (^)(NSArray *dataList))GinSetupCollectionDataBlock;
// 获得celldata失败
- (void (^)(NSError *error))GinSetupCollectionDataFailureBlock;
// 按页数处理 celldata
- (void (^)(NSArray *dataList))GinSetupCollectionDataWithPageIndexBlock:(NSUInteger)pageIndex;


- (void)endCollectionDataRefreshing;

@end
