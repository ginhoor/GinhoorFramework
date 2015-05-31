//
//  ShowPhotoView.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/29.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import "ShowPhotoViewController.h"


#define kMaxZoomScale 3.f

@interface ShowPhotoViewController()

@property (assign, nonatomic) CGFloat   minZoomScale;
@property (assign, nonatomic) CGFloat   fitZoomScale;
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;

@end

@implementation ShowPhotoViewController

- (void)dealloc
{
    self.scrollView.delegate = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self addGestureRecognizers];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    
    [self.view addSubview:self.indicatorView];
    [self.indicatorView startAnimating];
    self.indicatorView.hidden = NO;

    [self updateViewConstraints];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
    }];
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
//    恢复原装
    [self.scrollView setZoomScale:1.0];
}

- (void)setImageByURL:(NSURL *)url
{
    ShowPhotoViewController *__weak weak = self;

    [self.view layoutIfNeeded];
    
    [self.imageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [weak resetImageViewFrame:image];
        [UIView animateWithDuration:0.2f animations:^{
            weak.imageView.alpha = 1;
        }];
        [self.indicatorView stopAnimating];
    }];
}

- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}

- (void)addGestureRecognizers
{
    UITapGestureRecognizer *hideTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideButtonView:)];
    [self.view addGestureRecognizer:hideTap];
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _scrollView.backgroundColor = [UIColor blackColor];
        _scrollView.delegate = self;
//      当图片过小时，最大缩放比限制了ImageView自动Fit屏幕
        _scrollView.maximumZoomScale = kMaxZoomScale;
    }
    return _scrollView;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.userInteractionEnabled = YES;
        _imageView.alpha = 0.f;
    }
    return _imageView;
}

- (void)hideButtonView:(UITapGestureRecognizer *)sender
{
    if (!self.scrollView.dragging && !self.scrollView.tracking) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)setMinZoomScale:(CGFloat)minZoomScale
{
    _minZoomScale = minZoomScale;
    
    if (self.scrollView) {
        self.scrollView.minimumZoomScale = minZoomScale;
    }
}

#pragma mark- rotation
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    [self resetImageViewCenter:toInterfaceOrientation];
    
    self.fitZoomScale = [self tapScaleByImageSize:self.imageView.image.size orientation:toInterfaceOrientation];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //旋转完成后所有的view Frame才能正确
    self.minZoomScale = [self minScaleByImageSize:self.imageView.image.size toOrientation:self.interfaceOrientation];
    [self updateZoomScale:self.minZoomScale withCenter:self.imageView.center];
}



#pragma mark- Scroll delegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self resetImageViewCenter:self.interfaceOrientation];
}


#pragma mark- private

- (float)minScaleByImageSize:(CGSize)size toOrientation:(UIInterfaceOrientation)orientation
{
    CGSize screenSize = [self currentScreenSize:orientation];
    return MIN(screenSize.width/size.width, screenSize.height/size.height);
}

- (float)tapScaleByImageSize:(CGSize)size orientation:(UIInterfaceOrientation)orientation
{
    CGSize screenSize = [self currentScreenSize:orientation];
    return MAX(screenSize.width/size.width, screenSize.height/size.height);
}

- (void)resetImageViewFrame:(UIImage *)image
{
    self.minZoomScale = [self minScaleByImageSize:image.size toOrientation:self.interfaceOrientation];
    self.fitZoomScale = [self tapScaleByImageSize:image.size orientation:self.interfaceOrientation];
    
    self.scrollView.contentSize = image.size;//要缩放的UIImage对象
    self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.imageView.image = image;
    
    [self resetImageViewCenter:self.interfaceOrientation];
    [self updateZoomScale:self.minZoomScale withCenter:self.imageView.center];
    
}

- (void)resetImageViewCenter:(UIInterfaceOrientation)toOrientation
{
    CGSize scrollViewSize = [self currentScreenSize:toOrientation];
    
    CGFloat offsetX = (scrollViewSize.width > self.scrollView.contentSize.width)
    ? (scrollViewSize.width - self.scrollView.contentSize.width) * 0.5
    : 0.0;
    
    CGFloat offsetY = (scrollViewSize.height > self.scrollView.contentSize.height)
    ? (scrollViewSize.height - self.scrollView.contentSize.height) * 0.5
    : 0.0;
    
    self.imageView.center = CGPointMake(self.scrollView.contentSize.width * 0.5 + offsetX,
                                        self.scrollView.contentSize.height * 0.5 + offsetY);
}

- (CGSize)currentScreenSize:(UIInterfaceOrientation)orientation
{
    CGSize currentSize;
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        currentSize = CGSizeMake(CGRectGetHeight([UIScreen mainScreen].bounds), CGRectGetWidth([UIScreen mainScreen].bounds));
    } else {
        currentSize = CGSizeMake(CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds));
    }
    return currentSize;
}

- (void)updateZoomScale:(CGFloat)newScale withCenter:(CGPoint)center {
    if (self.scrollView.zoomScale != newScale) {
        CGRect zoomRect = [self zoomRectForScale:newScale withCenter:center];
        [self.scrollView zoomToRect:zoomRect animated:YES];
    }
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates.
    zoomRect.size.width = self.scrollView.frame.size.width / scale;
    zoomRect.size.height = self.scrollView.frame.size.height / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x = center.x - (zoomRect.size.width / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}

@end
