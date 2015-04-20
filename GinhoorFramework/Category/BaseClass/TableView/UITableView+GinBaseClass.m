//
//  UITableView+BaseClass.m
//  hmeIosCn
//
//  Created by JunhuaShao on 15/4/15.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import "UITableView+GinBaseClass.h"
@implementation UITableView (GinBaseClass)


+ (instancetype)defaultTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.backgroundColor = [UIColor whiteColor];
    tableView.separatorColor = [UIColor colorWithRed:78/255.f green:52/255.f blue:91/255.f alpha:1.f];
    tableView.tableFooterView = [[UIView alloc]init];
    
    return tableView;
}

- (void)config:(void (^)(UITableView *tableView))configTableViewBlock
{
    if (configTableViewBlock) {
        configTableViewBlock(self);
    }
}





@end
