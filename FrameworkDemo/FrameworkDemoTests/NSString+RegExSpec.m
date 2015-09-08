//
//  NSString+RegExSpec.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/7.
//  Copyright 2015年 JunhuaShao. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NSString+RegEx.h"


SPEC_BEGIN(NSString_RegExSpec)

describe(@"NSString+RegEx", ^{

    __block NSString *userName = @"15558066089";

    context(@"test a mobile number", ^{
        
        it(@"should return Yes", ^{
            [[theValue([userName validateMobile]) should] beYes];
        });

    });
    
});

SPEC_END
