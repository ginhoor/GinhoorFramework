//
//  ThemeDemoViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/19.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import <Masonry.h>
#import <Aspects.h>
#import "ThemeManager.h"
#import "ThemeDemoViewController.h"
@interface ThemeDemoViewController ()

@property (strong, nonatomic) UIButton *deleteButton;
@property (strong, nonatomic) UIButton *queryButton;
@property (strong, nonatomic) UIButton *updateButton;
@property (strong, nonatomic) UIButton *insertButton;

@property (strong, nonatomic) UIButton *switchButton;

@end

@implementation ThemeDemoViewController


- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:self.deleteButton];
    [self.view addSubview:self.switchButton];
    [self.view addSubview:self.insertButton];
    [self.view addSubview:self.updateButton];
    [self.view addSubview:self.queryButton];
    
    [self setConstraints];
}

// 设置 view 的初次约束
- (void)setConstraints
{
    [self.insertButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(40);
        make.size.sizeOffset(CGSizeMake(200, 40));
    }];
    
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.insertButton.mas_bottom).offset(100);
        make.left.equalTo(self.insertButton);
        make.size.equalTo(self.insertButton);
    }];
    
    [self.updateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.deleteButton.mas_bottom).offset(100);
        make.left.equalTo(self.insertButton);
        make.size.equalTo(self.insertButton);
    }];
    
    [self.queryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.updateButton.mas_bottom).offset(100);
        make.left.equalTo(self.insertButton);
        make.size.equalTo(self.insertButton);
    }];
    
    [self.switchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.queryButton.mas_bottom).offset(100);
        make.left.equalTo(self.insertButton);
        make.size.equalTo(self.insertButton);
    }];
}


- (UIButton *)deleteButton
{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.lee_theme.LeeConfigBackgroundColor(kDefaultButtonBackgroundColor);
        _deleteButton.lee_theme.LeeConfigButtonTitleColor(kDefaultButtonTitleColor,UIControlStateNormal);
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    }
    return _deleteButton;
}

- (UIButton *)queryButton
{
    if (!_queryButton) {
        _queryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _queryButton.lee_theme.LeeConfigBackgroundColor(kDefaultButtonBackgroundColor);
        _queryButton.lee_theme.LeeConfigButtonTitleColor(kDefaultButtonTitleColor,UIControlStateNormal);
        [_queryButton setTitle:@"查找" forState:UIControlStateNormal];
        
        _queryButton.lee_theme.LeeCustomConfig(kDefaultAlpha,^(UIButton *button, id value){
            button.alpha = [value floatValue];
        });
    }
    return _queryButton;
}

- (UIButton *)updateButton
{
    if (!_updateButton) {
        _updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _updateButton.lee_theme.LeeConfigBackgroundColor(kDefaultButtonBackgroundColor);
        _updateButton.lee_theme.LeeConfigButtonTitleColor(kDefaultButtonTitleColor,UIControlStateNormal);
        [_updateButton setTitle:@"更新" forState:UIControlStateNormal];
        
        _updateButton.lee_theme.LeeConfigButtonBackgroundImage(kDefaultImage2,UIControlStateNormal);
    }
    return _updateButton;
}

- (UIButton *)insertButton
{
    if (!_insertButton) {
        _insertButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _insertButton.lee_theme.LeeConfigBackgroundColor(kDefaultButtonBackgroundColor);
        _insertButton.lee_theme.LeeConfigButtonTitleColor(kDefaultButtonTitleColor,UIControlStateNormal);
        [_insertButton setTitle:@"插入" forState:UIControlStateNormal];
        
        _insertButton.lee_theme.LeeConfigButtonImage(kDefaultImage1,UIControlStateNormal);
    }
    return _insertButton;
}

- (UIButton *)switchButton
{
    if (!_switchButton) {
        _switchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _switchButton.lee_theme.LeeConfigBackgroundColor(kDefaultButtonBackgroundColor);
        _switchButton.lee_theme.LeeConfigButtonTitleColor(kDefaultButtonTitleColor,UIControlStateNormal);
        
        _switchButton.layer.masksToBounds = YES;
        _switchButton.layer.cornerRadius = 4;
        
        [_switchButton setTitle:@"切换主题" forState:UIControlStateNormal];
        [_switchButton addTarget:self action:@selector(switchTheme:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchButton;
}

- (void)switchTheme:(id)sender
{
    if ([[LEETheme currentThemeTag] isEqualToString:kDefaultTheme]) {
        [LEETheme startTheme:kNightTheme];
    } else {
        [LEETheme startTheme:kDefaultTheme];
    }
}




@end
