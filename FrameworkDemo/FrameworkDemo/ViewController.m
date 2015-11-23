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
#import "HZTableViewController.h"
#import "TabsViewController.h"

#import "demo4Gallery.h"
#import "TableViewController.h"

#import "GalleryViewController.h"
#import "PullDownMenuViewController.h"

#import "EmptyTableViewController.h"
#import "StepperViewController.h"

#import "NSString+formatContentString.h"
#import "UIAlertView+GinUnit.h"
#import "CodeDemo.h"
#import "RegistViewVC.h"
#import "ContactsBookViewController.h"

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
    
    [self.tableView config:^(UITableView *tableView) {
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    }];
    
    self.cellDataList = @[@"自定义按钮",@"水平的TableView",@"带Tabs的PageContrller",@"相册浏览",@"下拉菜单",@"列表空数据页面",@"步进器",@"自定义 上&下拉刷新",@"代码测试",@"自定义登录界面",@"联系人导入"];
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
        case 1:
            [self.navigationController pushViewController:[HZTableViewController controller] animated:YES];
            break;
        case 2:
            [self.navigationController pushViewController:[[TabsViewController alloc]init] animated:YES];
            break;
        case 3:
            [self.navigationController pushViewController:[[demo4Gallery alloc]init] animated:YES];
            break;
        case 4:
            [self.navigationController pushViewController:[[PullDownMenuViewController alloc] init] animated:YES];
            break;
        case 5:
            [self.navigationController pushViewController:[[EmptyTableViewController alloc] init] animated:YES];
            break;
            
        case 6:
            [self.navigationController pushViewController:[[StepperViewController alloc] init] animated:YES];
            break;
            
        case 7:
            [self.navigationController pushViewController:[[TableViewController alloc] init] animated:YES];
            break;
        case 8:
            [self.navigationController pushViewController:[[CodeDemo alloc] init] animated:YES];
            break;
            
        case 9:
            [self.navigationController pushViewController:[[RegistViewVC alloc]init] animated:YES];
            break;
            
        case 10:
            [self.navigationController pushViewController:[ContactsBookViewController controller] animated:YES];
            break;
            
        default:
            break;
            

    }
    
}



@end
