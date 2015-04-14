//
//  GinSystemButton.m
//  demo4AVOS
//
//  Created by Ginhoor on 14-8-1.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "GinSystemButton.h"

@implementation GinSystemButton

- (instancetype)init
{
    self = [GinSystemButton buttonWithType:UIButtonTypeSystem];
    if (self) {
        [self applyStyle];
    }
    return self;
}

+ (id)buttonWithType:(UIButtonType)buttonType
{
    GinSystemButton *button = [super buttonWithType:buttonType];
    [button applyStyle];
    return button;
}

- (void)applyStyle
{
    self.layer.cornerRadius = 4.0f;
    self.layer.masksToBounds = YES;
    
    self.tintColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor colorWithRed:40/255.f green:35/255.f blue:67/255.f alpha:1.f];
    self.showsTouchWhenHighlighted = YES;
}


@end
