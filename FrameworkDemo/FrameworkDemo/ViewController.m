//
//  ViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/13.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>
#import "TableViewController.h"
@interface ViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *table;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.table];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UITableView *)table
{
    if (!_table) {
        _table = [[UITableView alloc] init];
        _table.delegate = self;
        _table.dataSource = self;
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _table;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"事实上";
    
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = @"Base Table Example";
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            TableViewController *exm = [[TableViewController alloc] init];
            [self.navigationController pushViewController:exm animated:YES];

        }
            break;
            
        default:
            break;
    }
    
}



@end
