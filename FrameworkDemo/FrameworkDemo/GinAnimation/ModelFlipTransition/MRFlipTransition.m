//
//  MRFlipTransitionAnimator.m
//
//  Copyright (c) 2014 Michael WU. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "MRFlipTransition.h"
#import "UIViewController+MRFlipTransitino.h"

@interface MRGradientShadowedLayer : CALayer

@property (nonatomic, strong)   CAGradientLayer *shadowCover;

+ (instancetype)layerWithShadowBeginFromTop:(BOOL)top;

@end

@implementation MRGradientShadowedLayer

- (instancetype)initWithShadowBeginFromTop:(BOOL)top
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor].CGColor;
        
        self.shadowCover = [CAGradientLayer layer];
        self.shadowCover.colors = top ?
        @[(id)[UIColor colorWithWhite:0 alpha:0.4].CGColor,
          (id)[UIColor clearColor].CGColor]
        : @[(id)[UIColor clearColor].CGColor,
            (id)[UIColor colorWithWhite:0 alpha:0.4].CGColor];
        [self addSublayer:self.shadowCover];
        
        self.shadowColor = [UIColor colorWithWhite:0 alpha:0.6].CGColor;
        self.shadowOffset = CGSizeMake(0, top ? 1 : -1);
        self.shadowRadius = 2.0;
        self.shadowOpacity = 0.8;
    }
    
    return self;
}

+ (instancetype)layerWithShadowBeginFromTop:(BOOL)top
{
    return [[MRGradientShadowedLayer alloc] initWithShadowBeginFromTop:top];
}

- (void)layoutSublayers
{
    [super layoutSublayers];
    self.shadowCover.frame = self.bounds;
    self.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

@end

@interface MRTransformView : UIView

@property (nonatomic, strong)   CATransformLayer    *transformLayer;
@property (nonatomic, strong)   MRGradientShadowedLayer *lowerLayer;
@property (nonatomic, strong)   CALayer                 *upperFrontLayer;
@property (nonatomic, strong)   MRGradientShadowedLayer *upperBackLayer;

@end

@implementation MRTransformView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.transformLayer = [CATransformLayer layer];
        [self.layer addSublayer:self.transformLayer];
        
        self.lowerLayer = [MRGradientShadowedLayer layerWithShadowBeginFromTop:YES];
        self.lowerLayer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
        self.lowerLayer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
        self.lowerLayer.doubleSided = NO;
        [self.transformLayer addSublayer:self.lowerLayer];
        
        self.upperFrontLayer = [CALayer layer];
        self.upperFrontLayer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
        self.upperFrontLayer.anchorPoint = CGPointMake(0.5, 0.0);
        self.upperFrontLayer.contentsRect = CGRectMake(0, 0.5, 1, 0.5);
        self.upperFrontLayer.doubleSided = NO;
        [self.transformLayer addSublayer:self.upperFrontLayer];
        
        self.upperBackLayer = [MRGradientShadowedLayer layerWithShadowBeginFromTop:NO];
        self.upperBackLayer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0].CGColor;
        self.upperBackLayer.anchorPoint = CGPointMake(0.5, 1.0);
        self.upperBackLayer.contentsRect = CGRectMake(0, 0, 1, 0.5);
        self.upperBackLayer.doubleSided = NO;
        [self.transformLayer addSublayer:self.upperBackLayer];
    }
    return self;
}

- (void)layoutSubviews
{
    self.transformLayer.frame = self.bounds;
    CATransform3D sublayerTransform = self.transformLayer.sublayerTransform;
    sublayerTransform.m34 = -1 / (CGRectGetHeight(self.bounds) * 4.7 * 0.5);
    self.transformLayer.sublayerTransform = sublayerTransform;
    
    CGRect upperRect = CGRectMake(0,
                                  0,
                                  CGRectGetWidth(self.bounds),
                                  CGRectGetHeight(self.bounds) / 2.0);
    CGRect lowerRect = CGRectMake(0,
                                  CGRectGetHeight(upperRect),
                                  CGRectGetWidth(upperRect),
                                  CGRectGetHeight(upperRect));
    
    self.upperFrontLayer.frame = self.lowerLayer.frame = lowerRect;
    self.upperBackLayer.frame = upperRect;
    [super layoutSubviews];

}

