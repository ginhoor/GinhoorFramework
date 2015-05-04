//
//  ViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/13.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+GinBaseTableView.h"
#import "GinSystemButtonViewController.h"
@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView config:^(UITableView *tableView) {
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    }];
    
    self.cellDataList = @[@"自定义按钮"];
    [self.tableView reloadData];
    
    [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.cellDataList[indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[GinSystemButtonViewController controller] animated:YES];
            break;
            
        default:
            break;
    }
    
}



@end
