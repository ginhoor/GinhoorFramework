//
//  CallPhoneMannager.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/7/20.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CallPhoneMannager.h"

@interface CallPhoneMannager()

// 为了拨号后能返回应用
@property (strong, nonatomic) UIWebView *phoneCallWebView;

@end

@implementation CallPhoneMannager

+ (instancetype)shareManager
{
    static CallPhoneMannager *share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[CallPhoneMannager alloc] init];
    });
    return share;
}

+ (void)callPhone:(NSString *)phoneNumber
{
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",phoneNumber]];
    [[CallPhoneMannager shareManager].phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}

- (UIWebView *)phoneCallWebView
{
    if ( !_phoneCallWebView ) {
        _phoneCallWebView = [[UIWebView alloc] init];
    }
    return _phoneCallWebView;
}

@end


