//
//  UICollectionViewCell+GinAnimation.h
//  LOLBox
//
//  Created by JunhuaShao on 14-9-17.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSTimeInterval GinLivelyDefaultDuration;

typedef NSTimeInterval (^GinLivelyTransform)(CALayer * layer, float speed);

extern GinLivelyTransform GinLivelyTransformCurl;
extern GinLivelyTransform GinLivelyTransformFade;
extern GinLivelyTransform GinLivelyTransformFan;
extern GinLivelyTransform GinLivelyTransformFlip;
extern GinLivelyTransform GinLivelyTransformHelix;
extern GinLivelyTransform GinLivelyTransformTilt;
extern GinLivelyTransform GinLivelyTransformWave;
extern GinLivelyTransform GinLivelyTransformGrow;


@interface UICollectionViewCell (GinAnimation)

- (void)animation:(GinLivelyTransform)transformBlock;

@end
