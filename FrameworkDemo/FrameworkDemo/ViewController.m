//
//  ViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/13.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//
#import <Masonry.h>

#import "ViewController.h"
#import "UIViewController+GinBaseTableView.h"

#import "Gin3DTouchAction.h"
#import "GinPopup+Unit.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView config:^(UITableView *tableView) {
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [self setType1];
    
    [self.tableView reloadData];
    
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
    
    [self type1:indexPath];
    
}

#pragma mark- type2

- (void)setType2
{
    self.cellDataList = @[@"3D Touch"];
}

- (void)type2:(NSIndexPath *)indexPath
{

    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[Gin3DTouchAction Gin3DTouchViewController]  animated:YES];
            break;
            
        default:
            break;
        
    }
}


#pragma mark- type1

- (void)setType1
{
    self.cellDataList = @[@"弹窗",@"3Dtouch"];
}

- (void)type1:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [GinPopup showTitle:@"标题" text:@"内容" submitButton:@"确定" onClick:^{
                [GinPopup dismissWhenCompletion:nil];
            }];
            break;
        case 1:
            [self.navigationController pushViewController:[Gin3DTouchAction Gin3DTouchViewController]  animated:YES];
            break;
            
        default:
            break;
    }

}


@end
