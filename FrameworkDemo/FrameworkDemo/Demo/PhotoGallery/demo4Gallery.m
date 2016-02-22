//
//  demo4Gallery.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/29.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "demo4Gallery.h"
#import "GalleryViewController.h"
#import "Masonry.h"

@implementation demo4Gallery

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    GalleryViewController *vc = [GalleryViewController galleryWithItemSize:CGSizeMake(150, 150)];

    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:vc.view];
    [self addChildViewController:vc];
    [vc didMoveToParentViewController:self];
    [vc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(100);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(150);
    }];
    
    [vc setImageUrlList:@[@"http://img02.taobaocdn.com/bao/uploaded/i1/2113612801/TB2TUHObVXXXXX0XXXXXXXXXXXX_!!2113612801.jpg_80x80.jpg",
                          @"http://gdp.alicdn.com/imgextra/i3/2113612801/TB2odZQcXXXXXaUXpXXXXXXXXXX_!!2113612801.jpg",
                          @"http://gdp.alicdn.com/imgextra/i4/2113612801/TB2mWIYcXXXXXbAXXXXXXXXXXXX_!!2113612801.jpg",
                          @"http://gdp.alicdn.com/imgextra/i3/2113612801/TB2odZQcXXXXXaUXpXXXXXXXXXX_!!2113612801.jpg"]];
    
}


@end
