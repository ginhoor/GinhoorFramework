//
//  UITableView+TableViewStyle.m
//  LOLBox
//
//  Created by JunhuaShao on 14/12/16.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "UITableView+DefualtStyle.h"

@implementation UITableView (DefualtStyle)

+ (instancetype)defaultTableView
{
    UITableView *tableView = [[UITableView alloc] init];    
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorColor = [UIColor colorWithRed:78/255.f green:52/255.f blue:91/255.f alpha:1.f];
    tableView.tableFooterView = [[UIView alloc]init];
    
    return tableView;
}


@end
