//
//  PhotoDetailViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/29.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "GinPhotoGalleryController.h"

#import <Masonry.h>
#import "GinPageViewController.h"
#import "GinShowPhotoViewController.h"

@interface GinPhotoGalleryController()

@property (copy, nonatomic) NSArray *imageUrlList;
@property (strong, nonatomic) UILabel *numLabel;
@property (strong, nonatomic) GinPageViewController *pageController;
@end

@implementation GinPhotoGalleryController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self.view addSubview:self.pageController.view];
    [self addChildViewController:self.pageController];
    [self.pageController didMoveToParentViewController:self];
    
    __weak GinPhotoGalleryController *weakSelf = self;
    
    [self.pageController setPageDidChanged:^(UIPageViewController *controller, NSUInteger index) {
        weakSelf.numLabel.text = [NSString stringWithFormat:@"%@/%@",@(index+1),@(weakSelf.imageUrlList.count)];
        
    }];

    [self.view addSubview:self.numLabel];
    
    [self updateViewConstraints];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(20);
        make.left.offset(0);
        make.right.offset(0);
        make.height.offset(50);
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)setImageUrlList:(NSArray *)imageUrlList selectedIndex:(NSUInteger)index
{
    _imageUrlList = imageUrlList;
    
    NSMutableArray *viewControllers = [NSMutableArray array];
    
    for (NSURL *url in imageUrlList) {
        GinShowPhotoViewController *photo = [[GinShowPhotoViewController alloc] init];
        [photo setImageByURL:url];
        [viewControllers addObject:photo];
    }
    
    [self.pageController setContentViewControllers:viewControllers selectedIndex:index];
    self.numLabel.text = [NSString stringWithFormat:@"%@/%@",@(index+1),@(imageUrlList.count)];
}

- (GinPageViewController *)pageController
{
    if (!_pageController) {
        _pageController = [[GinPageViewController alloc] init];
    }
    return _pageController;
}

- (UILabel *)numLabel
{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.text = @"0/0";
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.textColor = [UIColor whiteColor];
        _numLabel.font = [UIFont boldSystemFontOfSize:21];
    }
    return _numLabel;
}


@end
