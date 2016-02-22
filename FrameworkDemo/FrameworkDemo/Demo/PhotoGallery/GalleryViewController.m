//
//  PhotoGalleryViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/29.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "Masonry.h"
#import <UIImageView+WebCache.h>
#import "UIViewController+GinBaseCollectionView.h"

#import "GalleryViewController.h"
#import "HZCollectionViewLayout.h"

#import "GinPhotoGalleryController.h"

@interface PhotoGalleryCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *imageView;
@end
@implementation PhotoGalleryCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imageView];
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
    }
    return self;
}

@end

@interface GalleryViewController()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (assign, nonatomic) CGSize itemSize;
@end

@implementation GalleryViewController

+ (instancetype)galleryWithItemSize:(CGSize)itemSize
{
    GalleryViewController *gallery = [[GalleryViewController alloc] init];
    gallery.itemSize = itemSize;
    return gallery;
}

- (void)dealloc
{
    [self cleanup_GinBaseCollectionView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setup_GinBaseCollectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView config:^(UICollectionView *collectionView) {
        HZCollectionViewLayout *layout = [[HZCollectionViewLayout alloc] init];
        layout.itemSize = CGSizeEqualToSize(self.itemSize, CGSizeZero)? CGSizeMake(100, 100):self.itemSize;
        
        collectionView.collectionViewLayout = layout;
        collectionView.delegate = self;
        collectionView.dataSource = self;
        [collectionView registerClass:[PhotoGalleryCell class] forCellWithReuseIdentifier:NSStringFromClass([PhotoGalleryCell class])];
    }];
    [self.view addSubview:self.collectionView];
    
    [self updateViewConstraints];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (void)setImageUrlList:(NSArray *)imageUrlList
{
    self.cellDataList = imageUrlList;
    [self.collectionView reloadData];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoGalleryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PhotoGalleryCell class]) forIndexPath:indexPath];

    NSString *url = self.cellDataList[indexPath.row];
    cell.backgroundColor = [UIColor redColor];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:url]];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cellDataList.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GinPhotoGalleryController *vc = [[GinPhotoGalleryController alloc] init];
    [vc setImageUrlList:self.cellDataList selectedIndex:indexPath.row];

    [self.lastPresentedViewController presentViewController:vc animated:YES completion:^{
        ;
    }];
    
}


@end
