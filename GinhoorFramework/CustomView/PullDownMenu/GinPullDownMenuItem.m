//
//  GinPullDownMenuItem.m
//  hme.ios.cn
//
//  Created by JunhuaShao on 15/3/20.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import "GinPullDownMenuItem.h"
#import "NSString+Size.h"

@interface GinPullDownMenuItem()

@property (strong, nonatomic) UIControl *control;
@property (strong, nonatomic) UIView *indicator;
@property (strong, nonatomic) CAShapeLayer *indicatorShapeLayer;

@end

@implementation GinPullDownMenuItem

- (void)dealloc
{
    self.tapBlock = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.titleLabel];
    [self addSubview:self.indicator];
    [self addSubview:self.control];
    
    self.indicatorColor = [UIColor lightGrayColor];
    
}

- (void)updateConstraints
{
    [self.control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(3);
        make.centerY.equalTo(self.titleLabel);
        make.size.sizeOffset(CGSizeMake(8, 5));
    }];
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    CGSize size = [self.titleLabel.text getStringSizeWithfont:self.titleLabel.font height:self.bounds.size.height];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.equalTo(self);
        make.width.offset(size.width);
    }];
    [super layoutSubviews];
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = self.titleTextColor;
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UIView *)indicator
{
    if (!_indicator) {
        _indicator = [[UIView alloc] init];
        [_indicator.layer addSublayer:self.indicatorShapeLayer];
    }
    return _indicator;
}

- (CAShapeLayer *)indicatorShapeLayer
{
    if (!_indicatorShapeLayer) {
        _indicatorShapeLayer = [self createIndicatorLayerWithColor:self.indicatorColor];
    }
    return _indicatorShapeLayer;
}

- (UIControl *)control
{
    if (!_control) {
        _control = [[UIControl alloc]init];
        [_control addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _control;
}

- (void)setIndicatorColor:(UIColor *)indicatorColor
{
    _indicatorColor = indicatorColor;
    self.indicatorShapeLayer.fillColor = [UIColor lightGrayColor].CGColor;
}


- (void)tapAction:(id)sender
{
    if (self.tapBlock) {
        self.tapBlock(self);
    }
}

- (CAShapeLayer *)createIndicatorLayerWithColor:(UIColor *)color
{
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.name = @"indicator";
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(8, 0)];
    [path addLineToPoint:CGPointMake(4, 5)];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.fillColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    layer.position = CGPointMake(4, 2);
    return layer;
}

- (void)animateTitleLabel:(BOOL)selected
{
    self.titleLabel.font = selected?[UIFont boldSystemFontOfSize:14]:[UIFont systemFontOfSize:14];
}

- (void)animateIndicator:(BOOL)selected completedBlock:(void(^)())completedBlock
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    animation.values = selected? @[@0,@(M_PI)]:@[@(M_PI),@0];

    if (!animation.removedOnCompletion) {
        [self.indicatorShapeLayer addAnimation:animation forKey:animation.keyPath];
    } else {
        [self.indicatorShapeLayer addAnimation:animation forKey:animation.keyPath];
        [self.indicatorShapeLayer setValue:animation.values.lastObject forKeyPath:animation.keyPath];
    }
    
    [CATransaction commit];
    
    self.indicatorShapeLayer.fillColor = self.indicatorColor.CGColor;
    
    if (completedBlock) {
        completedBlock();
    }
}



@end
