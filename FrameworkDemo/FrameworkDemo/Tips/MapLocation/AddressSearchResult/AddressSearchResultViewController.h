//
//  AddressSearchResultViewController.h
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/7/17.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "BaseViewController.h"

@interface AddressSearchResultViewController : BaseViewController

@property (strong, nonatomic, readonly) UISearchBar *searchBar;
@property (strong, nonatomic) NSString *currentCityName;

@property (copy, nonatomic) void(^didAddressSelectedBlock)(NSString *fullAddress, NSString *city, NSString *district, NSString *address);

@end
