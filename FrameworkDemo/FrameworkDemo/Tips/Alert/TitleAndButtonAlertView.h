//
//  VehicleSelectedAlertView.h
//  WeAreInspector
//
//  Created by JunhuaShao on 16/8/26.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TitleAndButtonAlertView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, copy) void(^cancleActionBlock)();
@property (nonatomic, copy) void(^submitActionBlock)();

@end
