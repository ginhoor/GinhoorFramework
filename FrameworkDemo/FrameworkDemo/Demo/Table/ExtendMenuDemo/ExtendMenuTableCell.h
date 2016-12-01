//
//  ExtendMenuCell.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/24.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface ExtendMenuTableCell : BaseTableViewCell<GinBaseTableCell>

@property (nonatomic, copy) void(^buttonClickBlock)();

@end
