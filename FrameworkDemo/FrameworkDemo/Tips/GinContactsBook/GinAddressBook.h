//
//  GinAddressBook.h
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/7/3.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


@interface GinAddressBook : NSObject <ABPeoplePickerNavigationControllerDelegate>

/**
 @{@"fullname"       : 全名,
 @"firstName"        : 名,
 @"lastName"         : 姓,
 @"selectedPhone"    : 选中的手机号
 @"phones"           : 所有联系方式
 };
 */
+ (void)showInController:(UIViewController *)controller isNeedCheckPhoneFormat:(BOOL)isNeedCheckPhoneFormat handlerBlock:(void(^)(NSDictionary *data))resultHandlerBlock;

@end