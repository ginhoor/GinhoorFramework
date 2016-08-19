//
//  LifeCycleViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/19.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "LifeCycleViewController.h"

@interface LifeCycleViewController ()

@end

@implementation LifeCycleViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

//Called when the view controller's view needs to update its constraints.
//当 self.view 需要更新约束的时候
- (void)updateViewConstraints
{
    [super updateViewConstraints];
}

// Called just after the view controller's view's layoutSubviews method is invoked. Subclasses can implement as necessary. The default is a nop.
// 当 self.view layoutSubviews调用后
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
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
