//
//  IconTextField.h
//  demo4UITextField
//
//  Created by JunhuaShao on 15/6/1.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IconTextField : UITextField

@property (assign, nonatomic) UIEdgeInsets textContentInsets;

@property (assign, nonatomic) CGPoint leftImageOffset;
@property (assign, nonatomic) CGSize leftImageSize;

- (void)addLeftImage:(UIImage *)image;

@end
