//
//  GinFloatedButton.m
//  hmeIosCn
//
//  Created by JunhuaShao on 15/4/29.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import "GinFloatedButton.h"

#define kAUTODOCKING_ANIMATE_DURATION 0.2f
#define kDISPLAY_ANIMATE_DURATION 0.2f

@interface GinFloatedButton()

@property (assign, nonatomic, readwrite) BOOL isDragging;
@property (assign, nonatomic) CGPoint beginLocation;
@end

@implementation GinFloatedButton

+ (instancetype)buttonWithType:(UIButtonType)buttonType
{
    GinFloatedButton *btn = [GinFloatedButton buttonWithType:buttonType];
    [btn setup];
    
    return btn;
}

- (void)dealloc
{
    self.tapBlock = nil;
    self.draggingBlock = nil;
    self.dragDoneBlock = nil;
    self.autoDockingBlock = nil;
    self.autoDockingDoneBlock = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initInKeyWindowWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self performSelector:@selector(addButtonToKeyWindow) withObject:nil afterDelay:0];
    }
    return self;
}

- (instancetype)initInView:(UIView *)view WithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [view addSubview:self];
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.draggable = YES;
    self.autoDocking = YES;
    self.limitInBounds = YES;
}

- (void)addButtonToKeyWindow
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)hideAnimated
{
    [UIView animateWithDuration:kDISPLAY_ANIMATE_DURATION animations:^{
        self.alpha = 0;
    }];
}

- (void)showAnimated
{
    [UIView animateWithDuration:kDISPLAY_ANIMATE_DURATION animations:^{
        self.alpha = 1;
    }];
}

- (void)setTapBlock:(void (^)(GinFloatedButton *button))tapBlock {
    _tapBlock = tapBlock;
    if (_tapBlock) {
        [self addTarget:self action:@selector(buttonTouched) forControlEvents:UIControlEventTouchUpInside];
    }
}


#pragma mark - Touch
- (void)buttonTouched {
    [self performSelector:@selector(executeButtonTouchedBlock) withObject:nil afterDelay:0];
}

- (void)executeButtonTouchedBlock {
    if (self.tapBlock && !self.isDragging) {
        self.tapBlock(self);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.isDragging = NO;
    [super touchesBegan:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    if (touch.tapCount == 1) {
    }
    
    self.beginLocation = [[touches anyObject] locationInView:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (self.draggable) {
        self.isDragging = YES;
        
        UITouch *touch = [touches anyObject];
        CGPoint currentLocation = [touch locationInView:self];
        
        CGFloat offsetX = currentLocation.x - self.beginLocation.x;
        CGFloat offsetY = currentLocation.y - self.beginLocation.y;
        
        
        self.center = CGPointMake(self.center.x + offsetX, self.center.y + offsetY);
        
        if (self.limitInBounds) {
            CGRect superviewFrame = self.superview.frame;
            CGRect frame = self.frame;
            
            //        当前Button在父视图中，center到边界的限制距离
            CGFloat leftLimitX = frame.size.width/2;
            CGFloat rightLimitX = superviewFrame.size.width - leftLimitX;
            CGFloat topLimitY = frame.size.height/2;
            CGFloat bottomLimitY = superviewFrame.size.height - topLimitY;
            
            if (self.center.x > rightLimitX) {
                self.center = CGPointMake(rightLimitX, self.center.y);
            } else if (self.center.x <= leftLimitX) {
                self.center = CGPointMake(leftLimitX, self.center.y);
            }
            
            if (self.center.y > bottomLimitY) {
                self.center = CGPointMake(self.center.x, bottomLimitY);
            }else if (self.center.y <= topLimitY){
                self.center = CGPointMake(self.center.x, topLimitY);
            }
        }
        
        if (self.draggingBlock) {
            self.draggingBlock(self);
        }
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if (self.isDragging && self.dragDoneBlock) {
        self.dragDoneBlock(self);
    }
    
    if (self.isDragging && self.autoDocking) {
        CGRect superviewFrame = self.superview.frame;
        CGRect frame = self.frame;
        CGFloat middleX = superviewFrame.size.width / 2;
        CGPoint endLocation = self.center.x >= middleX ?
                            CGPointMake(superviewFrame.size.width - frame.size.width / 2, self.center.y) :
                            CGPointMake(frame.size.width / 2, self.center.y);
        
        [UIView animateWithDuration:kAUTODOCKING_ANIMATE_DURATION animations:^{
            self.center = endLocation;
            if (self.autoDockingBlock) {
                self.autoDockingBlock(self);
            }
        } completion:^(BOOL finished) {
            if (self.autoDockingDoneBlock) {
                self.autoDockingDoneBlock(self);
            }
        }];
    }
    self.isDragging = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.isDragging = NO;
    [super touchesCancelled:touches withEvent:event];
}

#pragma mark - remove
+ (void)removeAllFromKeyWindow {
    for (id view in [[UIApplication sharedApplication].keyWindow subviews]) {
        if ([view isKindOfClass:[GinFloatedButton class]]) {
            [view removeFromSuperview];
        }
    }
}

+ (void)removeAllFromView:(id)superView {
    for (id view in [superView subviews]) {
        if ([view isKindOfClass:[GinFloatedButton class]]) {
            [view removeFromSuperview];
        }
    }
}



@end
