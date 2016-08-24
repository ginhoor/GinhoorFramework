//
//  AppRouter+PhotoGallery.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 16/8/18.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "AppRouter+PhotoGallery.h"

NSString * const kTargetPhotoGallery = @"PhotoGalleryAction";
NSString * const kActionDemo4GalleryController = @"demo4GalleryController";

@implementation AppRouter (PhotoGallery)

- (UIViewController *)demo4GalleryController
{
    return [self performTargetName:kTargetPhotoGallery actionName:kActionDemo4GalleryController params:nil];
}



@end
