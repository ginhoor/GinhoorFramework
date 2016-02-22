//
//  GinPopup.m
//  LOLBox
//
//  Created by JunhuaShao on 14-10-18.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import "Masonry.h"
#import "GinPopup.h"

@interface GinPopup()

@property (strong, nonatomic,readwrite) UIWindow *window;
@property (strong, nonatomic) GinPopupViewController *viewController;

@end

@implementation GinPopup

+ (instancetype)sharedInstance
{
    static GinPopup *share;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[GinPopup alloc] init];
    });
    return share;
}

+ (void)showWithContentView:(UIView *)contentView
{
    GinPopup *pop = [GinPopup sharedInstance];
    [pop showWithContentView:contentView andAnimated:YES];
}


+ (void)dismissWhenCompletion:(void(^)())block
{
    GinPopup *pop = [GinPopup sharedInstance];
    [pop.viewController hideAnimated:YES completion:^{
        if (block) {
            block();
        }
    }];
}


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
}

- (void)showWithContentView:(UIView *)contentView andAnimated:(BOOL)animated
{
    [self.window makeKeyAndVisible];
    
    [self.viewController setPopupContentView:contentView];
    [self.viewController showAnimated:YES];
}

- (void)cleanup
{
    [[[UIApplication sharedApplication].delegate window] makeKeyWindow];
    [self.window removeFromSuperview];
    self.viewController = nil;
    self.window = nil;
}

- (GinPopupViewController *)viewController
{
    if (!_viewController) {
        _viewController = [[GinPopupViewController alloc] init];
        __weak GinPopup *weak = self;
        [_viewController setModelDidHideBlock:^{
            [weak cleanup];
            [[NSNotificationCenter defaultCenter] postNotificationName:kGinPopupDidHideNotification object:nil];
        }];
    }
    return _viewController;
}

- (UIWindow *)window
{
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.opaque = NO;
        _window.backgroundColor = [UIColor clearColor];
        _window.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        _window.rootViewController = self.viewController;
    }
    return _window;
}



@end
