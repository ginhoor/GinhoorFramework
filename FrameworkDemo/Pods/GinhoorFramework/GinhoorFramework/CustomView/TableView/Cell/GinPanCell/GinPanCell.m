//
//  GinPanCell.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/7/4.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GinPanCell.h"

#define BOUNENCE 30

@interface GinPanCell()

@property (assign, nonatomic) CGFloat startLocation;
@property (assign, nonatomic) BOOL hideMenuView;
@property (strong, nonatomic, readonly) NSArray *actionButtons;

@end

@implementation GinPanCell


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.clipsToBounds = YES;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.cellContentView];
    
    UIPanGestureRecognizer *vPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    vPanGesture.delegate = self;
    [self.cellContentView addGestureRecognizer:vPanGesture];
}

- (void)setActionButtons:(NSArray *)actionButtons;
{
    if (_actionButtons) {
        [_actionButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
            [button removeTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [button removeFromSuperview];
        }];
    }
    
    [actionButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        button.tag = idx;
        [self.contentView insertSubview:button belowSubview:self.cellContentView];
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    _actionButtons = actionButtons;
}

- (void)buttonAction:(UIButton *)sender
{
    if (self.didActionButtonsClicked) {
        self.didActionButtonsClicked(sender,sender.tag);
    }
}

- (void)hideMenuView:(BOOL)aHide Animated:(BOOL)aAnimate
{
    if (self.selected) {
        [self setSelected:NO animated:NO];
    }
    CGRect vDestinaRect = CGRectZero;
    if (aHide) {
        vDestinaRect = self.contentView.frame;
    }else{
        vDestinaRect = CGRectMake(-[self getMaxMenuWidth], self.contentView.frame.origin.x,
                                  self.contentView.frame.size.width, self.contentView.frame.size.height);
    }
    
    CGFloat vDuration = aAnimate? 0.4 : 0.0;
    [UIView animateWithDuration:vDuration animations:^{
        self.cellContentView.frame = vDestinaRect;
    } completion:^(BOOL finished) {
        if (aHide) {
            if (self.didActionButtonsHided) {
                self.didActionButtonsHided(self);
            }
        }else{
            if (self.didActionButtonsShowed) {
                self.didActionButtonsShowed(self);
            }
        }
        UIView *vMenuView = [self.contentView viewWithTag:100];
        vMenuView.hidden = aHide;
    }];
}

- (void)handlePan:(UIPanGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.startLocation = [sender locationInView:self.contentView].x;
        CGFloat direction = [sender velocityInView:self.contentView].x;
        if (direction < 0) {
            if (self.didActionButtonsWillShow) {
                self.didActionButtonsWillShow(self);
            }
        }else{
            if (self.didActionButtonsWillHide) {
                self.didActionButtonsWillHide(self);
            }
        }
    }else if (sender.state == UIGestureRecognizerStateChanged){
        CGFloat vCurrentLocation = [sender locationInView:self.contentView].x;
        CGFloat vDistance = vCurrentLocation - self.startLocation;
        self.startLocation = vCurrentLocation;
        
        CGRect vCurrentRect = self.cellContentView.frame;
        CGFloat vOriginX = MAX(-[self getMaxMenuWidth] - BOUNENCE, vCurrentRect.origin.x + vDistance);
        vOriginX = MIN(0 + BOUNENCE, vOriginX);
        self.cellContentView.frame = CGRectMake(vOriginX, vCurrentRect.origin.y, vCurrentRect.size.width, vCurrentRect.size.height);
        
        CGFloat direction = [sender velocityInView:self.contentView].x;

        if (direction < -40.0 || vOriginX <  - (0.5 * [self getMaxMenuWidth])) {
            self.hideMenuView = NO;
            UIView *vMenuView = [self.contentView viewWithTag:100];
            vMenuView.hidden = self.hideMenuView;
        }else if(direction > 20.0 || vOriginX >  - (0.5 * [self getMaxMenuWidth])){
            self.hideMenuView = YES;
        }
    }else if (sender.state == UIGestureRecognizerStateEnded){
        [self hideMenuView:self.hideMenuView Animated:YES];
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint vTranslationPoint = [gestureRecognizer translationInView:self.contentView];
        return fabs(vTranslationPoint.x) > fabs(vTranslationPoint.y);
    }
    return YES;
}


- (CGFloat)getMaxMenuWidth
{
    __block CGFloat width = 0;
    
    [self.actionButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        width += button.bounds.size.width;
    }];
    return width;
}


- (UIView *)cellContentView
{
    if (!_cellContentView) {
        _cellContentView = [[UIView alloc] init];
        _cellContentView.backgroundColor = [UIColor whiteColor];
    }
    return _cellContentView;
}


@end
