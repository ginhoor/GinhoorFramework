//
//  UICollectionView+BaseClass.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/16.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (BaseClass)

+ (instancetype)defaultWithItemSize:(CGSize)size;
- (void)config:(void (^)(UICollectionView *collectionView))configTableViewBlock;

@end
