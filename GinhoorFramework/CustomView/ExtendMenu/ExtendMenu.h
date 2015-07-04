//
//  TechnicianExtandMenu.h
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/5/22.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <HZCollectionViewLayout.h>
#import "GinExtendMenu.h"

@interface ExtendMenuCell:UICollectionViewCell
@property (strong, nonatomic) UIImageView *icon;
@end

@interface ExtendMenu : NSObject

@property (strong, nonatomic) GinExtendMenu *extendMenu;
@property (strong, nonatomic) UICollectionView *collection;

@end
