//
//  UIAlertView+Unit.m
//  LOLBox
//
//  Created by JunhuaShao on 15/4/2.
//  Copyright (c) 2015年 Ginhoor. All rights reserved.
//

#import "UIAlertView+Unit.h"
#import "UIAlertController+Unit.h"
#import <BlocksKit+UIKit.h>

@implementation UIAlertView (Unit)


+ (void)alertView:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock
{
    Class UIAlertControllerClass = NSClassFromString(@"UIAlertController");
    
    if (UIAlertControllerClass) {
        
        [UIAlertController defaultAlert:title
                                message:message
                            cancelTitle:cancelTitle
                            cancelBlock:^(UIAlertAction *cancel) {
                                if(cancelBlock){
                                    cancelBlock();
                                }
                            }
                         completedBlock:^{
                                ;
                            }];
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:nil];
        [alert bk_setHandler:^{
            if (cancelBlock) {
                cancelBlock();
            }
        }forButtonAtIndex:0];
        
        [alert show];
    }
}


+ (void)alertView:(NSString *)title message:(NSString *)message submitTitle:(NSString *)submitTitle submitBlock:(void(^)())submitBlock cancelTitle:(NSString *)cancelTitle cancelBlock:(void(^)())cancelBlock
{
    
    Class UIAlertControllerClass = NSClassFromString(@"UIAlertController");
    
    if (UIAlertControllerClass) {
        
        [UIAlertController defaultAlert:title
                                message:message
                            cancelTitle:cancelTitle
                            cancelBlock:^(UIAlertAction *action) {
                                if (cancelBlock) {
                                    cancelBlock();
                                }
                            }
                            submitTitle:submitTitle
                            submitBlock:^(UIAlertAction *action) {
                                if (submitBlock) {
                                    submitBlock();
                                }
                            }
                         completedBlock:^{}];
    } else {

        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelTitle otherButtonTitles:submitTitle, nil];
        [alert bk_setHandler:^{
            if (cancelBlock) {
                cancelBlock();
            }
        }forButtonAtIndex:0];
        
        [alert bk_setHandler:^{
            if (submitBlock) {
                submitBlock();
            }
        } forButtonAtIndex:1];
        [alert show];
    }
}



@end
