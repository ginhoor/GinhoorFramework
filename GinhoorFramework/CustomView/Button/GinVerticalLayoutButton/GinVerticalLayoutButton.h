
//
//  GinTitleAndImageButton.h
//  demo4Button
//
//  Created by JunhuaShao on 15/3/25.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GinVerticalLayoutButton : UIButton

@property (assign, nonatomic) BOOL    showSelectedView;
@property (strong, nonatomic) UIColor *selectedColor;
@property (assign, nonatomic) CGFloat imageTopOffset;

@property (assign, nonatomic) BOOL hasSelectedBottomBar;

- (void)setup;

@end
