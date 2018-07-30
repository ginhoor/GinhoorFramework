//
//  Gin3DTouchViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 2016/11/29.
//  Copyright © 2016年 JunhuaShao. All rights reserved.
//

#import "Gin3DTouchViewController.h"
#import <Masonry.h>

#import "Detail3DTouchViewController.h"
#import "UIViewController+GinBaseClass.h"
/**
 注: 自定义图标需要使用镂空图标,同时建议1倍图标大小为35*35
 */
@interface Gin3DTouchViewController () <UIViewControllerPreviewingDelegate>

@property (strong, nonatomic) UILabel *touchLabel;

@property (strong, nonatomic) UIImageView *imageView;



@end

@implementation Gin3DTouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //check if the device supports 3DTouch
    if(self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable){
        [self registerForPreviewingWithDelegate:self sourceView:self.view];
    } else {
        
//        [[[UIAlertView alloc] initWithTitle:@"Error" message:@"3DTouch not available" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }

    
    self.touchLabel = [[UILabel alloc] init];
    self.touchLabel.text = @"Peek & Pop 测试";
    self.touchLabel.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.touchLabel];
    [self.touchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(200, 100));
    }];
    
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [UIImage imageNamed:@"test"];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.size.sizeOffset(CGSizeMake(80, 80));
    }];
    
    [self registerForPreviewingWithDelegate:self sourceView:self.touchLabel];

}


/**
 进入 peek 状态

 @param previewingContext <#previewingContext description#>
 @param location <#location description#>
 @return <#return value description#>
 */
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location
{
    // previewingContext.sourceView: 触发Peek & Pop操作的视图
    // previewingContext.sourceRect: 设置触发操作的视图的不被虚化的区域
    
    Detail3DTouchViewController *detailVC = [Detail3DTouchViewController controller];
    
    detailVC.view.backgroundColor = [UIColor redColor];
    // 预览区域大小(可不设置)
    detailVC.preferredContentSize = CGSizeMake(0, 300);
    
    previewingContext.sourceRect = self.touchLabel.frame;
    
    return detailVC;

}


/**
 进入 pop 状态

 @param previewingContext <#previewingContext description#>
 @param viewControllerToCommit <#viewControllerToCommit description#>
 */
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit
{
    [self.navigationController pushViewController:viewControllerToCommit animated:YES];
}





@end
