//
//  PullDownMenuViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/6/12.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Masonry.h>
#import <BlocksKit.h>
#import "NSAttributedString+Unit.h"
#import "GinPullDownMenu.h"
#import "PullDownMenuViewController.h"

@interface PullDownMenuViewController()
@property (strong, nonatomic) GinPullDownMenu        *sortTypeMenu;
@end

@implementation PullDownMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.sortTypeMenu];
    [self.sortTypeMenu setCategorySelectedIndexBlock:^(NSArray *indexs) {
        
    }];

    [self.sortTypeMenu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.offset(40);
    }];

}


- (GinPullDownMenu *)sortTypeMenu
{
    if (!_sortTypeMenu) {
        _sortTypeMenu = [[GinPullDownMenu alloc] init];
        _sortTypeMenu.backgroundColor = [UIColor whiteColor];
        
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
        _sortTypeMenu.categoryTitles = @[[NSAttributedString string:@"距离" attribute:attributes]];
        _sortTypeMenu.menuCellDataList[0] = [@[@"距离",@"评分",@"价格从低到高",@"价格从高到低"] bk_map:^id(id obj) {
            return [NSAttributedString string:obj attribute:attributes];
        }];
    }
    return _sortTypeMenu;
}


@end
