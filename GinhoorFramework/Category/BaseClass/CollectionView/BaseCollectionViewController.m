//
//  BaseCollectionViewController.m
//  LOLBox
//
//  Created by Ginhoor on 14-1-20.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController ()

@end

@implementation BaseCollectionViewController

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

- (void (^)())setupCellDataSuccessBlock:(UICollectionView *)collectionView
{
    return ^(NSArray *dataList) {
        self.cellDataList = dataList;
        [collectionView reloadData];
        if (self.finishLoadData) {
            self.finishLoadData(collectionView);
        }
        self.currentPageIndex = 1;
    };
}

- (void (^)())setupCellDataFailureBlock:(UICollectionView *)collectionView
{
    return ^(NSError *error) {
        if (self.finishLoadData) {
            self.finishLoadData(collectionView);
        }
    };
}

- (void (^)())addNewCellDataSuccessBlock:(UICollectionView *)collectionView
{
    return ^(NSArray *dataList) {

        if (dataList.count > 0) {
            NSMutableArray *mArray = [NSMutableArray arrayWithArray:self.cellDataList];
            [mArray addObjectsFromArray:dataList];
            self.cellDataList = mArray;
            [collectionView reloadData];
            if (self.finishLoadData) {
                self.finishLoadData(collectionView);
            }
            self.currentPageIndex++;
        } else {
        }
    };
}



@end
