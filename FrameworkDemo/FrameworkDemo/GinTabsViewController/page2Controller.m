//
//  page1Controller.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/25.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "page2Controller.h"

@implementation page2Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *label = [[UILabel alloc] init];
    [self.view addSubview:label];
    
    label.text = @"2222";
    label.backgroundColor = [UIColor redColor];
    label.frame = CGRectMake(100, 100, 100, 100);
}

@end
