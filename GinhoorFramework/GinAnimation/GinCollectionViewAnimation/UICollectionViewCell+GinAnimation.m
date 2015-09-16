//
//  UICollectionViewCell+GinAnimation.m
//  LOLBox
//
//  Created by JunhuaShao on 14-9-17.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "UICollectionViewCell+GinAnimation.h"

NSTimeInterval GinLivelyDefaultDuration = 0.3;

CGFloat CGFloatSign(CGFloat value) {
    if (value < 0) {
        return -1.0f;
    }
    return 1.0f;
}

GinLivelyTransform GinLivelyTransformCurl = ^(CALayer * layer, float speed){
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = 1.0 / -500;
    transform = CATransform3DTranslate(transform, -layer.bounds.size.width/2.0f, 0.0f, 0.0f);
    transform = CATransform3DRotate(transform, M_PI/2, 0.0f, 1.0f, 0.0f);
    layer.transform = CATransform3DTranslate(transform, layer.bounds.size.width/2.0f, 0.0f, 0.0f);
    return GinLivelyDefaultDuration;
};

GinLivelyTransform GinLivelyTransformFade = ^(CALayer * layer, float speed){
    if (speed != 0.0f) { // Don't animate the initial state
        layer.opacity = 1.0f - fabs(speed);
    }
    return 2 * GinLivelyDefaultDuration;
};

GinLivelyTransform GinLivelyTransformFan = ^(CALayer * layer, float speed){
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, -layer.bounds.size.width/2.0f, 0.0f, 0.0f);
    transform = CATransform3DRotate(transform, -M_PI/2 * speed, 0.0f, 0.0f, 1.0f);
    layer.transform = CATransform3DTranslate(transform, layer.bounds.size.width/2.0f, 0.0f, 0.0f);
    layer.opacity = 1.0f - fabs(speed);
    return 2 * GinLivelyDefaultDuration;
};

GinLivelyTransform GinLivelyTransformFlip = ^(CALayer * layer, float speed){
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0.0f, CGFloatSign(speed) * layer.bounds.size.height/2.0f, 0.0f);
    transform = CATransform3DRotate(transform, CGFloatSign(speed) * M_PI/2, 1.0f, 0.0f, 0.0f);
    layer.transform = CATransform3DTranslate(transform, 0.0f, -CGFloatSign(speed) * layer.bounds.size.height/2.0f, 0.0f);
    layer.opacity = 1.0f - fabs(speed);
    return 2 * GinLivelyDefaultDuration;
};

GinLivelyTransform GinLivelyTransformHelix = ^(CALayer * layer, float speed){
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DTranslate(transform, 0.0f, CGFloatSign(speed) * layer.bounds.size.height/2.0f, 0.0f);
    transform = CATransform3DRotate(transform, M_PI, 0.0f, 1.0f, 0.0f);
    layer.transform = CATransform3DTranslate(transform, 0.0f, -CGFloatSign(speed) * layer.bounds.size.height/2.0f, 0.0f);
    layer.opacity = 1.0f - 0.2*fabs(speed);
    return 2 * GinLivelyDefaultDuration;
};

GinLivelyTransform GinLivelyTransformTilt = ^(CALayer * layer, float speed){
    if (speed != 0.0f) { // Don't animate the initial state
        layer.transform = CATransform3DMakeScale(0.7f, 0.7f, 0.7f);
        layer.opacity = 1.0f - fabs(speed);
    }
    return 2 * GinLivelyDefaultDuration;
};

GinLivelyTransform GinLivelyTransformWave = ^(CALayer * layer, float speed){
    if (speed != 0.0f) { // Don't animate the initial state
//        layer.transform = CATransform3DMakeTranslation(-layer.bounds.size.width/2.0f, 0.0f, 0.0f);
        layer.transform = CATransform3DMakeTranslation(-layer.bounds.size.width/2.0f, 0.0f, 0.0f);
    }
    return GinLivelyDefaultDuration;
};

GinLivelyTransform GinLivelyTransformGrow = ^(CALayer * layer, float speed){
    if (speed != 0.0f) { // Don't animate the initial state
        layer.transform = CATransform3DMakeScale(0.0, 0.0, 1.0);
    }
    return GinLivelyDefaultDuration;
};

@implementation UICollectionViewCell (GinAnimation)

- (void)animation:(GinLivelyTransform)transformBlock;
{

    /***如何计算 speed
     
     - (void)scrollViewDidScroll:(UIScrollView *)scrollView {
        self.lastScrollPosition = self.currentScrollPosition;
        self.currentScrollPosition = [scrollView contentOffset];
     }
     
     - (CGPoint)scrollSpeed {
        return CGPointMake(self.lastScrollPosition.x - self.currentScrollPosition.x,
        self.lastScrollPosition.y - self.currentScrollPosition.y);
     }
     
     
     float speed = self.scrollSpeed.y;
     
    ***/
    float speed = 20;
    float normalizedSpeed = MAX(-1.0f, MIN(1.0f, speed/20.0f));
    
    BOOL shouldAnimate = YES;
    
    if (transformBlock && shouldAnimate) {
        NSTimeInterval animationDuration = transformBlock(self.layer, normalizedSpeed);
        // The block-based equivalent doesn't play well with iOS 4
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:animationDuration];
    }
    self.layer.transform = CATransform3DIdentity;
    self.layer.opacity = 1.0f;
    if (transformBlock) {
        [UIView commitAnimations];
    }
}


@end
