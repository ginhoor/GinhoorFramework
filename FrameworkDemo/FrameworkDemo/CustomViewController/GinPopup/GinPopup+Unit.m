//
//  GinPopup+Unit.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/21.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "Gin_Macro.h"
#import "BlocksKit+UIKit.h"
#import "Masonry.h"
#import "GinPopup+Unit.h"
#import "GinSystemButton.h"

@implementation GinPopup (Unit)

+ (void)showTitle:(NSString*)title text:(NSString*)text
{
    [GinPopup showWithContentView:[self viewWithTitle:title text:text]];
}

+ (void)showTitle:(NSString *)title text:(NSString *)text submitButton:(NSString *)buttonTitle onClick:(void(^)(void))onClock
{
    UIView *view = [self viewWithTitle:title text:text button:buttonTitle];
    GinSystemButton *button = (GinSystemButton*)[view viewWithTag:0x14];
    [button bk_whenTapped:^{
        if (onClock) {
            onClock();
        }
    }];
    [GinPopup showWithContentView:view];
}

+ (UIView *)viewWithTitle:(NSString *)title text:(NSString *)text
{
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    NSAttributedString *textString = [[NSAttributedString alloc] initWithString:text attributes:@{NSBaselineOffsetAttributeName:@(1.5),NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    NSAttributedString *titleString = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}];
    
    CGFloat viewWitdh = screenSize.width - 20;
    CGSize contentSize = [textString boundingRectWithSize:CGSizeMake(viewWitdh, screenSize.height*0.6)  options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesDeviceMetrics context:nil].size;
    
    CGFloat titleWitdh = viewWitdh-10;
    CGSize titleSize = [titleString boundingRectWithSize:CGSizeMake(titleWitdh, 100)  options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    CGFloat titleHeight = titleSize.height+2;
    
    CGFloat viewheight = titleHeight+5+0.5+contentSize.height;
    
    if (viewheight > screenSize.height*0.6) {
        viewheight = screenSize.height*0.6;
    } else if (viewheight < screenSize.height*0.2){
        viewheight = screenSize.height*0.2;
    } else {
        viewheight += 16;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWitdh, viewheight)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 4;
    if (titleSize.height > 100) {
        titleSize.height = 100;
    }
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.tag = 0x11;
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(5);
        make.left.equalTo(view).offset(5);
        make.size.sizeOffset(CGSizeMake(titleWitdh, titleHeight));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.attributedText = titleString;
    
    // 标题分割线
    UIView *separatorLine = [[UIView alloc] init];
    separatorLine.tag = 0x12;
    [view addSubview:separatorLine];
    [separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.left.equalTo(view).offset(2);
        make.right.equalTo(view).offset(2);
        make.height.offset(0.5);
    }];
    separatorLine.backgroundColor = [UIColor lightGrayColor];
    
    //显示区域
    UITextView *textView = [[UITextView alloc] init];
    textView.tag = 0x13;
    [view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separatorLine.mas_bottom);
        make.left.equalTo(titleLabel);
        make.right.equalTo(titleLabel);
        make.bottom.equalTo(view.mas_bottom);
    }];
    textView.backgroundColor = [UIColor clearColor];
    textView.editable = NO;
    textView.attributedText = textString;
    return view;
}

+ (UIView *)viewWithTitle:(NSString *)title text:(NSString *)text button:(NSString *)buttonTitle
{
    NSAttributedString *textString = [[NSAttributedString alloc] initWithString:text attributes:@{NSBaselineOffsetAttributeName:@(1.5),NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    NSAttributedString *titleString = [[NSAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}];
    
    CGFloat viewWitdh = SCREEN_WIDTH - 10;
    CGSize contentSize = [textString boundingRectWithSize:CGSizeMake(viewWitdh, SCREEN_HEIGHT*0.6)  options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesDeviceMetrics context:nil].size;
    // *** Title ***
    CGFloat titleWitdh = viewWitdh-10;
    CGSize titleSize = [titleString boundingRectWithSize:CGSizeMake(titleWitdh, 100)  options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin context:nil].size;
    CGFloat titleHeight = titleSize.height+2;
    
    
    // *** Button Tile **
    NSAttributedString *buttonTitleString = [[NSAttributedString alloc] initWithString:buttonTitle attributes:@{NSBaselineOffsetAttributeName:@(1.5),NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    
    CGSize buttonSize = [buttonTitleString boundingRectWithSize:CGSizeMake(viewWitdh, 40)  options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesDeviceMetrics context:nil].size;
    CGFloat buttonWidth = buttonSize.width;
    
    if (buttonWidth<SCREEN_WIDTH*0.1875) {
        buttonWidth = SCREEN_WIDTH*0.1875;
    } else if (buttonWidth>viewWitdh){
        buttonWidth = viewWitdh-SCREEN_WIDTH*0.125;
    }
    
    CGFloat viewheight = titleHeight+5+0.5+contentSize.height+(40)+5;
    
    if (viewheight > SCREEN_HEIGHT*0.6) {
        viewheight = SCREEN_HEIGHT*0.6;
    } else if (viewheight < SCREEN_HEIGHT*0.2){
        viewheight = SCREEN_HEIGHT*0.2;
    } else {
        viewheight += 16;
    }
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewWitdh, viewheight)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 4;
    
    if (titleSize.height > 100) {
        titleSize.height = 100;
    }
    
    // 标题
    UILabel *titleLabel = [[UILabel alloc] init];
    
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(5);
        make.left.equalTo(view).offset(5);
        make.size.sizeOffset(CGSizeMake(titleWitdh, titleHeight));
    }];
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.attributedText = titleString;
    
    // 标题分割线
    UIView *separatorLine = [[UIView alloc] init];
    
    [view addSubview:separatorLine];
    [separatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(5);
        make.left.equalTo(view).offset(2);
        make.right.equalTo(view).offset(2);
        make.height.offset(0.5);
    }];
    separatorLine.backgroundColor = [UIColor lightGrayColor];
    
    //显示区域
    UITextView *textView = [[UITextView alloc] init];
    
    [view addSubview:textView];
    textView.backgroundColor = [UIColor clearColor];
    textView.editable = NO;
    textView.attributedText = textString;
    
    GinSystemButton *button = [[GinSystemButton alloc] init];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    button.tag = 0x14;
    [view addSubview:button];
    
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(separatorLine.mas_bottom);
        make.left.equalTo(titleLabel);
        make.right.equalTo(titleLabel);
        make.bottom.equalTo(button.mas_top).offset(-5);
    }];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textView.mas_bottom).offset(5);
        make.bottom.equalTo(view.mas_bottom).offset(-5);
        make.centerX.equalTo(view);
        make.width.offset(buttonWidth);
        make.height.offset(40);
    }];
    return view;
}

@end
