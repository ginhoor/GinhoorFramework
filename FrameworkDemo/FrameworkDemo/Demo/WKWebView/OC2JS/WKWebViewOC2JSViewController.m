//
//  WKWebViewOC2JSViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 2016/11/29.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import <WebKit/WebKit.h>
#import <Masonry.h>
#import "WKWebViewOC2JSViewController.h"
#import "WKDelegateManager.h"

@interface WKWebViewOC2JSViewController () <WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler>

@property (strong, nonatomic) WKWebView *webView;
@property (strong, nonatomic) WKUserContentController *userContentController;
@property (strong, nonatomic) WKDelegateManager *webViewDelegateManager;

@end

@implementation WKWebViewOC2JSViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.userContentController = [[WKUserContentController alloc] init];
    [self.userContentController addScriptMessageHandler:self.webViewDelegateManager name:@"myselfBlock"];
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = self.userContentController;
    
    // webview
    self.webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //webview delegate manager
    self.webViewDelegateManager = [[WKDelegateManager alloc] init];
    self.webViewDelegateManager.delegate = self;
    
    
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.test.com"]]];
}

- (void)dealloc
{
    [self.userContentController removeScriptMessageHandlerForName:@"myselfBlock"];
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    NSLog(@"name:%@\\\\n body:%@\\\\n frameInfo:%@\\\\n",message.name,message.body,message.frameInfo);
}


/**
 h5代码:
 
 function say()
 {
 //前端需要用 window.webkit.messageHandlers.注册的方法名.postMessage({body:传输的数据} 来给native发送消息
 window.webkit.messageHandlers.myselfBlock.postMessage({body: 'hello world!'});
 }            hello world        say hello
 
 
 打印出的log：
 name:sayhello
 body:{
 body = "hello world!";
 }
 frameInfo:<wkframeinfo: 0x7f872060ce20; ismainframe = yes; request =      { url: http: www.test.com=""  }=""></wkframeinfo: 0x7f872060ce20; ismainframe = yes; request =      { url: http:>

 
 */


/**
 oc调用JS方法

 @return <#return value description#>
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    //say()是JS方法名，completionHandler是异步回调block
    [webView evaluateJavaScript:@"say()" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@",result);
    }];
}


@end
