//
//  NSString+UnitSpec.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/7.
//  Copyright 2015年 JunhuaShao. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "NSString+GinUnit.h"


SPEC_BEGIN(NSString_UnitSpec)

describe(@"NSString+Unit", ^{

    context(@"test blank string", ^{
        
        NSString *str = @" ";
        
        it(@"shoule be blank", ^{
            [[theValue(isBlankString(str)) should] beYes];
        });
        
    });
    
});

SPEC_END
