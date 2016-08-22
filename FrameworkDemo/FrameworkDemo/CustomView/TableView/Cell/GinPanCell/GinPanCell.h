//
//  GinPanCell.h
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/7/4.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GinPanCell : UITableViewCell

@property (strong, nonatomic) UIView *cellContentView;

@property (copy, nonatomic) void(^didActionButtonsWillHide)(id sender);
@property (copy, nonatomic) void(^didActionButtonsHided)(id sender);
@property (copy, nonatomic) void(^didActionButtonsWillShow)(id sender);
@property (copy, nonatomic) void(^didActionButtonsShowed)(id sender);
@property (copy, nonatomic) void(^didActionButtonsClicked)(id sender, NSUInteger index);

- (void)setup;
/**
 *  自动 addSubview 到cellContentView
 *  自动 addTarget 在
 */
- (void)setActionButtons:(NSArray *)actionButtons;

- (void)hideMenuView:(BOOL)aHide Animated:(BOOL)aAnimate;

@end
