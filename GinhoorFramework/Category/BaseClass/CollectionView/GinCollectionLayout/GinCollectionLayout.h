//
//  GinCollectionLayout.h
//  gameTrailers
//
//  Created by Ginhoor on 13-12-27.
//  Copyright (c) 2013年 Ginhoor. All rights reserved.
//

@import UIKit;

@interface GinCollectionLayout : UICollectionViewFlowLayout

// 减震
@property (assign, nonatomic) CGFloat springDamping;
// 频率
@property (assign, nonatomic) CGFloat springFrequency;
// 阻力
@property (assign, nonatomic) CGFloat resistanceFactor;

+ (void)needReloadDataByLayout:(UICollectionViewLayout *)layout;



@end
