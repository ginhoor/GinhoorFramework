//
//  GinImageButton.m
//  hmeIosCn
//
//  Created by JunhuaShao on 15/4/13.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import "GinImageButton.h"

@interface GinImageButton()

@end
@implementation GinImageButton


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
    self.adjustsImageWhenHighlighted = NO;
    self.adjustsImageWhenDisabled = NO;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height);
}

@end
