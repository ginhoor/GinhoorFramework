//
//  UIViewController+BaseCollectionView.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/16.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "NSObject+GinSetterAndGetter.h"

#import "UIViewController+GinBaseCollectionView.h"

@implementation UIViewController (GinBaseCollectionView)

- (void)cleanup_GinBaseCollectionView
{
    self.collectionView.delegate = nil;
    self.cellDataList = nil;
}

- (void)setup_GinBaseCollectionView
{
    self.currentPageIndex = self.startIndex = 1;
}

- (void (^)(NSArray *dataList))GinSetupCollectionDataBlock
{
    return ^(NSArray *dataList) {
        if (dataList && dataList.count > 0) {
            self.cellDataList = dataList;
            [self.collectionView.mj_footer resetNoMoreData];
        } else {
            self.cellDataList = @[];
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        
        [self.collectionView reloadData];
        
        [self endCollectionDataRefreshing];
        self.currentPageIndex = self.startIndex;
        
        if (self.finishLoadData) {
            self.finishLoadData(self.collectionView);
        }
    };
}

- (void (^)(NSError *error))GinSetupCollectionDataFailureBlock
{
    return ^(NSError *error) {
        [self endCollectionDataRefreshing];
        if (self.finishLoadData) {
            self.finishLoadData(self.collectionView);
        }
    };
}

- (void (^)(NSArray *dataList))GinSetupCollectionDataWithPageIndexBlock:(NSUInteger)pageIndex
{
    if (pageIndex == self.startIndex) {
        return [self GinSetupCollectionDataBlock];
    }
    return ^(NSArray *dataList) {
        
        if (dataList && dataList.count > 0) {
            NSMutableArray *mArray = [NSMutableArray arrayWithArray:self.cellDataList];
            [mArray addObjectsFromArray:dataList];
            self.cellDataList = mArray;
            
            [self.collectionView reloadData];
        } else {
            [self.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [self endCollectionDataRefreshing];
        
        self.currentPageIndex++;
        if (self.finishLoadData) {
            self.finishLoadData(self.collectionView);
        }
        
    };
}

- (void (^)(NSError *error))GinAddNewCollectionDataFailureBlock
{
    return [self GinSetupCollectionDataFailureBlock];
}


- (void)endCollectionDataRefreshing
{
    if (self.collectionView.mj_header.isRefreshing) {
        [self.collectionView.mj_header endRefreshing];
    }
    if (self.collectionView.mj_footer.isRefreshing) {
        [self.collectionView.mj_footer endRefreshing];
    }
}



#pragma mark- setter&getter

- (void)setFinishLoadData:(void (^)(UICollectionView *collectionView))finishLoadData
{
    [self setValue:finishLoadData key:@"GinBaseCollectionFinishLoadData" policy:OBJC_ASSOCIATION_COPY_NONATOMIC owner:self];
}

- (void (^)(UICollectionView *))finishLoadData
{
    return [self getValueForKey:@"GinBaseCollectionFinishLoadData"];
}

- (void)setCurrentPageIndex:(NSUInteger)currentPageIndex
{
    [self setValue:@(currentPageIndex) key:@"GinBaseCollectionCurrentPageIndex" policy:OBJC_ASSOCIATION_ASSIGN owner:self];
}
- (NSUInteger)currentPageIndex
{
    NSNumber *number = [self getValueForKey:@"GinBaseCollectionCurrentPageIndex"];
    return number.unsignedIntegerValue;
}


- (void)setStartIndex:(NSUInteger)startIndex
{
    [self setValue:@(startIndex) key:@"GinBaseCollectionStartIndex" policy:OBJC_ASSOCIATION_ASSIGN owner:self];
    
}
- (NSUInteger)startIndex
{
    NSNumber *number = [self getValueForKey:@"GinBaseCollectionStartIndex"];
    return number.unsignedIntegerValue;
}


- (void)setCollectionView:(UICollectionView *)collectionView
{
    [self setValue:collectionView key:@"GinBaseCollectionView" policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC owner:self];
}

- (UICollectionView *)collectionView
{
    UICollectionView *collectionView = [self getValueForKey:@"GinBaseCollectionView"];
    
    if (!collectionView) {
        collectionView = [UICollectionView defaultWithItemSize:CGSizeMake(1, 1)];
        [self setValue:collectionView key:@"GinBaseCollectionView" policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC owner:self];
    }
    return collectionView;
}

- (void)setCellDataList:(NSArray *)cellDataList
{
    [self setValue:cellDataList key:@"GinBaseCollectionCellDataList" policy:OBJC_ASSOCIATION_COPY_NONATOMIC owner:self];
}

- (NSArray *)cellDataList
{
    return [self getValueForKey:@"GinBaseCollectionCellDataList"];
}


@end
