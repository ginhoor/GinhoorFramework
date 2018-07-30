//
//  GinPopup+Unit.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/21.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GinPopup.h"

@interface GinPopup (Unit)

+ (void)showTitle:(NSString *)title text:(NSString *)text submitButton:(NSString *)buttonTitle onClick:(void(^)(void))onClock;
+ (void)showTitle:(NSString*)title text:(NSString*)text;


@end
