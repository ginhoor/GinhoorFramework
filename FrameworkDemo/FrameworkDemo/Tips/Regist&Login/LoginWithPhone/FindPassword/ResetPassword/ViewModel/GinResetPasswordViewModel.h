//
//  GinResetPasswordViewModel.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/8.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>


@interface GinResetPasswordViewModel : NSObject

@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *checkPassword;

@property (strong, nonatomic) RACCommand *resetPasswordCommond;

- (RACSignal *)isValidPassword;

@end
