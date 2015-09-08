//
//  GinLoginViewModel.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/7.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface GinLoginViewModel : NSObject


@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *password;

@property (nonatomic, strong) RACCommand *loginCommand;

- (RACSignal *)isValidUsernameAndPasswordSignal;

@end
