//
//  GetLaunchImage.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/10/28.
//  Copyright © 2015年 JunhuaShao. All rights reserved.
//

#import "GetLaunchImage.h"

@implementation GetLaunchImage

- (void)showLaunchImage
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    CGSize viewSize = window.bounds.size;
    NSString *viewOrientation = @"Portrait";    //横屏请设置成 @"Landscape"
    NSString *launchImage = nil;
    
    NSArray *imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in imagesDict)
    {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]])
        {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    
    UIImageView *launchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:launchImage]];
    launchView.frame = window.bounds;
    launchView.contentMode = UIViewContentModeScaleAspectFill;
    [window addSubview:launchView];
    
    [UIView animateWithDuration:2.0f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         launchView.alpha = 0.0f;
                         launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.2, 1.2, 1);
                     }
                     completion:^(BOOL finished) {
                         [launchView removeFromSuperview];
                     }];
}

@end
