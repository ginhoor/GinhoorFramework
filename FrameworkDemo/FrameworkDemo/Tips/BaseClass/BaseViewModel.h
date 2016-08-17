//
//  BaseViewModel.h
//  LOLBox2
//
//  Created by JunhuaShao on 15/9/17.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

//protocol这么写，把原本要重载的函数都定义在这个protocol里面，就不用在父类里面写空方法了：
@protocol APIManager <NSObject>

@required
- (NSString *)apiMethodName;

@end

@interface BaseViewModel : NSObject

@end
