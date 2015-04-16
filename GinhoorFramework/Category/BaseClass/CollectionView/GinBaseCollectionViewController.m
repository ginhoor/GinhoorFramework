//
//  BaseCollectionViewController.m
//  LOLBox
//
//  Created by Ginhoor on 14-1-20.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "GinBaseCollectionViewController.h"

@interface GinBaseCollectionViewController ()

@end

@implementation GinBaseCollectionViewController

- (void)dealloc
{
    self.cellDataList = nil;
    self.collectionView.delegate = nil;
}

- (void)awakeFromNib
{
    [self setup];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.currentPageIndex = self.startIndex = 1;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(78, 100);
        layout.minimumInteritemSpacing = 1.f;
        layout.minimumLineSpacing = 1.f;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.alwaysBounceVertical = YES;
        _collectionView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
        _collectionView.backgroundColor = [UIColor clearColor];
    }
    return _collectionView;
}


- (void (^)())setupCellDataSuccessBlock:(UICollectionView *)collectionView
{
    return ^(NSArray *dataList) {
        if (dataList && dataList.count > 0) {
            self.cellDataList = dataList;
        } else {
            self.cellDataList = @[];
        }
        [collectionView reloadData];
        [self endRefreshing:collectionView];
        
        self.currentPageIndex = self.startIndex;
        
        if (self.finishLoadData) {
            self.finishLoadData(collectionView);
        }
    };
}

- (void (^)())setupCellDataFailureBlock:(UICollectionView *)collectionView
{
    return ^(NSError *error) {
        [self endRefreshing:collectionView];
        if (self.finishLoadData) {
            self.finishLoadData(collectionView);
        }
    };
}

- (void (^)())addNewCellDataSuccessBlock:(UICollectionView *)collectionView
{
    return ^(NSArray *dataList) {

        if (dataList && dataList.count > 0) {
            NSMutableArray *mArray = [NSMutableArray arrayWithArray:self.cellDataList];
            [mArray addObjectsFromArray:dataList];
            self.cellDataList = mArray;
            
            [collectionView reloadData];
            [self endRefreshing:collectionView];
            
        } else {
            [self endRefreshing:collectionView];
        }
        
        self.currentPageIndex++;
        if (self.finishLoadData) {
            self.finishLoadData(collectionView);
        }

    };
}

- (void (^)())addNewCellDataFailureBlock:(UICollectionView *)collectionView
{
    return [self setupCellDataFailureBlock:collectionView];
}


- (void)endRefreshing:(UICollectionView *)collectionView
{
    if (collectionView.header.isRefreshing) {
        [collectionView.header endRefreshing];
    }
    if (collectionView.footer.isRefreshing) {
        [collectionView.footer endRefreshing];
    }
}

@end
