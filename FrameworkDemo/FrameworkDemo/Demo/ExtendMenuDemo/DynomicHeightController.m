//
//  Demo4ExtendMenuViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/24.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "DynomicHeightController.h"
#import "UIViewController+GinBaseTableView.h"
#import "UIColor+Hex.h"
#import "DynomicHeightCell.h"
#import <Masonry.h>

@interface DynomicHeightController () <UITableViewDelegate, UITableViewDataSource>

@end

@implementation DynomicHeightController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    
    
//    UITableView *tab = [[UITableView alloc] init];
//    
//    [tab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.offset(0);
//    }];
//    
//    tab.delegate = self;
//    tab.dataSource = self;
//    tab.estimatedRowHeight = 100;
//    tab.rowHeight = UITableViewAutomaticDimension;
//    
//    [tab registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
//    [tab registerClass:[Demo4ExtendMenuCell class] forCellReuseIdentifier:NSStringFromClass([Demo4ExtendMenuCell class])];
//
//    
//    
//    [self.view addSubview:tab];
    
    
    [self.view addSubview:self.tableView];
    
    [self.tableView config:^(UITableView *tableView) {
        tableView.delegate = self;
        tableView.dataSource = self;
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.separatorColor = [UIColor colorWithHex:0xf1f1f1];
        
        tableView.estimatedRowHeight = 500;
        tableView.rowHeight = UITableViewAutomaticDimension;
        
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        [tableView registerClass:[DynomicHeightCell class] forCellReuseIdentifier:NSStringFromClass([DynomicHeightCell class])];
    }];
 
    [self setConstraints];
}

// 设置 view 的初次约束
- (void)setConstraints
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}


#pragma - Delegate & DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 1) {
//        return 44;
//    } else {
//
//        return 500;
//        Demo4ExtendMenuCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//        if (cell.extendMenu.extended) {
//            return  [Demo4ExtendMenuCell viewHeight] + cell.extendMenu.contentViewHeight;
//        } else {
//            return  [Demo4ExtendMenuCell viewHeight];
//        }
//    }
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    switch (indexPath.row) {
        case 0:
        {
            DynomicHeightCell *dcell= [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DynomicHeightCell class])];
            __block DynomicHeightCell *blockCell = dcell;
            
            [dcell setBtnClickBlock:^{
                [blockCell.contentView layoutIfNeeded];
                [tableView beginUpdates];
                [tableView endUpdates];
            }];
            
            cell = dcell;
        }
            break;
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
            cell.backgroundColor = [UIColor greenColor];
        }
            break;
            
            
        default:
            break;
    }
    
    return cell;
}






@end
