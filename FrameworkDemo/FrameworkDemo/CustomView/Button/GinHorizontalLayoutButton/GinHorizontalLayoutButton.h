//
//  GinHorizontalLayoutButton.h
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/6/26.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GinHorizontalAlignmentType) {
    GinHorizontalAlignmentTypeLeft,
    GinHorizontalAlignmentTypeRight

};


@interface GinHorizontalLayoutButton : UIButton

@property (assign, nonatomic) GinHorizontalAlignmentType type;

@end
