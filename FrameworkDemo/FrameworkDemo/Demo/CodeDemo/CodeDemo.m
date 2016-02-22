//
//  CodeDemo.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/8/28.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <BlocksKit+UIKit.h>
#import "Masonry.h"
#import "Gin_Macro.h"
#import "CodeDemo.h"
#import "NSString+RegEx.h"
#import "UIAlertView+GinUnit.h"
#import "NSString+Debug.h"

@interface CodeDemo()

@property (strong, nonatomic) UIScrollView *scroll;
@property (strong, nonatomic) NSMutableArray *buttonArr;
@end

@implementation CodeDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.buttonArr = [NSMutableArray array];
    
    self.scroll = [[UIScrollView alloc] init];
    self.scroll.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.scroll];
    
    [self.scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [self addButton:@"测试正则" index:0 tap:^{
        [UIAlertView alertView:@"提示" message:[NSString stringWithFormat:@"校验：%d",[@"12345678901" validateMobile]] cancelTitle:@"确认" cancelBlock:^{
            ;
        }];
    }];
    
    [self addButton:@"测试正则1" index:1 tap:^{
    }];
    [self addButton:@"测试正则2" index:2 tap:^{
    }];

    [self addButton:@"测试正则3" index:3 tap:^{
    }];

    [self addButton:@"测试正则4" index:4 tap:^{
    }];

    [self addButton:@"测试正则5" index:5 tap:^{
    }];

}

- (void)addButton:(NSString *)title index:(NSUInteger)index tap:(void(^)())block
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:title forState:UIControlStateNormal];

    [self.scroll addSubview:button];
    
    UIButton *lastButton = self.buttonArr.lastObject;
    
    
    if (index == 5) {
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.offset(0);
            make.top.equalTo(lastButton.mas_bottom).offset(250);
            make.width.offset(120);
            make.bottom.offset(0);
        }];
    } else {
        if (lastButton) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.offset(0);
                
                make.top.equalTo(lastButton.mas_bottom).offset(250);
                
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
