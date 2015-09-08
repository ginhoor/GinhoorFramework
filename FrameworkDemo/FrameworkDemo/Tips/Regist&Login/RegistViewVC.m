//
//  CodeDemo.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/8/28.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <BlocksKit+UIKit.h>
#import <Masonry.h>
#import "Gin_Macro.h"
#import "RegistViewVC.h"

#import "GinLoginViewController.h"
#import "GinQuickLoginViewController.h"
#import "GinResetPasswordViewController.h"
#import "GinFindPasswordViewController.h"

@interface RegistViewVC()

@property (strong, nonatomic) UIScrollView *scroll;
@property (strong, nonatomic) NSMutableArray *buttonArr;


@end

@implementation RegistViewVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.buttonArr = [NSMutableArray array];
    
    self.scroll = [[UIScrollView alloc] init];
    [self.view addSubview:self.scroll];
    
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [self addButton:@"登录" index:0 tap:^{
        [self.navigationController pushViewController:[[GinLoginViewController alloc] init] animated:YES];
    }];
    
    [self addButton:@"快速登录" index:1 tap:^{
        [self.navigationController pushViewController:[[GinQuickLoginViewController alloc] init] animated:YES];
    }];
    
    [self addButton:@"找回密码" index:2 tap:^{
        
        GinFindPasswordViewController *vc = [[GinFindPasswordViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];

    }];
    
}

- (void)addButton:(NSString *)title index:(NSUInteger)index tap:(void(^)())block
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];
    
    [self.scroll addSubview:button];
    
    UIButton *lastButton = self.buttonArr.lastObject;
    
    
    if (index == 2) {
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(lastButton.mas_bottom).offset(100);
            make.width.offset(120);
            make.bottom.offset(0);
        }];
    } else {
        if (lastButton) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.offset(0);
                
                make.top.equalTo(lastButton.mas_bottom).offset(100);
                
                make.width.offset(120);
            }];
        } else {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.offset(0);
                make.top.offset(64);
                make.width.offset(120);
            }];
        }
    }
    
    [button bk_whenTapped:block];
    
    [self.buttonArr addObject:button];
}


@end
