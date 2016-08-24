//
//  AppRouter+ContactsBook.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/18.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppRouter+ContactsBook.h"

NSString * const kTargetConstracsBook = @"ContactsBookAction";
NSString * const kActionContactsBookViewController = @"contactsBookViewController";

@implementation AppRouter (ContactsBook)

- (UIViewController *)contactsBookController {
    
    return [self performTargetName:kTargetConstracsBook actionName:kActionContactsBookViewController params:nil];
}

@end
