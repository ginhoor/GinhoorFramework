//
//  GinIndexTableView.h
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/6/26.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GinIndexTableView;
@protocol GinIndexTableViewDelegate <UITableViewDataSource,UITableViewDelegate>

- (NSArray *)sectionIndexTitlesForGinIndexTableView:(GinIndexTableView *)tableView;
@end


@interface GinIndexTableView : UIView

@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic) id<GinIndexTableViewDelegate> delegate;
- (void)reloadData;

@end
