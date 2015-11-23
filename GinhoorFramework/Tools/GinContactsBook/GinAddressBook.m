//
//  GinAddressBook.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/7/3.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GinAddressBook.h"

@interface GinAddressBook()<ABPeoplePickerNavigationControllerDelegate>

@property (weak, nonatomic) UIViewController *targetController;
@property (strong, nonatomic) ABPeoplePickerNavigationController *pickerView;
@property (copy, nonatomic) void(^resultHandlerBlock)(NSDictionary *data);
@property (assign, nonatomic) BOOL isNeedCheckPhoneFormat;

@end

@implementation GinAddressBook


+ (instancetype)sharedInstance
{
    static GinAddressBook *share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[GinAddressBook alloc] init];
    });
    return share;
}

+ (void)showInController:(UIViewController *)controller isNeedCheckPhoneFormat:(BOOL)isNeedCheckPhoneFormat handlerBlock:(void(^)(NSDictionary *data))resultHandlerBlock;
{
    GinAddressBook *book = [GinAddressBook sharedInstance];
    
    book.resultHandlerBlock = resultHandlerBlock;
    book.targetController = controller;
    book.isNeedCheckPhoneFormat = isNeedCheckPhoneFormat;
    
    book.pickerView = [[ABPeoplePickerNavigationController alloc] init];
    book.pickerView.peoplePickerDelegate = book;
    book.pickerView.displayedProperties = [NSArray arrayWithObject:[NSNumber numberWithInt:kABPersonPhoneProperty]];
    [book.targetController presentViewController:book.pickerView animated:YES completion:nil];
    
}

- (void)peoplePickerDidSelectPersonHandler:(ABRecordRef)person identifier:(ABMultiValueIdentifier)identifier
{
    ABMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phoneMulti,identifier);
    
    NSString *firstName = (__bridge NSString *)ABRecordCopyValue(person, kABPersonFirstNameProperty);
    if (firstName==nil) {
        firstName = @" ";
    }
    
    NSString *lastName=(__bridge NSString *)ABRecordCopyValue(person, kABPersonLastNameProperty);
    if (lastName==nil) {
        lastName = @" ";
    }
    
    NSMutableArray *phones = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < ABMultiValueGetCount(phoneMulti); i++) {
        NSString *aPhone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phoneMulti, i);
        [phones addObject:aPhone];
    }

    NSString *selectedPhone = (__bridge NSString *)ABMultiValueCopyValueAtIndex(phoneMulti, index);
    selectedPhone = [selectedPhone stringByReplacingOccurrencesOfString:@"-" withString:@""];

    NSDictionary *dic = @{@"fullname": [NSString stringWithFormat:@"%@%@", firstName, lastName],
                          @"firstName":firstName,
                          @"lastName":lastName,
                          @"phones": phones,
                          @"selectedPhone":selectedPhone
                          };

    if (self.isNeedCheckPhoneFormat) {
        if (selectedPhone && selectedPhone.length == 11) {
            if (self.resultHandlerBlock) {
                self.resultHandlerBlock(dic);
            }
            [self.pickerView dismissViewControllerAnimated:YES completion:nil];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择正确11位手机号" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alertView show];
        }
    } else {
        if (self.resultHandlerBlock) {
            self.resultHandlerBlock(dic);
        }
        [self.pickerView dismissViewControllerAnimated:YES completion:nil];
    }
    
}


#pragma mark -  ABPeoplePickerNavigationControllerDelegate
// Called after the user has pressed cancel.
- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    if (self.resultHandlerBlock) {
        self.resultHandlerBlock(nil);
    }
    [self.pickerView dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark iOS 8.0 之后
// Called after a property has been selected by the user.
- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    
    [self peoplePickerDidSelectPersonHandler:person identifier:identifier];
}
#pragma mark iOS 8.0 之前
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person {
    return YES;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
                                property:(ABPropertyID)property
                              identifier:(ABMultiValueIdentifier)identifier
{
    [self peoplePickerDidSelectPersonHandler:person identifier:identifier];
    // 不执行默认的操作，如，打电话
    return NO;  
}

@end
