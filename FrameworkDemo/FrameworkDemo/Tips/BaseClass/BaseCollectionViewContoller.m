//
//  BaseCollectionViewContoller.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/4.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "BaseCollectionViewContoller.h"

@interface BaseCollectionViewContoller ()

@end

@implementation BaseCollectionViewContoller

- (void)dealloc
{
    [self cleanup_GinBaseCollectionView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup_GinBaseCollectionView];
}

@end
