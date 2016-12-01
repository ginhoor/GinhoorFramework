//
//  ExtendMenuTableController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/24.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import <Masonry.h>

#import "ExtendMenuTableController.h"
#import "UIViewController+GinBaseTableView.h"
#import "ExtendMenuTableCell.h"

@interface ExtendMenuTableController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *expendStatusList;

@end

@implementation ExtendMenuTableController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView config:^(UITableView *tableView) {
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor blueColor];
        tableView.separatorColor = [UIColor whiteColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        
        [tableView registerClass:[ExtendMenuTableCell class] forCellReuseIdentifier:NSStringFromClass([ExtendMenuTableCell class])];
    }];
    
    [self.view addSubview:self.tableView];
    [self setConstraints];
    
    
    //数据初始状态后
    self.expendStatusList = [NSMutableArray arrayWithArray:@[@NO,@NO,@NO,@NO]];
    
}

// 设置 view 的初次约束
- (void)setConstraints
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ExtendMenuTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ExtendMenuTableCell class])];
    
    [cell setButtonClickBlock:^{
    
        NSNumber *isExpended = self.expendStatusList[indexPath.row];
        
        self.expendStatusList[indexPath.row] = @(!isExpended.boolValue);
        
        [tableView beginUpdates];
        [tableView endUpdates];
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSNumber *isExpended = self.expendStatusList[indexPath.row];
    
    if (isExpended.boolValue) {
        return 100;
    } else {
        return 50;
    }
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.expendStatusList.count;
}

@end
