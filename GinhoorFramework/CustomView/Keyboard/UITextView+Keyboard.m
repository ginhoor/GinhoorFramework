//
//  UITextView+Keyboard.m
//  hmeIosCn
//
//  Created by JunhuaShao on 15/4/23.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import <BlocksKit+UIKit.h>

#import "UITextView+Keyboard.h"
#import "GinSystemButton.h"

@implementation UITextView (Keyboard)

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