@end

@interface MRFlipTransition ()

@property (nonatomic, strong)                   UIImage                         *contentImage;
@property (assign, getter = isPresentAnimation) BOOL                            presentAnimation;
@property (nonatomic, weak)                     UIViewController                *presentingViewController;
@property (assign)                              MRFlipTransitionPresentingStyle style;
@property (nonatomic, strong)                   MRTransformView                 *transformView;
@property (nonatomic, strong)                   UIView                          *shadowView;

@end

static NSTimeInterval   const MRFlipEaseInDuration = 0.4;
static NSTimeInterval   const MRFlipLayerDuration = 0.8;
static CGFloat          const MRInfinityMerginY = 10.0;
static CGFloat          const MREaseInExtraDistance = 40.0;
static CGFloat          const MRScaleFactor = 0.875;
static CGFloat          const MRInfinityFactor = 0.01;

@implementation MRFlipTransition

- (instancetype)initWithPresentingViewController:(UIViewController *)controller;
{
    NSParameterAssert(controller);
    self = [super init];
    if (self)
    {
        self.presentAnimation = YES;
        _presentingViewController = controller;
        self.shadowView = [[UIView alloc] initWithFrame:CGRectZero];
        self.shadowView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.8];
        self.shadowView.layer.opacity = 0.0;
    }
    
    return self;
}

- (void)present:(UIViewController *)viewController from:(MRFlipTransitionPresentingStyle)direction completion:(void (^)(void))completion
{
    if (!self.presentAnimation || !viewController || self.presentingViewController.presentedViewController)
    {
        return;
    }

    _style = direction;
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    viewController.transitioningDelegate = self;
    [self.presentingViewController presentViewController:viewController animated:YES completion:completion];
}

- (void)dismissTo:(MRFlipTransitionPresentingStyle)direction completion:(void(^)(void))completion
{
    if (self.presentAnimation || !self.presentingViewController.presentedViewController || self.presentingViewController.presentedViewController.isBeingDismissed)
    {
        return;
    }
    
    _style = direction;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:completion];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self;
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self;
}

#pragma mark - Snapshot
- (void)updateContentSnapshot:(UIView *)view afterScreenUpdate:(BOOL)update
{
    if (CGSizeEqualToSize(view.bounds.size, CGSizeZero))
    {
        return;
    }
    
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:update];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.contentImage = snapshotImage;
}

