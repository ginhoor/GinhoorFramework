//
//  GinWebViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/4.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GinWebViewController.h"

@interface GinWebViewController() <UIWebViewDelegate>

@end

@implementation GinWebViewController

- (void)dealloc
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    [self.view addSubview:self.webView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.webView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
    }
    return _webView;
}


@end
