//
//  GinTextView.h
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/7/1.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GinTextView : UITextView

@property (strong, nonatomic) UILabel *placeholder;

@property (copy, nonatomic) void (^textViewDidChangeBlock)(UITextView *textView);

@end
