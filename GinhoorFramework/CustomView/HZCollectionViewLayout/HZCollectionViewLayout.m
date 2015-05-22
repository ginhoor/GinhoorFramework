//
//  HZCollectionViewLayout.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/22.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "HZCollectionViewLayout.h"

@implementation HZCollectionViewLayout

/**
 *  默认只处理一行的情况，如果使用多行，需要考虑每行item数量不同的情况
 *
 *  @return 内容Size
 */
- (CGSize)collectionViewContentSize
{

    NSUInteger num = [self.collectionView numberOfItemsInSection:0];
    return CGSizeMake(num * self.itemSize.width + (num-1) * (self.minimumInteritemSpacing), self.itemSize.height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //修改 每个cell的attribute
    UICollectionViewLayoutAttributes *attribue = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    attribue.frame = CGRectMake(indexPath.row*(self.minimumInteritemSpacing + self.itemSize.width), indexPath.section*(self.minimumLineSpacing + self.itemSize.height),self.itemSize.width, self.itemSize.height);
    return attribue;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    //获得cell 的attribute
    NSMutableArray *attributes = [NSMutableArray array];
    
    
    for (int j = 0; j < [self.collectionView numberOfSections]; j++) {
        
        for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:j]; i++) {
            
            NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:j];
            [attributes addObject:[self layoutAttributesForItemAtIndexPath:path]];
        }
    }
    return attributes;
}

@end
