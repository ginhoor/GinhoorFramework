//
//  GinContactsBook.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/11/20.
//  Copyright © 2015年 JunhuaShao. All rights reserved.
//

#import "GinContactsBook.h"
#import "UIAlertController+GinUnit.h"
/**
    CNAuthorizationStatus枚举值
    NotDetermined: 这个状态表示用户现在为止还没有允许或者拒绝对联系人数据库的访问。应用在设备上第一次安装时就会是这个状态。
    Restricted: 这个状态表示应用不仅不能访问联系人数据，而且用户也没有权限在Settings里修改这个权限。这个状态可能是其他活跃的限制条件的结果（例如. Parental control）
    Denied: 当应用是这个状态时，表示用户已经选择了不允许访问联系人数据信息。而这个只能被用户本人改变。
    Authorized: 这是每个应用的理想状态。当应用是这个状态时，它可以自由访问联系人数据库并且实现需要联系人数据的任务。
 */

@interface GinContactsBook() <CNContactPickerDelegate>

@property (strong, nonatomic) CNContactPickerViewController *pickerViewController;

@property (strong, nonatomic) CNContactStore *contactStore;
@end

@implementation GinContactsBook

+ (instancetype)sharedInstance
{
    static GinContactsBook *share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[GinContactsBook alloc] init];
    });
    return share;
}


+ (void)showInController:(UIViewController *)controller isNeedCheckPhoneFormat:(BOOL)isNeedCheckPhoneFormat handlerBlock:(void(^)(NSDictionary *data))resultHandlerBlock
{
    GinContactsBook *instance = [GinContactsBook sharedInstance];
    
    [instance requestForAccess:^(BOOL accessGranted) {
        
        if (accessGranted) {
            instance.pickerViewController.displayedPropertyKeys = self.defualtKeys;
            [controller presentViewController:instance.pickerViewController animated:YES completion:^{
                ;
            }];
        }
    }];
}

+ (void)showInController:(UIViewController *)controller predicate:(NSPredicate *)predicate isNeedCheckPhoneFormat:(BOOL)isNeedCheckPhoneFormat handlerBlock:(void(^)(NSDictionary *data))resultHandlerBlock
{
    GinContactsBook *instance = [GinContactsBook sharedInstance];
    
    [instance requestForAccess:^(BOOL accessGranted) {
        
        if (accessGranted) {
            instance.pickerViewController.displayedPropertyKeys = self.defualtKeys;
            [controller presentViewController:instance.pickerViewController animated:YES completion:^{
                ;
            }];
        }
    }];
}

+ (void)queryContactsByMatchingName:(NSString *)name completionHandler:(void(^)(NSArray *contacts))completionHandler
{

    [self queryContactsByMatchingName:name infoKeys:[self defualtKeys] completionHandler:completionHandler];
}

+ (void)queryContactsByMatchingName:(NSString *)name infoKeys:(NSArray *)infoKeys completionHandler:(void(^)(NSArray *contacts))completionHandler
{
    
    GinContactsBook *instance = [GinContactsBook sharedInstance];
    
    [instance requestForAccess:^(BOOL accessGranted) {
        if (accessGranted) {
            
            NSPredicate *predicate = [CNContact predicateForContactsMatchingName:name];
            
            NSError *__autoreleasing error = nil;
            NSArray *contacts = [instance.contactStore unifiedContactsMatchingPredicate:predicate keysToFetch:infoKeys error:&error];
            if (error) {
                NSLog(@"query contacts by matching name failed--->%@",error);
            }
            completionHandler(contacts);
        } else {
            completionHandler(nil);
        }
    }];
}


- (void)requestForAccess:(void(^)(BOOL accessGranted))completionHandler
{
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    
    switch (status) {
        case CNAuthorizationStatusAuthorized:
            completionHandler(YES);
            break;
        case CNAuthorizationStatusDenied:
        case CNAuthorizationStatusNotDetermined:
        {
            [self.contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    completionHandler(granted);
                } else{
                    if (status == CNAuthorizationStatusDenied) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [UIAlertController alert:@"提示" message:@"请在设置允许APP读取您的联系人列表" cancelTitle:@"确认" cancelBlock:nil completionBlock:nil];
                        });
                    }
                }
            }];
        }
        break;
            
        default:
            completionHandler(NO);
            break;
    }
}

- (BOOL)checkCurrentContact:(CNContact *)currentContact infoKeys:(NSArray *)infoKeys
{
    __block BOOL flag = YES;
    
    [infoKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![currentContact isKeyAvailable:obj]) {
            *stop = YES;
            flag = NO;
        }
    }];

    return flag;
}

- (CNContact *)refetchContact:(CNContact *)contact store:(CNContactStore *)store keys:(NSArray *)keys
{
    NSError *__autoreleasing error;
    
    contact = [store unifiedContactWithIdentifier:contact.identifier keysToFetch:keys error:&error];
    
    if (error) {
        NSLog(@"refetch contact error-->%@",error);
    }
    
    return contact;
}


+ (NSArray *)defualtKeys
{
    return @[[CNContactFormatter descriptorForRequiredKeysForStyle:CNContactFormatterStyleFullName],CNContactEmailAddressesKey,CNContactBirthdayKey,CNContactImageDataKey];
    
}

/**
 *  Demo
 */
+ (void)customQueryContacts
{
    
    GinContactsBook *instance = [self sharedInstance];
    
    NSError *__autoreleasing error;
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] init];
    
    request.keysToFetch = [self defualtKeys];
    
    [instance.contactStore enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {

        if (contact.birthday != nil) {
        }
    }];
    
    if (error) {
        NSLog(@"refetch contact error-->%@",error);
    }
}


- (CNContactPickerViewController *)pickerViewController
{
    if (!_pickerViewController) {
        _pickerViewController = [[CNContactPickerViewController alloc] init];
        _pickerViewController.delegate = self;
    }
    return _pickerViewController;
}

- (CNContactStore *)contactStore
{
    if (!_contactStore) {
        _contactStore = [[CNContactStore alloc] init];
    }
    return _contactStore;
}


#pragma mark- delegate


- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact
{
    
    NSLog(@"--->%@",contact);

    if (self.resultHandlerBlock) {
        self.resultHandlerBlock(@{});
    }
    
}

//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperties:(NSArray<CNContactProperty *> *)contactProperties
//{
//    
//}

@end


@implementation CNContact (GinContactsBook)

- (NSString *)fullName:(CNContact *)contact
{
    return [CNContactFormatter stringFromContact:contact style:CNContactFormatterStyleFullName];
}


@end

