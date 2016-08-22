//
//  GinFloatedButton.h
//  hmeIosCn
//
//  Created by JunhuaShao on 15/4/29.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GinFloatedButton : UIButton

@property (assign, nonatomic, readonly) BOOL isDragging;
@property (assign, nonatomic) BOOL draggable;
@property (assign, nonatomic) BOOL autoDocking;
@property (assign, nonatomic) BOOL limitInBounds;

@property (copy, nonatomic) void(^tapBlock)(GinFloatedButton *button);
@property (copy, nonatomic) void(^draggingBlock)(GinFloatedButton *button);
@property (copy, nonatomic) void(^dragDoneBlock)(GinFloatedButton *button);

@property (copy, nonatomic) void(^autoDockingBlock)(GinFloatedButton *button);
@property (copy, nonatomic) void(^autoDockingDoneBlock)(GinFloatedButton *button);

- (instancetype)initInKeyWindowWithFrame:(CGRect)frame;
- (instancetype)initInView:(UIView *)view WithFrame:(CGRect)frame;
- (void)addButtonToKeyWindow;

- (BOOL)isDragging;

+ (void)removeAllFromKeyWindow;
+ (void)removeAllFromView:(id)superView;

- (void)hideAnimated;
- (void)showAnimated;

@end