#pragma mark - UIViewControllerAnimatedTransitioning delegate
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return MRFlipEaseInDuration + MRFlipLayerDuration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *fromView = [fromViewController viewForTransitionContext:transitionContext];
    UIView *toView = [toViewController viewForTransitionContext:transitionContext];
    UIView *containerView = [transitionContext containerView];
    
    self.transformView.upperFrontLayer.contents = (__bridge id)(self.coverImage.CGImage);
    
    __weak typeof(self) _WeakSelf = self;
    if (self.presentAnimation) {
        self.transformView = [[MRTransformView alloc] initWithFrame:containerView.bounds];
        self.shadowView.frame = containerView.bounds;
        
        [self prepareLayersWithCompletionBlock:^{
            
            CGRect endFrame = fromViewController.view.bounds;
            toView.frame = endFrame;
            toView.alpha = 0.0;
            
            [containerView addSubview:toView];
            [containerView addSubview:_WeakSelf.shadowView];
            [containerView addSubview:_WeakSelf.transformView];
            
            _WeakSelf.transformView.upperBackLayer.contents = (__bridge id)(self.contentImage.CGImage);
            _WeakSelf.transformView.lowerLayer.contents = (__bridge id)(self.contentImage.CGImage);
            
            [_WeakSelf animateEaseInAnimationWithCompletionBlock:^{
                [_WeakSelf animateFlipFrontLayerWithCompletionBlock:^{
                    
                    _WeakSelf.transformView.upperFrontLayer.opacity = 0.0;
                    _WeakSelf.transformView.upperBackLayer.opacity = 1.0;
                    
                    [_WeakSelf animateFlipBackLayerWithCompletionBlock:^{
                        
                        BOOL isCancelled = [transitionContext transitionWasCancelled];
                        if (!isCancelled) {
                            [_WeakSelf.transformView removeFromSuperview];
                            [_WeakSelf.shadowView removeFromSuperview];
                        }
                        
                        _WeakSelf.presentAnimation = isCancelled;
                        toView.alpha = isCancelled ? 0.0 : 1.0;
                        [transitionContext completeTransition:!isCancelled];
                    }];
                }];
            }];
        }];
    } else {
        [self updateContentSnapshot:fromViewController.view afterScreenUpdate:NO];
        
        [fromView removeFromSuperview];
        [containerView addSubview:toView];
        [containerView addSubview:self.shadowView];
        [containerView addSubview:self.transformView];
        
        self.transformView.upperBackLayer.contents = (__bridge id)(self.contentImage.CGImage);
        self.transformView.lowerLayer.contents = (__bridge id)(self.contentImage.CGImage);
        
        [self animateFlipBackLayerWithCompletionBlock:^{
            
            _WeakSelf.transformView.upperBackLayer.opacity = 0.0;
            _WeakSelf.transformView.upperFrontLayer.opacity = 1.0;
            
            [_WeakSelf animateFlipFrontLayerWithCompletionBlock:^{
                [_WeakSelf animateEaseInAnimationWithCompletionBlock:^{
                    
                    BOOL isCancelled = [transitionContext transitionWasCancelled];
                    if (!isCancelled)
                    {
                        [_WeakSelf.transformView removeFromSuperview];
                        [_WeakSelf.shadowView removeFromSuperview];
                        _WeakSelf.transformView = nil;
                    }
                    _WeakSelf.presentAnimation = !isCancelled;
                    [transitionContext completeTransition:!isCancelled];
                }];
            }];
        }];
    }
}

#pragma mark - Preparation
- (void)prepareLayersWithCompletionBlock:(void(^)(void))block
{
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:0.0] forKey:kCATransactionAnimationDuration];
    [CATransaction setCompletionBlock:block];
    
    if (self.presentAnimation) {
        self.transformView.upperFrontLayer.transform = CATransform3DIdentity;
        self.transformView.upperBackLayer.transform = CATransform3DMakeRotation(-M_PI_2, 1.0, 0.0, 0.0);
        self.transformView.upperBackLayer.shadowCover.opacity = 0.5;
        self.transformView.lowerLayer.transform = CATransform3DIdentity;
        self.transformView.lowerLayer.shadowCover.opacity = 1.0;
        
        CATransform3D transform = self.transformView.layer.transform;
        if (_style == MRFlipTransitionPresentingFromBottom) {
            transform = CATransform3DScale(transform, MRScaleFactor, MRScaleFactor, 1.0);
            transform = CATransform3DTranslate(transform, 0, CGRectGetHeight([UIScreen mainScreen].bounds), 0);
        } else {
            transform = CATransform3DScale(transform, MRInfinityFactor * MRScaleFactor, MRInfinityFactor * MRScaleFactor, 1.0);
            transform = CATransform3DTranslate(transform, 0, MRInfinityMerginY, 0);
        }
        self.transformView.layer.transform = transform;
    } else {
        self.transformView.upperFrontLayer.transform = CATransform3DMakeRotation(M_PI_2, 1.0, 0.0, 0.0);
        self.transformView.upperBackLayer.transform = CATransform3DIdentity;
        self.transformView.upperBackLayer.shadowCover.opacity = 0.0;
        self.transformView.lowerLayer.transform = CATransform3DIdentity;
        self.transformView.lowerLayer.shadowCover.opacity = 0.0;
        self.transformView.layer.transform = CATransform3DIdentity;
    }
    
    [CATransaction commit];
}

