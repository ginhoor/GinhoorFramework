//
//  GinStepperView.m
//  hme.ios.cn
//
//  Created by JunhuaShao on 15/3/21.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import <Masonry.h>
#import "GinStepperView.h"

@interface GinStepperView()

@property (strong, nonatomic) UIControl *backgroundControl;
@property (strong, nonatomic) UIButton *increase;
@property (strong, nonatomic) UIButton *decrease;

@property (strong, nonatomic) UILabel *valueLabel;

@property (strong, nonatomic) UIImageView *backgroundImageView;

@property (assign, nonatomic) CGFloat viewHeight;

@end

@implementation GinStepperView


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
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;

    [self addSubview:self.backgroundControl];
    [self addSubview:self.decrease];
    [self addSubview:self.increase];
    [self addSubview:self.valueLabel];
}

- (void)updateConstraints
{

    [self.backgroundControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.decrease.mas_right);
        make.right.equalTo(self.increase.mas_left);
        make.top.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.decrease mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.bottom.equalTo(self);
    }];
    
    [self.increase mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.width.offset(30);
    }];
    
    [super updateConstraints];
}


- (void)layoutSubviews
{
    if (self.layer.bounds.size.height != self.viewHeight) {
        self.layer.cornerRadius = self.layer.bounds.size.height/2;
        self.viewHeight = self.layer.bounds.size.height;
    }
    [super layoutSubviews];
}


- (void)setStepperValue:(NSUInteger)value
{
    self.stepper.value = value;
    
    if (self.stepper.value == 0) {

        [UIView animateWithDuration:0.2 animations:^{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.offset(30);
            }];
            
            [self.decrease mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.offset(0);
            }];
            [self layoutIfNeeded];
            [self.decrease layoutIfNeeded];
        }];

    } else if (self.stepper.value != 0){
        
        [UIView animateWithDuration:0.15 animations:^{
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.offset(90);
            }];
            
            [self.decrease mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.offset(30);
            }];
            [self layoutIfNeeded];
            [self.decrease layoutIfNeeded];
        }];
    }
    self.valueLabel.text = @(self.stepper.value).stringValue;
}

- (UIControl *)backgroundControl
{
    if (!_backgroundControl) {
        _backgroundControl = [[UIControl alloc] init];
    }
    return _backgroundControl;
}

- (UIStepper *)stepper
{
    if (!_stepper) {
        _stepper = [[UIStepper alloc] init];
        _stepper.maximumValue = 99;
        _stepper.minimumValue = 0;
    }
    return _stepper;
}

- (UIButton *)increase
{
    if (!_increase) {
        _increase = [[UIButton alloc] init];
        [_increase addTarget:self action:@selector(valueChangeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_increase setTitle:@"+" forState:UIControlStateNormal];
        [_increase setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _increase;
}

- (UIButton *)decrease
{
    if (!_decrease) {
        _decrease = [[UIButton alloc] init];
        [_decrease addTarget:self action:@selector(valueChangeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_decrease setTitle:@"-" forState:UIControlStateNormal];
        [_decrease setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _decrease;
}

- (UILabel *)valueLabel
{
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _valueLabel;
}

- (NSNumber *)value
{
    return @(self.stepper.value);
}

- (void)valueChangeAction:(id)sender
{
    NSUInteger currentValue = self.stepper.value;
    if (sender == self.increase) {
        currentValue ++;
    } else if (sender == self.decrease) {
        currentValue --;
    }
    
    [self setStepperValue:currentValue];
    
    if (self.stepperValueChangedBlock) {
        self.stepperValueChangedBlock(currentValue);
    }
}


@end
