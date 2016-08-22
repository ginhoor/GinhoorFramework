//
//  GinTableIndex.h
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/6/26.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GinTableIndex;
@protocol GinTableIndexDelegate <NSObject>

/**
 *  触摸到索引时触发
 *
 *  @param tableViewIndex 触发didSelectSectionAtIndex对象
 *  @param index          索引下标
 *  @param title          索引文字
 */
- (void)tableViewIndex:(GinTableIndex *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title;

/**
 *  开始触摸索引
 *
 *  @param tableViewIndex 触发tableViewIndexTouchesBegan对象
 */
- (void)tableViewIndexTouchesBegan:(GinTableIndex *)tableViewIndex;
/**
 *  触摸索引结束
 *
 *  @param tableViewIndex
 */
- (void)tableViewIndexTouchesEnd:(GinTableIndex *)tableViewIndex;

/**
 *  TableView中右边右边索引title
 *
 *  @param tableViewIndex 触发tableViewIndexTitle对象
 *
 *  @return 索引title数组
 */
- (NSArray *)tableViewIndexTitle:(GinTableIndex *)tableViewIndex;

@end

@interface GinTableIndex : UIView

@property (strong, nonatomic) NSArray *indexes;
@property (nonatomic, weak) id <GinTableIndexDelegate> tableIndexDelegate;
//
///**
// *  触摸到索引时触发
// *
// *  @param tableViewIndex 触发didSelectSectionAtIndex对象
// *  @param index          索引下标
// *  @param title          索引文字
// */
//@property (copy, nonatomic) void (^tableViewIndexDidSelectBlock)(GinTableIndex *tableViewIndex,NSInteger index, NSString *title);
///**
// *  开始触摸索引
// *
// *  @param tableViewIndex 触发tableViewIndexTouchesBegan对象
// */
//@property (copy, nonatomic) void (^tableViewIndexTouchesBeganBlock)(GinTableIndex *tableViewIndex);
///**
// *  触摸索引结束
// *
// *  @param tableViewIndex
// */
//@property (copy, nonatomic) void (^tableViewIndexTouchesEndBlock)(GinTableIndex *tableViewIndex);
///**
// *  TableView中右边右边索引title
// *
// *  @param tableViewIndex 触发tableViewIndexTitle对象
// *
// *  @return 索引title数组
// */
//@property (copy, nonatomic) NSArray* (^tableViewIndexTitleBlock)(GinTableIndex *tableViewIndex);

@end
