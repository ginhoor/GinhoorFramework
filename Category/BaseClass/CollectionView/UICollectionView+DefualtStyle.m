//
//  UICollectionView+DefualtStyle.m
//  LOLBox
//
//  Created by JunhuaShao on 14/12/17.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "UICollectionView+DefualtStyle.h"

@implementation UICollectionView (DefualtStyle)

+ (instancetype)defualtWithItemSize:(CGSize)size
{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = size;
    layout.minimumLineSpacing = 1;
    layout.minimumInteritemSpacing = layout.minimumLineSpacing;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.alwaysBounceVertical = YES;
    collectionView.backgroundColor = [UIColor clearColor];

    return collectionView;
}


@end