#pragma mark - Animations
- (void)animateEaseInAnimationWithCompletionBlock:(void(^)(void))block
{
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:MRFlipEaseInDuration] forKey:kCATransactionAnimationDuration];
	[CATransaction setValue:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut] forKey:kCATransactionAnimationTimingFunction];
    [CATransaction setCompletionBlock:block];
    
    BOOL fromBottom = _style == MRFlipTransitionPresentingFromBottom;
    
    CATransform3D transform = self.transformView.layer.transform;
    if (fromBottom) {
        transform = CATransform3DTranslate(transform, 0, (CGRectGetHeight([UIScreen mainScreen].bounds) + MREaseInExtraDistance) * (self.presentAnimation ? -1 : 1) , 0);
        
        CABasicAnimation *easeInAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
        easeInAnimation.fromValue = self.presentAnimation ? @(CGRectGetHeight([UIScreen mainScreen].bounds)) : @(-MREaseInExtraDistance);
        easeInAnimation.toValue = self.presentAnimation ? @(-MREaseInExtraDistance) : @(CGRectGetHeight([UIScreen mainScreen].bounds));
        easeInAnimation.fillMode = kCAFillModeForwards;
        easeInAnimation.removedOnCompletion = NO;
        [self.transformView.layer addAnimation:easeInAnimation forKey:nil];
        self.transformView.layer.transform = transform;
    } else {
        CGFloat factor = self.presentAnimation ? 1 / MRInfinityFactor : MRInfinityFactor;
        CGFloat distance = self.presentAnimation ? - MREaseInExtraDistance - MRInfinityMerginY * MRInfinityFactor :  (MREaseInExtraDistance + MRInfinityMerginY) * (1 / MRInfinityFactor);
        CATransform3D presentTransform = CATransform3DScale(transform, factor, factor, 1.0);
        presentTransform = CATransform3DTranslate(presentTransform, 0, distance, 0);
        
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.fromValue = [NSValue valueWithCATransform3D:transform ];
        animation.toValue = [NSValue valueWithCATransform3D:presentTransform];
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [self.transformView.layer addAnimation:animation forKey:nil];
        self.transformView.layer.transform = presentTransform;
    }
    
    CABasicAnimation *shadowAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    shadowAnimation.fromValue = self.presentAnimation ? @0.0 : @0.4;
    shadowAnimation.toValue = self.presentAnimation ? @0.4 : @0.0;
    shadowAnimation.removedOnCompletion = NO;
    shadowAnimation.fillMode = kCAFillModeForwards;
    [self.shadowView.layer addAnimation:shadowAnimation forKey:nil];
    self.shadowView.layer.opacity = self.presentAnimation ? 0.4 : 0.0;
    
    [CATransaction commit];
}

- (void)animateFlipFrontLayerWithCompletionBlock:(void(^)(void))block
{
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:MRFlipLayerDuration / 2.0] forKey:kCATransactionAnimationDuration];
	[CATransaction setValue:[CAMediaTimingFunction functionWithName:self.presentAnimation ? kCAMediaTimingFunctionEaseIn : kCAMediaTimingFunctionEaseOut] forKey:kCATransactionAnimationTimingFunction];
    [CATransaction setCompletionBlock:block];
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotateAnimation.fromValue = self.presentAnimation ? @0 : @(M_PI_2);
    rotateAnimation.toValue = self.presentAnimation ? @(M_PI_2) : @0;
    rotateAnimation.fillMode = kCAFillModeForwards;
    rotateAnimation.removedOnCompletion = NO;
    [self.transformView.upperFrontLayer addAnimation:rotateAnimation forKey:nil];
    self.transformView.upperFrontLayer.transform = CATransform3DRotate(self.transformView.upperFrontLayer.transform, M_PI_2 * (self.presentAnimation ? 1 : -1), 1.0, 0, 0);
    
    CABasicAnimation *opacityLowerAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityLowerAnimation.fromValue = self.presentAnimation ? @1 : @0.5;
    opacityLowerAnimation.toValue = self.presentAnimation ? @0.5 : @1;
    opacityLowerAnimation.fillMode = kCAFillModeForwards;
    opacityLowerAnimation.removedOnCompletion = NO;
    [self.transformView.lowerLayer.shadowCover addAnimation:opacityLowerAnimation forKey:nil];
    self.transformView.lowerLayer.shadowCover.opacity = self.presentAnimation ? 0.5 : 1.0;
    
    CABasicAnimation *shadowAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    shadowAnimation.fromValue = self.presentAnimation ? @0.4 : @0.7;
    shadowAnimation.toValue = self.presentAnimation ? @0.7 : @0.4;
    shadowAnimation.removedOnCompletion = NO;
    shadowAnimation.fillMode = kCAFillModeForwards;
    [self.shadowView.layer addAnimation:shadowAnimation forKey:nil];
    self.shadowView.layer.opacity = self.presentAnimation ? 0.7 : 0.4;
    
    [CATransaction commit];
}

