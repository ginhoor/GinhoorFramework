//
//  UITableView+BaseClass.h
//  hmeIosCn
//
//  Created by JunhuaShao on 15/4/15.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface UITableView (BaseClass)

+ (instancetype)defaultTableView;
- (void)config:(void (^)(UITableView *tableView))configTableViewBlock;

@end
