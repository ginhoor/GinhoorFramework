//
//  Demo4WKWebViewViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 2016/11/28.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import <WebKit/WebKit.h>
#import <Masonry.h>

#import "Demo4WKWebViewController.h"

@interface Demo4WKWebViewController () <WKNavigationDelegate, WKUIDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation Demo4WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    __weak typeof(self) _WeakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_WeakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    });
    

}

- (WKWebView *)webView
{
    if(!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
    }
    
    return _webView;
}



#pragma - Delegate & DataSource

/**
 页面开始加载时
 
 @param webView <#webView description#>
 @param navigation <#navigation description#>
 */
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation
{
    NSLog(@"页面开始加载回调");
}

/**
 当内容开始返回时
 
 @param webView <#webView description#>
 @param navigation <#navigation description#>
 */
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation
{
    NSLog(@"内容开始返回回调");
}

/**
 页面加载完成

 @param webView <#webView description#>
 @param navigation <#navigation description#>
 */
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    NSLog(@"页面加载完成回调");
}

/**
 页面加载失败

 @param webView <#webView description#>
 @param navigation <#navigation description#>
 @param error <#error description#>
 */
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error
{
    NSLog(@"页面加载失败");
}


/**
 接收到服务器跳转请求后

 @param webView <#webView description#>
 @param navigation <#navigation description#>
 */
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation
{
    
}


/**
 在发送请求前，决定是否跳转

 @param webView <#webView description#>
 @param navigationAction <#navigationAction description#>
 @param decisionHandler <#decisionHandler description#>
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSLog(@"to->%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
//    decisionHandler(WKNavigationActionPolicyCancel);
    
}

/**
 在收到响应后，决定是否跳转
 
 @param webView <#webView description#>
 @param navigationResponse <#navigationResponse description#>
 @param decisionHandler <#decisionHandler description#>
 */
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler
{
    NSLog(@"from->%@",navigationResponse.response.URL.absoluteString);
    //允许
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许
//    decisionHandler(WKNavigationResponsePolicyCancel);
}

#pragma mark- UKUIDelegate


/**
 新建一个WebView

 @param webView <#webView description#>
 @param configuration <#configuration description#>
 @param navigationAction <#navigationAction description#>
 @param windowFeatures <#windowFeatures description#>
 @return <#return value description#>
 */
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures
{
    return [[WKWebView alloc] init];
}

/**
 输入框

 @param webView <#webView description#>
 @param prompt <#prompt description#>
 @param defaultText <#defaultText description#>
 @param frame <#frame description#>
 @param completionHandler <#completionHandler description#>
 */
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler
{
    completionHandler(@"输入结果");
}


/**
 确认框

 @param webView <#webView description#>
 @param message <#message description#>
 @param frame <#frame description#>
 @param completionHandler <#completionHandler description#>
 */
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler
{
    completionHandler(YES);
}


/**
 警告框

 @param webView <#webView description#>
 @param message <#message description#>
 @param frame <#frame description#>
 @param completionHandler <#completionHandler description#>
 */
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    NSLog(@"message-->%@",message);
    completionHandler();
}



@end
