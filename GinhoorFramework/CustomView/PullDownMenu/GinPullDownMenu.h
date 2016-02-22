//
//  GinPullDownMenu.h
//  hme.ios.cn
//
//  Created by JunhuaShao on 15/3/19.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface GinPullDownMenu : UIView

/**
 *  必须使用NSAttributeString
 */
@property (strong, nonatomic) NSArray *categoryTitles;
/**
 *  必须使用NSAttributeString
 */
@property (strong, nonatomic) NSMutableArray *menuCellDataList;
/**
 *  会影响menu item selected 动画字体
 */
@property (strong, nonatomic) UIFont *menuItemTitleFont;
@property (assign, nonatomic) BOOL  animateMenuItemSelected;


@property (strong, nonatomic) UIColor *selectedColor;
@property (strong, nonatomic) UIColor *itemSeparatorColor;

/**
 * categorySeletedIndex 返回的是一个二维数组 [第几个选项][选择的index]
 */
@property (copy, nonatomic) void(^categorySelectedIndexBlock)(NSArray *categorySeletedIndex);


@end
