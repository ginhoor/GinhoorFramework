//
//  ShowPhotoView.h
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/29.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GinShowPhotoViewController : UIViewController <UIScrollViewDelegate>


@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIImageView  *imageView;


- (void)setImageByURL:(NSURL *)url;

@end
