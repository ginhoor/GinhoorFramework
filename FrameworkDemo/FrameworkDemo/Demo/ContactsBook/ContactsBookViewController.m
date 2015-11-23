//
//  ContactsBookViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/11/23.
//  Copyright © 2015年 JunhuaShao. All rights reserved.
//

#import "ContactsBookViewController.h"
#import "GinContactsBook.h"

@interface ContactsBookViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lable;

@end

@implementation ContactsBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showContactsBook:(id)sender
{
    [GinContactsBook showInController:self isNeedCheckPhoneFormat:NO handlerBlock:^(NSDictionary *data) {
    }];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
