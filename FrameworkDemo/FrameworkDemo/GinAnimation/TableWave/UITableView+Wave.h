//
//  UITableView+Wave.h
//  LOLBox
//
//  Created by Ginhoor on 14-7-16.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBOUNCE_DISTANCE  4.0f
#define kWAVE_DURATION    0.15f


typedef NS_ENUM(NSInteger,WaveAnimation) {
    LeftToRightWaveAnimation = -1,
    RightToLeftWaveAnimation = 1
};


@interface UITableView (Wave)

- (void)reloadDataAnimateWithWave:(WaveAnimation)animation;

@end
