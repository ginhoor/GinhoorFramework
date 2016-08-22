//
//  TechnicianExtandMenu.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/5/22.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "ExtendMenu.h"
#import "Masonry.h"

@interface ExtendMenuCell()
@property (assign, nonatomic) CGFloat cellWidth;

@end
@implementation ExtendMenuCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.cellWidth = 0;
    [self.contentView addSubview:self.icon];
    
    [self setConstraints];
}

// 设置 view 的初次约束
- (void)setConstraints
{
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

}

- (UIImageViewAligned *)icon
{
    if (!_icon) {
        _icon = [[UIImageViewAligned alloc] init];
        _icon.layer.masksToBounds = YES;
    }
    return _icon;
}

@end

@implementation ExtendMenu


- (GinExtendMenu *)extendMenu
{
    if (!_extendMenu) {
        _extendMenu = [[GinExtendMenu alloc] init];
        [_extendMenu.contentView addSubview:self.collection];
        [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.lessThanOrEqualTo(self.collection.superview).offset(5);
            make.left.offset(0);
            make.right.offset(0);
            make.bottom.lessThanOrEqualTo(self.collection.superview).offset(-5);
        }];
    }
    return _extendMenu;
}

- (UICollectionView *)collection
{
    if (!_collection) {
        HZCollectionViewLayout *layout = [[HZCollectionViewLayout alloc] init];
        _collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collection.backgroundColor = [UIColor whiteColor];
        _collection.showsHorizontalScrollIndicator = NO;
        _collection.showsVerticalScrollIndicator = NO;
    }
    return _collection;
}


@end
