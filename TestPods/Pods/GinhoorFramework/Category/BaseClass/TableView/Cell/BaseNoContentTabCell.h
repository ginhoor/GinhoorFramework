//
//  BaseNoContentCell.h
//  LOLBox
//
//  Created by Ginhoor on 14-1-16.
//  Copyright (c) 2014年 Ginhoor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface BaseNoContentTabCell : UITableViewCell
@property (strong, nonatomic) UILabel *noContentTipLabel;

+ (CGSize)cellSize;
@end
