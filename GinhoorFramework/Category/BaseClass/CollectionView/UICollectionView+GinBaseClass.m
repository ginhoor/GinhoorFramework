//
//  UICollectionView+BaseClass.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/16.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "UICollectionView+GinBaseClass.h"

@implementation UICollectionView (GinBaseClass)

+ (instancetype)defaultWithItemSize:(CGSize)size
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = size;
    
    UICollectionView *collectionView = [[[self class] alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
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
