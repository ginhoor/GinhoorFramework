//
//  BaseCollectionCell.m
//  shuangdaojia_merchant
//
//  Created by JunhuaShao on 15/6/18.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "BaseCollectionCell.h"

@implementation BaseCollectionCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{

}

+ (CGFloat)viewHeight
{
    return 100;
}

@end
