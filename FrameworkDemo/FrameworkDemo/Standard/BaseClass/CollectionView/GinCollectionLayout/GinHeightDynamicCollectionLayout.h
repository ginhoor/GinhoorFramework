//
//  ForcasetCollectionLayout.h
//  Yaobao
//
//  Created by Ginhoor on 14-3-11.
//  Copyright (c) 2014年 zhitech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GinHeightDynamicCollectionLayoutDelegate <NSObject>

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface GinHeightDynamicCollectionLayout : UICollectionViewFlowLayout

@property (weak, nonatomic) id<GinHeightDynamicCollectionLayoutDelegate> delegate;

+ (void)setDelegateByLayout:(UICollectionViewLayout *)layout delegate:(id<GinHeightDynamicCollectionLayoutDelegate>)delegate;

@end
