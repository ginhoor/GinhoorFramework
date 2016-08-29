//
//  GinSystemButton.m
//  demo4AVOS
//
//  Created by Ginhoor on 14-8-1.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "GinSystemButton.h"

@interface GinSystemButton()

@property (strong, nonatomic) CAKeyframeAnimation *touchInSideAnimation;

@end

@implementation GinSystemButton

- (void)dealloc
{
    [self removeTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (instancetype)init
{
    self = [GinSystemButton buttonWithType:UIButtonTypeCustom];
    if (self) {
        [self setup];
    }
    return self;
}

+ (id)buttonWithType:(UIButtonType)buttonType
{
    GinSystemButton *button = [super buttonWithType:buttonType];
    [button setup];
    return button;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
}

- (void)setup
{
    self.layer.cornerRadius = 4.0f;
    self.layer.masksToBounds = YES;
    self.adjustsImageWhenHighlighted = NO;
    self.adjustsImageWhenDisabled = NO;
    
    self.tintColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor colorWithRed:0.106f green:0.749f blue:0.408f alpha:1.000f];
    [self addTarget:self action:@selector(touchUpInsideAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchUpInsideAction:(id)sender
{
    [((UIButton*)sender).layer addAnimation:self.touchInSideAnimation forKey:@"GinPopUpAnimation"];
}

- (CAKeyframeAnimation *)touchInSideAnimation
{
    if (!_touchInSideAnimation) {
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        
        CATransform3D scale1 = CATransform3DMakeScale(0.9, 0.9, 1);
        CATransform3D scale2 = CATransform3DMakeScale(1.05, 1.05, 1);
        CATransform3D scale3 = CATransform3DMakeScale(0.95, 0.95, 1);
        CATransform3D scale4 = CATransform3DMakeScale(1.0, 1.0, 1);
        
        NSArray *frameValues = [NSArray arrayWithObjects:
                                [NSValue valueWithCATransform3D:scale1],
                                [NSValue valueWithCATransform3D:scale2],
                                [NSValue valueWithCATransform3D:scale3],
                                [NSValue valueWithCATransform3D:scale4],
                                nil];
        
        [animation setValues:frameValues];
        
        NSArray *frameTimes = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.0],
                               [NSNumber numberWithFloat:0.5],
                               [NSNumber numberWithFloat:0.8],
                               [NSNumber numberWithFloat:1.0],
                               nil];
        [animation setKeyTimes:frameTimes];
        
        animation.fillMode = kCAFillModeForwards;
        animation.duration = .25;
        _touchInSideAnimation = animation;
    }
    return _touchInSideAnimation;
}



@end
