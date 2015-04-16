//
//  BaseCollectionViewController.h
//  LOLBox
//
//  Created by Ginhoor on 14-1-20.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import <MJRefresh.h>
#import "GinBaseViewController.h"
#import "UICollectionView+BaseClass.h"

@interface GinBaseCollectionViewController : GinBaseViewController

@property (copy, nonatomic)   NSArray    *cellDataList;
@property (strong, nonatomic) UICollectionView *collectionView;


/**
 *   default value is 1
 */
@property (assign, nonatomic) NSUInteger startIndex;
@property (assign, nonatomic) NSUInteger currentPageIndex;
@property (copy, nonatomic) void(^finishLoadData)(UICollectionView *collectionView);

// 初始化celldata成功
- (void (^)())setupCellDataSuccessBlock:(UICollectionView *)collectionView;
// 获得celldata失败
- (void (^)())setupCellDataFailureBlock:(UICollectionView *)collectionView;
// 获得新增celldata 成功
- (void (^)())addNewCellDataSuccessBlock:(UICollectionView *)collectionView;
// 获得新增celldata失败
- (void (^)())addNewCellDataFailureBlock:(UICollectionView *)collectionView;



@end
