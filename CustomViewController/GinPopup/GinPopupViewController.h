//
//  GinPopupViewController.h
//  demo4TextKit
//
//  Created by JunhuaShao on 15/3/23.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GinPopupViewController : UIViewController

@property (copy, nonatomic) void(^backgroundTapBlock)(id sender);
@property (copy, nonatomic) void(^modelDidHideBlock)();

- (void)setPopupContentView:(UIView*)contentView;

- (void)showAnimated:(BOOL)animated;
- (void)hideAnimated:(BOOL)animated completion:(void(^)())completion;

@end
