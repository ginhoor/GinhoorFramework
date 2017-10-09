//
//  ModelTest.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/9/6.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "Person.h"
//#import "NSString+Json.h"


@interface ModelTest : XCTestCase

@end

@implementation ModelTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testPersonModel
{
//    NSString *string = @"{\"uname\":\"jack\",\"pic\":\"http://krplus-cdn.b0.upaiyun.com/common-module/common-header/images/logo.png\"}";
//    
//    Person *a = [Person data:[string jsonDictionary]];
//    
//    XCTAssertNotNil(a, @"model is nil");
//    XCTAssertNotNil(a.name, @"person has not a name!");
//    XCTAssertNotNil(a.avatar, @"person has not a avatar!");
}

- (void)testJsonAPI
{
    // 使用 measureBlock 方法可以记录该测试的耗时
//    [self measureBlock:^{
//
//        NSString *urlStr = @"http://xiaoliao.sinaapp.com/index.php/Api369/index/pad/0/sw/1/cid/mm/lastTime/1441598591";
//        NSString *newUrlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSURL *url = [NSURL URLWithString:newUrlStr];
//        NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
//        NSURLResponse *response = nil;
//        NSError *error = nil;
//
//        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
//
//        NSString *aString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//
//        XCTAssertNotNil(aString, @"json is nil");
//
//
//        NSArray *jsonArray = [aString jsonArray];
//
//        XCTAssertNotNil(jsonArray, @"jsonArray is empty!");
//
//        [jsonArray enumerateObjectsUsingBlock:^(NSDictionary *json, NSUInteger idx, BOOL *stop) {
//            Person *a = [Person data:json];
//            XCTAssertNotNil(a, @"model is nil");
//            XCTAssertNotNil(a.name, @"person has not a name!");
//            XCTAssertNotNil(a.avatar, @"person has not a avatar!");
//        }];
//    }];
}

@end
