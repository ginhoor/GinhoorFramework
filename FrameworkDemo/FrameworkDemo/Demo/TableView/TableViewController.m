//
//  TableViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/22.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "TableViewController.h"
#import <MJRefresh.h>
#import <Masonry.h>

@interface TableViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) UITableView *table;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.table.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.table];

    __weak typeof(self) weak = self;
    
    self.table.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weak.table.header endRefreshing];
        });
    }];
    
    self.table.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weak.table.footer endRefreshing];
        });
    }];

    [self.view setNeedsUpdateConstraints];
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
        _table.tableFooterView = [[UIView alloc] init];
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _table;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = @"测试";
    return cell;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
