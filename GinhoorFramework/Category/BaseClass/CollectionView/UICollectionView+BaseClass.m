//
//  UICollectionView+BaseClass.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/16.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "UICollectionView+BaseClass.h"

@implementation UICollectionView (BaseClass)

+ (instancetype)defaultWithItemSize:(CGSize)size
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = size;
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = layout.minimumLineSpacing;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.alwaysBounceVertical = YES;
    collectionView.backgroundColor = [UIColor whiteColor];
    
    return collectionView;
}

- (void)config:(void (^)(UICollectionView *collectionView))configTableViewBlock
{
    if (configTableViewBlock) {
        configTableViewBlock(self);
    }
}


@end
