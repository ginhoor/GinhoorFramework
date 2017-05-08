//
//  CECapturePhotoViewController.h
//  CarEagle
//
//  Created by JunhuaShao on 2017/4/24.
//  Copyright © 2017年 CarEagle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GinStillImageCaptureManager.h"
#import "CECapturePhotoView.h"

@interface CECapturePhotoViewController : UIViewController

@property (strong, nonatomic) GinStillImageCaptureManager *captureManager;
@property (strong, nonatomic) GinStillImage *currentCapturedImage;
@property (strong, nonatomic) CECapturePhotoView *captureView;

@end
