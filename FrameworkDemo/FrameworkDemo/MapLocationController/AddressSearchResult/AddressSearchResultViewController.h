//
//  AddressSearchResultViewController.h
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/7/17.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "BaseViewController.h"

@interface AddressSearchResultViewController : BaseViewController

@property (copy, nonatomic) void(^didAddressSelectedBlock)(NSString *address);

@end
