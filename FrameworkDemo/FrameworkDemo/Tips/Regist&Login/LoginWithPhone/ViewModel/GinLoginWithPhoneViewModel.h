//
//  GinLoginWithPhoneViewModel.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/8.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface GinLoginWithPhoneViewModel : NSObject

@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *randomCode;
@property (assign, nonatomic) NSInteger verifiedCoolDown;

@property (nonatomic, strong) RACCommand *loginCommand;
@property (nonatomic, strong) RACCommand *findPasswordCommand;
@property (nonatomic, strong) RACCommand *getRandomCodeCommand;

- (RACSignal *)isVerifiedCoodDown;
- (RACSignal *)isValidUsernameAndRandomCodeSignal;


@end
