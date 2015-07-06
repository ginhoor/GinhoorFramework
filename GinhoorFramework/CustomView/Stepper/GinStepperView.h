//
//  GinStepperView.h
//  hme.ios.cn
//
//  Created by JunhuaShao on 15/3/21.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//


typedef NS_ENUM(NSUInteger, GinStepperType) {
    GinStepperTypeRounded,
    GinStepperTypeRectangled
};

@interface GinStepperView : UIView

@property (strong, nonatomic) UIStepper *stepper;
@property (assign, nonatomic) GinStepperType type;
@property (assign, nonatomic) BOOL toggleAmianted;
@property (strong, nonatomic, readonly) NSNumber *value;



@property (copy, nonatomic) void(^stepperValueChangedBlock)(NSUInteger value);

- (void)setStepperValue:(NSUInteger)value;


@end
