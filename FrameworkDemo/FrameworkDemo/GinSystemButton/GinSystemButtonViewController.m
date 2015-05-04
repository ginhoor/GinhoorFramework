//
//  GinSystemButtonViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/4.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GinSystemButtonViewController.h"
#import "GinSystemButton.h"

@interface GinSystemButtonViewController ()
@property (strong, nonatomic) GinSystemButton *button;
@end

@implementation GinSystemButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.button];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.button.frame = CGRectMake(100, 100, 100, 100);
}

- (GinSystemButton *)button
{
    if (!_button) {
        _button = [[GinSystemButton alloc] init];
        [_button setTitle:@"测试按钮" forState:UIControlStateNormal];
    }
    return _button;
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
