//
//  GinTextView.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/7/1.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Masonry.h>

#import "GinTextView.h"

@interface GinTextView() <UITextViewDelegate>

@end
@implementation GinTextView


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.placeholder = [[UILabel alloc] init];
    [self addSubview:self.placeholder];
    self.placeholder.textColor = [UIColor colorWithRed:0.800f green:0.800f blue:0.800f alpha:1.000f];
    self.delegate = self;
    
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints
{
    [super updateConstraints];
}

- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    self.placeholder.font = self.font;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeholder.frame = CGRectMake(10, 10, 0, 0);
    [self.placeholder sizeToFit];
}

- (void)setContentInset:(UIEdgeInsets)contentInset
{
    [super setContentInset:contentInset];
    
    self.placeholder.frame = CGRectMake(contentInset.left, contentInset.top, 0, 0);
    [self.placeholder sizeToFit];
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {//检测到“完成”
        [textView resignFirstResponder];//释放键盘
        return NO;
    }
    if (self.text.length==0){//textview长度为0
        if ([text isEqualToString:@""]) {//判断是否为删除键
            self.placeholder.hidden=NO;//隐藏文字
        }else{
            self.placeholder.hidden=YES;
        }
    }else{//textview长度不为0
        if (self.text.length==1){//textview长度为1时候
            if ([text isEqualToString:@""]) {//判断是否为删除键
                self.placeholder.hidden=NO;
            }else{//不是删除
                self.placeholder.hidden=YES;
            }
        }else{//长度不为1时候
            self.placeholder.hidden=YES;
        }
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (self.textViewDidChangeBlock) {
        self.textViewDidChangeBlock(textView);
    }
}
@end
