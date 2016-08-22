//
//  BaseTableViewCell.h
//  shuangdaojia
//
//  Created by JunhuaShao on 15/5/24.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (strong, nonatomic) UIView *cellContentView;

- (void)setup;
+ (CGFloat)viewHeight;
@end
