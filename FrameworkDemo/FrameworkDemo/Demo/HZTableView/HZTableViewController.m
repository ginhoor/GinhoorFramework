//
//  HZTableViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/5/22.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "Masonry.h"
#import "HZTableViewController.h"
#import "HZCollectionViewLayout.h"
@interface HZTableViewController () <UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation HZTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    HZCollectionViewLayout *layout = [[HZCollectionViewLayout alloc] init];
    layout.itemSize = CGSizeMake(100, 100);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    [self.view addSubview:self.collectionView];
    
    [self setConstraints];
}

// 设置 view 的初次约束
- (void)setConstraints
{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.offset(200);
    }];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];

    cell.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    label.text = @"123";
    [cell addSubview:label];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}


@end
