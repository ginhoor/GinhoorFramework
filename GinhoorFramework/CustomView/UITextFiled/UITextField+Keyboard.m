//
//  UITextField+Keyboard.m
//  LOLBox
//
//  Created by Ginhoor on 14-1-23.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//


#import "UITextField+Keyboard.h"
#import "GinSystemButton.h"
#import <BlocksKit+UIKit.h>
@implementation UITextField (Keyboard)

- (void)addHideKeyboardButton
{    
    GinSystemButton *button = [GinSystemButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"收起键盘" forState:UIControlStateNormal];
    button.frame = CGRectMake(5, 2, 70, 26);
    [button bk_whenTapped:^{
        [self resignFirstResponder];
    }];
    button.backgroundColor = [UIColor lightGrayColor];
    button.tintColor = [UIColor whiteColor];
    
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30)];
    [bar addSubview:button];
    self.inputAccessoryView = bar;
}

@end
