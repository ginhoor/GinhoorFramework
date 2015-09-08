//
//  GinLoginViewModelSpec.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/7.
//  Copyright 2015年 JunhuaShao. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "GinLoginViewModel.h"



SPEC_BEGIN(GinLoginViewModelSpec)

describe(@"GinLoginViewModel", ^{
    
    __block GinLoginViewModel *loginVM = [[GinLoginViewModel alloc] init];
    
    context(@"when username is 123456 and password is 123456", ^{
        __block BOOL result = NO;
        
        it(@"should return signal that value is NO", ^{
            loginVM.username = @"123456";
            loginVM.password = @"123456";
            
            [[loginVM isValidUsernameAndPasswordSignal] subscribeNext:^(NSNumber *isValid) {
                result = [isValid boolValue];
            }];
            
            [[theValue(result) should] beNo];
        });
    });
    
    context(@"when username is 15558066089 and password is 123456", ^{
        __block BOOL result = NO;
        
        it(@"should return signal that value is YES", ^{
            loginVM.username = @"15558066089";
            loginVM.password = @"123456";
            
            [[loginVM isValidUsernameAndPasswordSignal] subscribeNext:^(NSNumber *isValid) {
                result = [isValid boolValue];
            }];
            
            [[theValue(result) should] beYes];
        });
    });
    
});

SPEC_END


/******
 
    beforeAll(aBlock) - 当前scope内部的所有的其他block运行之前调用一次
    afterAll(aBlock) - 当前scope内部的所有的其他block运行之后调用一次
    beforeEach(aBlock) - 在scope内的每个it之前调用一次，对于context的配置代码应该写在这里
    afterEach(aBlock) - 在scope内的每个it之后调用一次，用于清理测试后的代码
    specify(aBlock) - 可以在里面直接书写不需要描述的测试
    pending(aString, aBlock) - 只打印一条log信息，不做测试。这个语句会给出一条警告，可以作为一开始集中书写行为描述时还未实现的测试的提示。
    xit(aString, aBlock) - 和pending一样，另一种写法。因为在真正实现时测试时只需要将x删掉就是it，但是pending语意更明确，因此还是推荐pending
 

 Expectations
    https://github.com/allending/Kiwi/wiki/Expectations
    
    id car = [Car car];
    [[car shouldNot] beNil];
    [[car should] beKindOfClass:[Car class]];
    [[car shouldNot] conformToProtocol:@protocol(FlyingMachine)];
    [[[car should] have:4] wheels];
    [[theValue(car.speed) should] equal:theValue(42.0f)];
    [[[car should] receive] changeToGear:3];

 Wrapping Scalars
    [[theValue(1 + 1) should] equal:theValue(2)];
    [[theValue(YES) shouldNot] equal:theValue(NO)];
    [[theValue(20u) should] beBetween:theValue(1) and:theValue(30.0)];
    [[theValue(animal.mass) should] beGreaterThan:theValue(42.0f)]

 Expectations: Substring Matching
    [[@"Hello, world!" should] containString:@"world"];
    [[@"Hello, world!" should] containString:@"WORLD" options:NSCaseInsensitiveSearch];
    [[@"Hello, world!" should] startWithString:@"Hello,"];
    [[@"Hello, world!" should] endWithString:@"world!"];

 Expectations: Regular-Expression Pattern Matching
    [[@"ababab" should] matchPattern:@"(ab)+"];
    [[@" foo " shouldNot] matchPattern:@"^foo$"];
    [[@"abABab" should] matchPattern:@"(ab)+" options:NSRegularExpressionCaseInsensitive];
 
 Expectations: Count changes
    
    [[theBlock(^{
        [array addObject:@"foo"];
    }) should] change:^{ return (NSInteger)[array count]; } by:+1];

    [[theBlock(^{
        [array addObject:@"bar"];
        [array removeObject:@"foo"];
    }) shouldNot] change:^{ return (NSInteger)[array count]; }];

    [[theBlock(^{
        [array removeObject:@"bar"];
    }) should] change:^{ return (NSInteger)[array count]; } by:-1];

 Expectations: Collections
    NSArray *array = [NSArray arrayWithObject:@"foo"];
    [[array should] have:1] item];

    Car *car = [Car car];
    [car setPassengers:[NSArray arrayWithObjects:@"Eric", "Stan", nil]];
    [[[[car passengers] should] haveAtLeast:2] items];
    [[[car should] haveAtLeast:2] passengers];

 Expectations: Interactions and Messages
    subject = [Cruiser cruiser];
    [[subject should] receive:@selector(energyLevelInWarpCore:)
    andReturn:theValue(42.0f) withCount:2 arguments:theValue(7)];
    [subject energyLevelInWarpCore:7];
    float energyLevel = [subject energyLevelInWarpCore:7];
    [[theValue(energyLevel) should] equal:theValue(42.0f)];
 
    id cruiser = [Cruiser cruiser];
    [[[cruiser should] receiveAndReturn:theValue(42.0f) withCount:2] energyLevelInWarpCore:7];
    [cruiser energyLevelInWarpCore:7];
    float energyLevel = [cruiser energyLevelInWarpCore:7];
    [[theValue(energyLevel) should] equal:theValue(42.0f)];
 
 
 Expectations: Notifications
    [[@"MyNotification" should] bePosted];

    NSNotification *myNotification = [NSNotification notificationWithName:@"MyNotification"
    object:nil];
    [[NSNotificationCenter defaultCenter] postNotification:myNotification];
 
 Expectations: Async Calls
    [[subject shouldEventually] receive:(SEL)aSelector]
    [[subject shouldEventually] receive:(SEL)aSelector withArguments:(id)firstArgument, ...]
 
 Expectations: Exceptions
     [[theBlock(^{
        [NSException raise:@"FooException" reason:@"Bar-ed"];
     }) should] raiseWithName:@"FooException" reason:@"Bar-ed"];
 
******/
