//
//  TodayViewController.m
//  myWidget
//
//  Created by JunhuaShao on 2016/11/30.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import <Masonry.h>

@interface TodayViewController () <NCWidgetProviding>

@property (strong, nonatomic) UIButton *tapMe;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tapMe = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.tapMe.backgroundColor = [UIColor cyanColor];
    self.tapMe.layer.masksToBounds = YES;
    [self.tapMe setTitle:@"测试" forState:UIControlStateNormal];
    
    [self.tapMe addTarget:self action:@selector(tapMeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.tapMe];
    [self.tapMe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(100, 100));
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 10.0) {
        self.extensionContext.widgetLargestAvailableDisplayMode = NCWidgetDisplayModeCompact;
    }
    self.preferredContentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 300);
    
}


- (void)tapMeAction:(id)sender
{
    [self.extensionContext openURL:[NSURL URLWithString:@"frameworkdemo://I.Born"] completionHandler:^(BOOL success) {
        NSLog(@"success result --- > %d",success);
    }];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    // 更新过程中发生错误           If an error is encountered, use NCUpdateResultFailed
    // 部件不需要更新              If there's no update required, use NCUpdateResultNoData
    // 新的内容需要重新绘制视图      If there's an update, use NCUpdateResultNewData
    
    completionHandler(NCUpdateResultNoData);
}

- (void)widgetActiveDisplayModeDidChange:(NCWidgetDisplayMode)activeDisplayMode withMaximumSize:(CGSize)maxSize
{
    if (activeDisplayMode == NCWidgetDisplayModeCompact) {
        
        NSLog(@"maxSize-%@",NSStringFromCGSize(maxSize));// maxSize-{359, 110}
    }else{
        NSLog(@"maxSize-%@",NSStringFromCGSize(maxSize));// maxSize-{359, 616}
    }
}
//- (UIEdgeInsets)widgetMarginInsetsForProposedMarginInsets:(UIEdgeInsets)defaultMarginInsets
//{
//    return UIEdgeInsetsMake(0, 10, 0, 10);
//}


@end
