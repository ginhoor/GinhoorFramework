//
//  UIImagePickerMananger.h
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/7/4.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface UIImagePickerMananger : NSObject

/**
 *  是否允许编辑图片
 */
@property (assign, nonatomic) BOOL allowsEditing;

@property (copy, nonatomic) void(^didFinishPickingBlock)(UIImagePickerController *picker, UIImage *packedImage, UIImage *source);
@property (copy, nonatomic) void(^didCancelPickingBlock)(UIImagePickerController *picker);

+ (instancetype)manager;

- (void)showImagePickerSheet:(UIViewController *)vc inView:(UIView *)view;

@end
