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

@property (strong, nonatomic) UIImageView *arrowImageView;

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
    [self addSubview:self.arrowImageView];
    
    self.indicatorColor = [UIColor lightGrayColor];
    
    [self setConstraints];
}

// 设置 view 的初次约束
- (void)setConstraints
{
    [self.control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.indicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(3);
        make.centerY.equalTo(self.titleLabel);
        make.size.sizeOffset(CGSizeMake(8, 5));
    }];
}



- (void)updateConstraints
{
    
    if (self.type == GinPullDownMenuItemTypeNormal) {
        [self.indicator mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(3);
            make.centerY.equalTo(self.titleLabel);
            make.size.sizeOffset(CGSizeMake(8, 5));
        }];
    } else {
        self.indicator.hidden = YES;
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            
            if (CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) {
                make.left.offset(20);
            } else {
                make.left.offset(15);
            }
            
            make.right.offset(-20);
            make.top.offset(0);
            make.bottom.offset(0);
        }];
        
        [self.arrowImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) {
                make.right.offset(-5);
            } else {
                make.right.offset(-0);
            }
            make.centerY.equalTo(self.titleLabel);
            make.size.sizeOffset(CGSizeMake(44, 44));
        }];
    }
    
    [super updateConstraints];
}

- (void)layoutSubviews
{
    if (self.type == GinPullDownMenuItemTypeNormal) {
        CGSize size = [self.titleLabel.text getStringSizeWithfont:self.titleLabel.font height:self.bounds.size.height];
        
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.height.equalTo(self);
            make.width.offset(size.width);
        }];
    }
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

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.highlightedImage = [UIImage imageNamed:@"arrow_up_44x44"];
        _arrowImageView.image = [UIImage imageNamed:@"arrow_down_44x44"];
    }
    return _arrowImageView;
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
    CGFloat pointSize = self.titleLabel.font.pointSize;
    
    if (self.titleLabel.attributedText) {
        NSRange range = NSMakeRange(0, self.titleLabel.attributedText.length);
        NSDictionary *dic = [self.titleLabel.attributedText attributesAtIndex:0 effectiveRange:&range];
        UIFont *font = [dic objectForKey:NSFontAttributeName];
        pointSize = font.pointSize;
    }
    
    self.titleLabel.font = selected?[UIFont boldSystemFontOfSize:pointSize]:[UIFont systemFontOfSize:pointSize];
}
- (void)animateIndicator:(BOOL)selected completedBlock:(void(^)())completedBlock
{
    if (self.type == GinPullDownMenuItemTypeNormal) {
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
    } else {
        self.arrowImageView.highlighted = selected;
    }
    
    
    if (completedBlock) {
        completedBlock();
    }
}



@end
