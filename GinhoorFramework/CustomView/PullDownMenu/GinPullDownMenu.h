//
//  GinPullDownMenu.h
//  hme.ios.cn
//
//  Created by JunhuaShao on 15/3/19.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

@interface GinPullDownMenu : UIView

@property (strong,nonatomic) NSArray *categoryTitles;
@property (strong,nonatomic) NSMutableArray *menuCellDataList;

@property (strong,nonatomic) UIColor *selectedColor;
@property (strong, nonatomic) UIColor *menuItemTextColor;
@property (strong, nonatomic) UIColor *itemSeparatorColor;

@property (copy, nonatomic) void(^categorySelectedIndexBlock)(NSArray *categorySeletedIndex);


@end
