//
//  loggerDemoViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/22.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "loggerDemoViewController.h"
#import <CocoaLumberjack/CocoaLumberjack.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"

#ifdef DEBUG
static const int ddLogLevel = DDLogLevelDebug;
#else
static const int ddLogLevel = DDLogLevelError;
#endif

#pragma clang diagnostic pop

@interface loggerDemoViewController ()

@end

@implementation loggerDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DDLogVerbose(@"Verbose");
    DDLogDebug(@"Debug");
    DDLogInfo(@"Info");
    DDLogWarn(@"Warn");
    DDLogError(@"我是一个很长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长长的Error");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
