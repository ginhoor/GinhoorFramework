//
//  IconTableCell.h
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/6/15.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Masonry.h>

@interface IconTableCell : UITableViewCell

- (void)setIcon:(UIImage *)image title:(NSAttributedString *)title showIndicator:(BOOL)showIndicator showSeparator:(BOOL)showSeparator;

+ (CGFloat)viewHeight;

@end
