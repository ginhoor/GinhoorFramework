//
//  UIImagePickerMananger.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/7/4.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "UIImagePickerMananger.h"
#import <UIActionSheet+BlocksKit.h>

@interface UIImagePickerMananger() <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIViewController *controller;

@end
@implementation UIImagePickerMananger

+ (instancetype)manager
{
    static UIImagePickerMananger *share;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[UIImagePickerMananger alloc] init];
    });
    return share;
}

- (void)showImagePickerSheet:(UIViewController *)vc inView:(UIView *)view
{
    self.controller = vc;
    UIActionSheet *sheet = [UIActionSheet bk_actionSheetWithTitle:nil];
    
    [sheet bk_addButtonWithTitle:@"从相册选择" handler:^{
        
        UIImagePickerControllerSourceType sourceType;
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        } else {
            sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        }
        // 跳转到相机页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = self.allowsEditing;
        imagePickerController.sourceType = sourceType;
        [self.controller presentViewController:imagePickerController animated:NO completion:^{}];
    }];
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        [sheet bk_addButtonWithTitle:@"拍照" handler:^{
            // 跳转到相机页面
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = self.allowsEditing;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            [self.controller presentViewController:imagePickerController animated:NO completion:^{}];
        }];
    }
    
    [sheet bk_setCancelButtonWithTitle:@"取消" handler:^{
    }];
    
    [sheet showInView:view];
}


#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:NO completion:^{}];
    
    UIImage *editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    // 压缩
    NSData *imageData = UIImageJPEGRepresentation(editedImage,0.3);
    UIImage *savedImage = [UIImage imageWithData:imageData];
    
    
    if (self.didFinishPickingBlock)
    {
        self.didFinishPickingBlock(picker, savedImage, editedImage);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if (self.didCancelPickingBlock) {
        self.didCancelPickingBlock(picker);
    }
    
    [self.controller dismissViewControllerAnimated:NO completion:^{}];
}

@end
