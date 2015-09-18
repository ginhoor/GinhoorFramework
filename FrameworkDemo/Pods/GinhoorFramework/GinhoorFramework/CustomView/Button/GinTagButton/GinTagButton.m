//
//  GinTitleAndTagButton.m
//  hme.ios.cn
//
//  Created by JunhuaShao on 15/3/24.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import <Masonry.h>

#import "GinTagButton.h"
@interface GinTagButton()

@property (strong, nonatomic) UILabel *tagLabel;
@property (assign, nonatomic) CGFloat viewHeight;
@property (assign, nonatomic) CGFloat tagTopOffset;

@end

@implementation GinTagButton


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
    [super setup];
    [self addSubview:self.tagLabel];
    self.showSelectedView = YES;
}

- (void)updateConstraints
{
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(self.tagTopOffset);
        make.centerX.equalTo(self).offset(15);
        make.size.sizeOffset(CGSizeMake(20, 20));
    }];
    [super updateConstraints];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.tagLabel.layer.bounds.size.height != self.viewHeight) {
        self.tagLabel.layer.cornerRadius = self.tagLabel.layer.bounds.size.height/2;
        self.viewHeight = self.layer.bounds.size.height;
    }
}

- (void)setTagCount:(NSUInteger)count
{
    self.tagLabel.text = @(count).stringValue;
}

- (void)setImageTopOffset:(CGFloat)imageTopOffset
{
    [super setImageTopOffset:imageTopOffset];
    self.tagTopOffset = imageTopOffset-10;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(self.frame.size.width/2.0 - 11.5, self.imageTopOffset, 23, 22);
}

- (UILabel *)tagLabel
{
    if (!_tagLabel) {
        _tagLabel = [[UILabel alloc] init];
        _tagLabel.textColor = [UIColor whiteColor];
        _tagLabel.backgroundColor = [UIColor redColor];
        _tagLabel.layer.masksToBounds = YES;
        _tagLabel.text = @"0";
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.hidden = YES;
        [_tagLabel setFont:[UIFont systemFontOfSize:10]];
    }
    return _tagLabel;
}

- (void)setTagHidden:(BOOL)hidden
{
    self.tagLabel.hidden = hidden;
}


@end
