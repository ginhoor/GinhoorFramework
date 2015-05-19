//
//  GinPullDownMenuItem.h
//  hme.ios.cn
//
//  Created by JunhuaShao on 15/3/20.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

@interface GinPullDownMenuItem : UIView

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIColor *indicatorColor;

@property (strong, nonatomic) UIColor *titleTextColor;
@property (strong, nonatomic) UIColor *titleSelectedTextColor;

@property (copy, nonatomic) void(^tapBlock)(GinPullDownMenuItem *item);

- (void)animateIndicator:(BOOL)selected completedBlock:(void(^)())completedBlock;
- (void)animateTitleLabel:(BOOL)selected;


@end
