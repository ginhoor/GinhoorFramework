//
//  GinAlertManager.m
//  WeAreInspector
//
//  Created by JunhuaShao on 16/8/26.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "GinAlertManager.h"
#import "GinPopup.h"
#import "TitleAndButtonAlertView.h"

@implementation GinAlertManager

+ (instancetype)sharedInstance
{
    static GinAlertManager* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [GinAlertManager new];
    });

    return instance;
}

- (void)showTitle:(NSString *)title content:(NSString *)content submit:(void(^)(void))submitBlock cancel:(void(^)(void)) cancelBlock
{
    TitleAndButtonAlertView *view = [[TitleAndButtonAlertView alloc] initWithFrame:CGRectMake(0, 0, 400, 250)];
    
    [view setCancleActionBlock:^{
        if (cancelBlock) {
            cancelBlock();
        }
        [GinPopup dismissWhenCompletion:^{}];
    }];
    
    [view setSubmitActionBlock:^{
        if (submitBlock) {
            submitBlock();
        }
        [GinPopup dismissWhenCompletion:^{}];
    }];
    
    view.titleLabel.text = title;
    view.contentLabel.text = content;
    
    [GinPopup showWithContentView:view];
}


@end
