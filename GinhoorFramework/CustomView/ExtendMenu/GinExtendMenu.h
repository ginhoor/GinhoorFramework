//
//  GinExtendMenu.h
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/5/22.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GinExtendMenu : UIView

@property (assign, nonatomic) CGFloat contentViewHeight;

@property (strong, nonatomic) UIView *contentView;
@property (assign, nonatomic) BOOL extended;

@property (copy, nonatomic) BOOL(^isExtendedBlock)();
@property (copy, nonatomic) void(^extendedCompletedBlock)(BOOL extended);

@end
