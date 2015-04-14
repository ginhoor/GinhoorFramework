//
//  ForcasetCollectionLayout.m
//  Yaobao
//
//  Created by Ginhoor on 14-3-11.
//  Copyright (c) 2014年 zhitech. All rights reserved.
//

#import "HeightDynamicCollectionLayout.h"

@implementation HeightDynamicCollectionLayout

+ (void)setDelegateByLayout:(UICollectionViewLayout *)layout delegate:(id<HeightDynamicCollectionLayoutDelegate>)delegate
{
    ((HeightDynamicCollectionLayout *)layout).delegate = delegate;
}

- (void)prepareLayout
{
    
}

//设置 每个cell 的attribute
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray *attributes = [NSMutableArray array];
    
    for (int j = 0; j < [self.collectionView numberOfSections]; j++) {
        
        NSIndexPath *HeaderIndexPath = [NSIndexPath indexPathForItem:0 inSection:j];
        
        UICollectionViewLayoutAttributes *header =  [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:HeaderIndexPath];
        
        if (header) {
            [attributes addObject:header];
        }
        
        for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:j]; i++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:j];
            [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
        }
    }
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [super layoutAttributesForItemAtIndexPath:indexPath];

    if ([self.delegate respondsToSelector:@selector(heightForRowAtIndexPath:)]) {

        CGFloat height =[self.delegate heightForRowAtIndexPath:indexPath];
        if (indexPath.item == 0) {
            attribute.frame = CGRectMake(CGRectGetMinX(attribute.frame), CGRectGetMinY(attribute.frame), CGRectGetWidth(attribute.frame), height);
        } else {
            
            UICollectionViewLayoutAttributes *lastAttribute = [super layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section]];
            
            attribute.frame = CGRectMake(
                                         CGRectGetMinX(attribute.frame),
                                         CGRectGetMaxY(lastAttribute.frame)+
                                         self.minimumLineSpacing,
                                         CGRectGetWidth(attribute.frame),
                                         height);
        }
        
    }
    
    return attribute;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [super layoutAttributesForSupplementaryViewOfKind:kind atIndexPath:indexPath];
    
    CGFloat height = 0;
    switch (indexPath.section) {
        case 0:
            height = CGRectGetHeight(attribute.frame);
            break;
        case 1:
            height = 40;
            break;
    }
    
    attribute.frame = CGRectMake(CGRectGetMinX(attribute.frame),
                                 CGRectGetMinY(attribute.frame),
                                 CGRectGetWidth(attribute.frame),
                                 height);
    return attribute;
}

@end
