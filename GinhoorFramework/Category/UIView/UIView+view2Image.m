//
//  UIView+view2Image.m
//  ToDoList
//
//  Created by apple on 13-7-31.
//  Copyright (c) 2013年 Ginhoor. All rights reserved.
//

#import "UIView+view2Image.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (view2Image)

- (UIImage *)imageFromView{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
