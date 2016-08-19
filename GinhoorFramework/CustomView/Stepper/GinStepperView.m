//
//  GinStepperView.m
//  hme.ios.cn
//
//  Created by JunhuaShao on 15/3/21.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import "Masonry.h"
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
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = 1;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.toggleAmianted = YES;
    [self addSubview:self.backgroundControl];
    [self addSubview:self.decrease];
    [self addSubview:self.increase];
    [self addSubview:self.valueLabel];
    [self setConstraints];
}

// 设置 view 的初次约束
- (void)setConstraints
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
}

- (void)layoutSubviews
{
    if (self.layer.bounds.size.height != self.viewHeight) {
        switch (self.type) {
            case GinStepperTypeRounded:{
                self.layer.cornerRadius = self.layer.bounds.size.height/2;
                self.viewHeight = self.layer.bounds.size.height;
            }break;
             
            case GinStepperTypeRectangled:{
                self.layer.cornerRadius = 4;
                self.viewHeight = self.layer.bounds.size.height;
            }break;
                
            default:
                break;
        }
    }
    [super layoutSubviews];
}


- (void)setToggleAmianted:(BOOL)toggleAmianted
{
    _toggleAmianted = toggleAmianted;
    
    if (toggleAmianted) {
        [self toggleMode:NO animated:NO];
    } else {
        [self toggleMode:YES animated:NO];
    }
}

- (void)setStepperValue:(NSUInteger)value
{
    self.stepper.value = value;
    
    if (self.toggleAmianted) {
        if (self.stepper.value == 0) {
            
            //        判断当前控件是否需要刷新约束（主要防止影响位置初始化）
            if (self.needsUpdateConstraints)
            {
                [self toggleMode:NO animated:NO];
            } else {
                [UIView animateWithDuration:0.2 animations:^{
                    [self toggleMode:NO animated:YES];
                    [self layoutIfNeeded];
                    [self.decrease layoutIfNeeded];
                }];
            }
        } else if (self.stepper.value != 0){
            if (self.needsUpdateConstraints)
            {
                [self toggleMode:YES animated:NO];
            } else {
                [UIView animateWithDuration:0.2 animations:^{
                    [self toggleMode:YES animated:YES];
                }];
            }
        }
    } else {
        [self toggleMode:YES animated:NO];
    }
    
    self.valueLabel.text = @(self.stepper.value).stringValue;
}

- (void)toggleMode:(BOOL)isOpen animated:(BOOL)animated
{
    if (isOpen) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(90);
        }];
        
        [self.decrease mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(30);
        }];
        
    } else {
        [self.decrease mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(0);
        }];
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.offset(30);
        }];
    }
    
    if (animated) {
        [self layoutIfNeeded];
        [self.decrease layoutIfNeeded];
    }
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
        _stepper.wraps = YES;
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
        _valueLabel.text = @"0";
    }
    return _valueLabel;
}

- (NSNumber *)value
{
    return @(self.stepper.value);
}

- (void)valueChangeAction:(id)sender
{
    NSInteger currentValue = self.stepper.value;
    if (sender == self.increase) {
        currentValue ++;
    } else if (sender == self.decrease) {

        currentValue -- ;
    }
    
    if (currentValue < self.stepper.minimumValue) {
        currentValue = self.stepper.minimumValue;
    }
    
    [self setStepperValue:currentValue];
    if (self.stepperValueChangedBlock) {
        self.stepperValueChangedBlock(currentValue);
    }
}


@end