- (void)animateFlipBackLayerWithCompletionBlock:(void(^)(void))block
{
    [CATransaction begin];
    [CATransaction setValue:[NSNumber numberWithFloat:MRFlipLayerDuration / 2.0] forKey:kCATransactionAnimationDuration];
	[CATransaction setValue:[CAMediaTimingFunction functionWithName:self.presentAnimation ? kCAMediaTimingFunctionEaseOut : kCAMediaTimingFunctionEaseIn] forKey:kCATransactionAnimationTimingFunction];
    [CATransaction setCompletionBlock:block];
    
    CATransform3D transform = self.transformView.layer.transform;
    if (self.presentAnimation) {
        transform = CATransform3DTranslate(transform, 0, MREaseInExtraDistance, 0);
        transform = CATransform3DScale(transform, 1 / MRScaleFactor, 1 / MRScaleFactor, 1.0);
    } else {
        transform = CATransform3DTranslate(transform, 0, - MREaseInExtraDistance, 0);
        transform = CATransform3DScale(transform, MRScaleFactor, MRScaleFactor, 1.0);
    }
    
    CABasicAnimation *transformLayerAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    transformLayerAnimation.fromValue = [NSValue valueWithCATransform3D:self.transformView.layer.transform];
    transformLayerAnimation.toValue = [NSValue valueWithCATransform3D:transform];
    transformLayerAnimation.fillMode = kCAFillModeForwards;
    transformLayerAnimation.removedOnCompletion = NO;
    [self.transformView.layer addAnimation:transformLayerAnimation forKey:nil];
    self.transformView.layer.transform = transform;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    animation.fromValue = self.presentAnimation ? @(-M_PI_2) : @0;
    animation.toValue = self.presentAnimation ? @0 : @(-M_PI_2);
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.transformView.upperBackLayer addAnimation:animation forKey:nil];
    self.transformView.upperBackLayer.transform = CATransform3DRotate(self.transformView.upperBackLayer.transform, M_PI_2 * (self.presentAnimation ? 1 : -1), 1.0, 0, 0);
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = self.presentAnimation ? @0.5 : @0.0;
    opacityAnimation.toValue = self.presentAnimation ? @0.0 : @0.5;
    opacityAnimation.fillMode = kCAFillModeForwards;
    opacityAnimation.removedOnCompletion = NO;
    [self.transformView.upperBackLayer.shadowCover addAnimation:opacityAnimation forKey:nil];
    [self.transformView.lowerLayer.shadowCover addAnimation:opacityAnimation forKey:nil];
    self.transformView.upperBackLayer.shadowCover.opacity = self.presentAnimation ? 0.0 : 0.5;
    self.transformView.lowerLayer.shadowCover.opacity = self.presentAnimation ? 0.0 : 0.5;
    
    CABasicAnimation *shadowAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    shadowAnimation.fromValue = self.presentAnimation ? @0.7 : @1.0;
    shadowAnimation.toValue = self.presentAnimation ? @1.0 : @0.7;
    shadowAnimation.removedOnCompletion = NO;
    shadowAnimation.fillMode = kCAFillModeForwards;
    [self.shadowView.layer addAnimation:shadowAnimation forKey:nil];
    self.shadowView.layer.opacity = self.presentAnimation ? 1.0 : 0.7;
    
    [CATransaction commit];
}

@end
