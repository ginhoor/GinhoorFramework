//
//  People.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/6.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//


#import "BaseData.h"

@interface People : BaseData <MTLJSONSerializing>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSURL *avatar;

@end
