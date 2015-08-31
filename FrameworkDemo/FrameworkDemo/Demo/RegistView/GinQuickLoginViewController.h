//
//  GinQuickLoginViewController.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/8/31.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, GinRegistViewType) {
    GinRegistViewTypeQuickLogin,
    GinRegistViewTypeFindPassword,
};

@interface GinQuickLoginViewController : UIViewController

@property (assign, nonatomic) GinRegistViewType type;

@end
