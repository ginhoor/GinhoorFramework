//
//  PhotoGalleryViewController.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/29.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface GalleryViewController : UIViewController

+ (instancetype)galleryWithItemSize:(CGSize)itemSize;

- (void)setImageUrlList:(NSArray *)imageUrlList;

@end
