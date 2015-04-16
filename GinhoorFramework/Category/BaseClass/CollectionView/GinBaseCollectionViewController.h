//
//  BaseCollectionViewController.h
//  LOLBox
//
//  Created by Ginhoor on 14-1-20.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "GinBaseViewController.h"
#import "UICollectionView+DefualtStyle.h"

typedef NS_ENUM(NSInteger, CollectionRefreshControlType) {
    CollectionRefreshControlGrayType,
    CollectionRefreshControlWhiteType
};

@interface GinBaseCollectionViewController : GinBaseViewController

@property (copy, nonatomic)   NSArray    *cellDataList;
@property (assign, nonatomic) NSUInteger currentPageIndex;
@property (copy, nonatomic) void(^finishLoadData)(UICollectionView *collectionView);

// 初始化celldata成功
- (void (^)())setupCellDataSuccessBlock:(UICollectionView *)collectionView;
// 获得celldata失败
- (void (^)())setupCellDataFailureBlock:(UICollectionView *)collectionView;
// 获得新增celldata 成功
- (void (^)())addNewCellDataSuccessBlock:(UICollectionView *)collectionView;



@end
