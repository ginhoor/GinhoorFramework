//
//  GinCollectionLayout.m
//  gameTrailers
//
//  Created by Ginhoor on 13-12-27.
//  Copyright (c) 2013年 Ginhoor. All rights reserved.
//

#import "GinCollectionLayout.h"

@interface GinCollectionLayout()
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (assign, nonatomic) BOOL isInsert;
@end

@implementation GinCollectionLayout

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup
{
    // 减震
    self.springDamping = 0.6;
    // 频率
    self.springFrequency = 0.8;
    // 阻力
    self.resistanceFactor = 800;
    
    [self resetCellAnimator];
}


- (void)resetCellAnimator
{
    CGSize contentSize = [self collectionViewContentSize];
    NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
    self.animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];

    for (UICollectionViewLayoutAttributes *item in items) {
        UIAttachmentBehavior *spring = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:item.center];
        
        spring.length = 0;
        spring.damping = self.springDamping;
        spring.frequency = self.springFrequency;
        
        [self.animator addBehavior:spring];
    }
}

- (void)setSpringDamping:(CGFloat)springDamping
{
    if (springDamping >= 0 && _springDamping != springDamping) {
        _springDamping = springDamping;
        for (UIAttachmentBehavior *spring in self.animator.behaviors) {
            spring.damping = _springDamping;
        }
    }
}

- (void)setSpringFrequency:(CGFloat)springFrequency
{
    if (springFrequency >= 0 && _springFrequency != springFrequency) {
        _springFrequency = springFrequency;
        for (UIAttachmentBehavior *spring in self.animator.behaviors) {
            spring.frequency = _springFrequency;
        }
    }
}

- (void)prepareLayout
{
    [super prepareLayout];
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributes = [self.animator itemsInRect:rect];
    
    if (self.isInsert) {
        [self resetCellAnimator];
        self.isInsert = NO;
    }
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.animator layoutAttributesForCellAtIndexPath:indexPath];
}

//每当 layout 的 bounds 改变的时候会调用,可用于替代 scrollDidScroll
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    UIScrollView *scrollView = self.collectionView;
    CGFloat scrollDelta = newBounds.origin.y - scrollView.bounds.origin.y;
    CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView:scrollView];
    
    for (UIAttachmentBehavior *spring in self.animator.behaviors) {
        
        CGPoint anchorPoint = spring.anchorPoint;
        //触摸距离
        CGFloat distanceFromTouch = fabs(touchLocation.y - anchorPoint.y);
        
        CGFloat scrollResistance = distanceFromTouch / self.resistanceFactor;
        
        UICollectionViewLayoutAttributes *item = (UICollectionViewLayoutAttributes *)[spring.items firstObject];
        CGPoint center = item.center;
        center.y += (scrollDelta > 0) ? MIN(scrollDelta, scrollDelta * scrollResistance)
        : MAX(scrollDelta, scrollDelta * scrollResistance);
        item.center = center;
        // 通知 UIDynamic Animator 更新物理计算
        [self.animator updateItemUsingCurrentState:item];
    }
    return NO;
}

+ (void)needReloadDataByLayout:(UICollectionViewLayout *)layout
{
    ((GinCollectionLayout *)layout).isInsert = YES;
}

@end
