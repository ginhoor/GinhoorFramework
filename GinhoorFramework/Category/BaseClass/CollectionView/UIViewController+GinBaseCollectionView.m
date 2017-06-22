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
    self.cellDataList = [NSMutableArray array];
}

#pragma mark- setter&getter

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
