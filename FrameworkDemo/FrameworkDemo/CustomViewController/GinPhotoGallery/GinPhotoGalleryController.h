//
//  PhotoDetailViewController.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/29.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIResponder+GinUnit.h"
@interface GinPhotoGalleryController : UIViewController

- (void)setImageUrlList:(NSArray *)imageUrlList selectedIndex:(NSUInteger)index;

@end
