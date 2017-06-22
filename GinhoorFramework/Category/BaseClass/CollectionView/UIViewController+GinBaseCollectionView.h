//
//  UIViewController+BaseCollectionView.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/16.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MJRefresh/MJRefresh.h>

#import "UIViewController+GinBaseClass.h"
#import "UICollectionView+GinBaseClass.h"

@interface UIViewController (GinBaseCollectionView)

@property (strong, nonatomic) NSMutableArray *cellDataList;
@property (strong, nonatomic) UICollectionView *collectionView;

/**
 *   default value is 1
 */
@property (assign, nonatomic) NSUInteger startIndex;
@property (assign, nonatomic) NSUInteger currentPageIndex;

- (void)setup_GinBaseCollectionView;
- (void)cleanup_GinBaseCollectionView;

@end
