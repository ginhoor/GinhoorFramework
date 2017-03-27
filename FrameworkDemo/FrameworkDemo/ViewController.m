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

#import "AppRouter+ContactsBook.h"
#import "AppRouter+TabsViewController.h"
#import "AppRouter+DemoCode.h"
#import "AppRouter+PullDownMenu.h"
#import "AppRouter+EmptyTableView.h"
#import "AppRouter+PhotoGallery.h"
#import "AppRouter+TableViewController.h"
#import "AppRouter+StepperView.h"
#import "AppRouter+HZTableVC.h"
#import "AppRouter+GinSystemButton.h"
#import "AppRouter+Login.h"
#import "AppRouter+Networking.h"
#import "AppRouter+ThemeDemo.h"
#import "AppRouter+LoggerDemo.h"
#import "AppRouter+Demo4ExtendMenu.h"
#import "AppRouter+WKWebView.h"

#import "Gin3DTouchAction.h"


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
    self.cellDataList = @[@"自定义按钮",@"水平的TableView",
                          @"带Tabs的PageContrller",@"相册浏览",
                          @"下拉菜单",@"列表空数据页面",
                          @"步进器",@"自定义 上&下拉刷新",
                          @"代码测试",@"自定义登录界面",
                          @"联系人导入",@"AFNetworkingDemo",
                          @"控件样式统一设置",@"Logger输出",
                          @"动态列表高度",@"扩展列表页面",
                          @"WKWebView",@"3D Touch"];
}

- (void)type1:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
            [self.navigationController pushViewController:[[AppRouter sharedInstance] systemButtonViewController] animated:YES];
            break;
            
        case 1:
            [self.navigationController pushViewController:[[AppRouter sharedInstance] HZTableViewController] animated:YES];
            break;
            
        case 2:
            [self.navigationController pushViewController:[[AppRouter sharedInstance] tabsViewController] animated:YES];
            break;
            
        case 3:
            [self.navigationController pushViewController:[[AppRouter sharedInstance] demo4GalleryController] animated:YES];
            break;
            
        case 4:
            [self.navigationController pushViewController:[[AppRouter sharedInstance] pullDownMenuController] animated:YES];
            break;
            
        case 5:
            [self.navigationController pushViewController:[[AppRouter sharedInstance] emptyTableViewController] animated:YES];
            break;
            
        case 6:
            [self.navigationController pushViewController:[[AppRouter sharedInstance] stepperViewController] animated:YES];
            break;
            
        case 7:
            [self.navigationController pushViewController:[[AppRouter sharedInstance] tableViewController] animated:YES];
            break;
        case 8:
            [self.navigationController pushViewController:[[AppRouter sharedInstance] demoCodeController] animated:YES];
            break;
            
        case 9:
            [self.navigationController pushViewController:[[AppRouter sharedInstance] registViewController] animated:YES];
            break;
            
        case 10:
            [self.navigationController pushViewController:[[AppRouter sharedInstance] contactsBookController] animated:YES];
            break;
            
        case 11:
            [self.navigationController pushViewController:[[AppRouter sharedInstance] networkingController] animated:YES];
            break;
            
        case 12:
            [self.navigationController pushViewController:[[AppRouter sharedInstance] themeDemoController] animated:YES];
            break;
            
        case 13:
            [self.navigationController pushViewController:[[AppRouter sharedInstance] loggerDemoViewController] animated:YES];
            break;
        case 14:
            [self.navigationController pushViewController:[[AppRouter sharedInstance] DynomicTableController] animated:YES];
            break;
            
        case 15:
            [self.navigationController pushViewController:[[AppRouter sharedInstance] ExtendMenuController] animated:YES];
            break;
            
        case 16:
            [self.navigationController pushViewController:[[AppRouter sharedInstance] demo4WKWebViewController] animated:YES];
            break;
        case 17:
            [self.navigationController pushViewController:[Gin3DTouchAction Gin3DTouchViewController]  animated:YES];
            break;
            
        default:
            break;
    }

}


@end
