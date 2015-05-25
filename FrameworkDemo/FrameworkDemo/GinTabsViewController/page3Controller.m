//
//  page1Controller.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/25.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "page3Controller.h"

@implementation page3Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    
    label.text = @"3333";
    label.backgroundColor = [UIColor redColor];
    label.frame = CGRectMake(100, 100, 100, 100);
}

@end
