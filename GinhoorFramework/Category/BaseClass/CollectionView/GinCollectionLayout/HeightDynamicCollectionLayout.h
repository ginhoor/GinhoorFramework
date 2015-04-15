//
//  ForcasetCollectionLayout.h
//  Yaobao
//
//  Created by Ginhoor on 14-3-11.
//  Copyright (c) 2014年 zhitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeightDynamicCollectionLayoutDelegate <NSObject>

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface HeightDynamicCollectionLayout : UICollectionViewFlowLayout

@property (weak, nonatomic) id<HeightDynamicCollectionLayoutDelegate> delegate;

+ (void)setDelegateByLayout:(UICollectionViewLayout *)layout delegate:(id<HeightDynamicCollectionLayoutDelegate>)delegate;

@end
