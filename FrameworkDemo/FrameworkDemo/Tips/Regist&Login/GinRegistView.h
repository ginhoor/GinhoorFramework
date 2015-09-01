//
//  GinRegistView.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/8/31.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconTextField.h"


typedef NS_ENUM(NSInteger, GinRegistViewType) {
    GinRegistViewTypeLogin,
    GinRegistViewTypeQuickLogin,
    GinRegistViewTypeRegist,
    GinRegistViewTypeFindPassword,
};

@interface GinRegistView : UIView

@property (assign, nonatomic) GinRegistViewType type;
@property (assign, nonatomic) CGFloat minimumLineSpacing;
@property (assign, nonatomic) CGFloat nextStepButtonOffsetY;

@property (strong, nonatomic) IconTextField *userName;
@property (strong, nonatomic) IconTextField *password;
@property (strong, nonatomic) IconTextField *checkPassword;

@property (strong, nonatomic) IconTextField *userPhone;
@property (strong, nonatomic) IconTextField *randomCode;
@property (strong, nonatomic) UIButton *getRandomCode;

@property (strong, nonatomic) UIButton *nextStep;

- (instancetype)initWithType:(GinRegistViewType)type;

@end
