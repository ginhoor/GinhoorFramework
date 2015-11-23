//
//  GinContactsBook.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/11/20.
//  Copyright © 2015年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>



/**
 *  有坑！！！未完结
 *  [CNUI ERROR] error calling service - Couldn’t communicate with a helper application.

 */


@interface CNContact (GinContactsBook)

@end

@interface GinContactsBook : NSObject

/**
 @{@"fullname"       : 全名,
 @"firstName"        : 名,
 @"lastName"         : 姓,
 @"selectedPhone"    : 选中的手机号
 @"phones"           : 所有联系方式
 
 };
 */
@property (copy, nonatomic) void(^resultHandlerBlock)(NSDictionary *data);


+ (instancetype)sharedInstance;

/**
 *  联系人 UI操作
 *
 */
+ (void)showInController:(UIViewController *)controller isNeedCheckPhoneFormat:(BOOL)isNeedCheckPhoneFormat handlerBlock:(void(^)(NSDictionary *data))resultHandlerBlock;


/**
 *  联系人数据库直接操作
 *
 */
+ (void)queryContactsByMatchingName:(NSString *)name completionHandler:(void(^)(NSArray *contacts))completionHandler;
+ (void)queryContactsByMatchingName:(NSString *)name infoKeys:(NSArray *)infoKeys completionHandler:(void(^)(NSArray *contacts))completionHandler;

- (void)requestForAccess:(void(^)(BOOL accessGranted))completionHandler;

- (BOOL)checkCurrentContact:(CNContact *)currentContact infoKeys:(NSArray *)infoKeys;

- (CNContact *)refetchContact:(CNContact *)contact store:(CNContactStore *)store keys:(NSArray *)keys;

+ (NSArray *)defualtKeys;

@end
