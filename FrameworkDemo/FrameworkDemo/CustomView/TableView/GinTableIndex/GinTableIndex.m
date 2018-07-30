//
//  GinTableIndex.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/6/26.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GinTableIndex.h"



#define RGB(r,g,b,a)  [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:a]

@interface GinTableIndex ()
{
    BOOL isLayedOut;
    CAShapeLayer *shapeLayer;
}

@property (strong, nonatomic) NSArray *letters;
@property (assign, nonatomic) CGFloat letterHeight;

@end


@implementation GinTableIndex

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{

    self.backgroundColor = [UIColor clearColor];

    shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineCapSquare;
    shapeLayer.strokeColor = [[UIColor clearColor] CGColor];
    shapeLayer.strokeEnd = 1.0f;
    self.layer.masksToBounds = NO;
}

- (void)setTableIndexDelegate:(id<GinTableIndexDelegate>)tableIndexDelegate
{
    _tableIndexDelegate = tableIndexDelegate;
    self.letters = [self.tableIndexDelegate tableViewIndexTitle:self];
    isLayedOut = NO;
    [self layoutSubviews];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setup];
    
    if (!isLayedOut){
        
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        
        shapeLayer.frame = (CGRect) {.origin = CGPointZero, .size = self.layer.frame.size};
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointZero];
        [bezierPath addLineToPoint:CGPointMake(0, self.frame.size.height)];
        self.letterHeight = 16; //self.frame.size.height / [letters count];
        CGFloat fontSize = 12;
        if (self.letterHeight < 14){
            fontSize = 11;
        }
        
        [self.letters enumerateObjectsUsingBlock:^(NSString *letter, NSUInteger idx, BOOL *stop) {
            CGFloat originY = idx * self.letterHeight;
            CATextLayer *ctl = [self textLayerWithSize:fontSize
                                                string:letter
                                              andFrame:CGRectMake(0, originY, self.frame.size.width, self.letterHeight)];
            [self.layer addSublayer:ctl];
            [bezierPath moveToPoint:CGPointMake(0, originY)];
            [bezierPath addLineToPoint:CGPointMake(ctl.frame.size.width, originY)];
        }];
        
        shapeLayer.path = bezierPath.CGPath;
        [self.layer addSublayer:shapeLayer];
        
        isLayedOut = YES;
    }
}

- (CATextLayer*)textLayerWithSize:(CGFloat)size string:(NSString*)string andFrame:(CGRect)frame{
    CATextLayer *tl = [CATextLayer layer];
    [tl setFont:@"ArialMT"];
    [tl setFontSize:size];
    [tl setFrame:frame];
    [tl setAlignmentMode:kCAAlignmentCenter];
    [tl setContentsScale:[[UIScreen mainScreen] scale]];
    [tl setForegroundColor:RGB(168, 168, 168, 1).CGColor];
    [tl setString:string];
    return tl;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    [self sendEventToDelegate:event];
    
    [self.tableIndexDelegate tableViewIndexTouchesBegan:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    [self sendEventToDelegate:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    [self.tableIndexDelegate tableViewIndexTouchesEnd:self];
}

- (void)sendEventToDelegate:(UIEvent*)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    
    NSInteger index = ((NSInteger) floorf(point.y) / self.letterHeight);
    
    if (index< 0 || index > self.letters.count - 1) {
        return;
    }
    
    [self.tableIndexDelegate tableViewIndex:self didSelectSectionAtIndex:index withTitle:self.letters[index]];
}


@end
