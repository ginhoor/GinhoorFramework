//
//  GinPullDownMenu.m
//  hme.ios.cn
//
//  Created by JunhuaShao on 15/3/19.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import "GinPullDownMenu.h"
#import "GinPullDownMenuItem.h"
#import "GinPullDownMenuCell.h"

@interface GinPullDownMenu() <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray *categorySeletedIndex;

@property (strong, nonatomic) NSMutableArray *menuItems;
@property (strong, nonatomic) NSMutableArray *itemSeparators;

@property (strong, nonatomic) UITableView *tableView;

@property (strong, nonatomic) UIControl *backgroundControl;

@property (assign, nonatomic) NSInteger selectedIndex;

@property (assign, nonatomic) NSInteger currentIndex;

@end
@implementation GinPullDownMenu


- (void)dealloc
{
    self.categorySelectedIndexBlock = nil;
}

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
    self.backgroundColor = [UIColor whiteColor];
    
    self.selectedIndex = -1;
    self.animateMenuItemSelected = YES;
}

- (void)updateConstraints
{
    __block UIView *lastItemSeparator;
    
    CGFloat separatorWidth = 1;
    CGFloat separatorOffset = 10;
    CGFloat itemWidth = ([UIScreen mainScreen].bounds.size.width-self.itemSeparators.count*separatorWidth)/self.menuItems.count;
    
    [self.menuItems enumerateObjectsUsingBlock:^(GinPullDownMenuItem *item, NSUInteger idx, BOOL *stop) {
        
        [item mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            if (!lastItemSeparator) {
                make.left.equalTo(self);
            } else {
                make.left.equalTo(lastItemSeparator.mas_right);
            }
            make.bottom.equalTo(self);
            make.width.offset(itemWidth);
        }];
        
        if (self.itemSeparators.count > 0 && idx <= self.itemSeparators.count-1) {
            UIView *itemSeparator = self.itemSeparators[idx];
            
            [itemSeparator mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(item).offset(separatorOffset);
                make.left.equalTo(item.mas_right);
                make.bottom.equalTo(item).offset(-separatorOffset);
                make.centerY.equalTo(item);
                make.width.offset(separatorWidth);
                make.height.offset(20);
            }];
            lastItemSeparator = itemSeparator;
        }
    }];
    
    [super updateConstraints];
}

- (void)createViews
{
    [self.menuItems enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [view removeFromSuperview];
    }];
    [self.menuItems removeAllObjects];
    self.menuItems = [NSMutableArray array];
    
    [self.itemSeparators enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [view removeFromSuperview];
    }];
    [self.itemSeparators removeAllObjects];
    self.itemSeparators = [NSMutableArray array];
    
    
    [self.categoryTitles enumerateObjectsUsingBlock:^(NSAttributedString *str, NSUInteger idx, BOOL *stop) {
        GinPullDownMenuItem *item = [[GinPullDownMenuItem alloc] init];
        
        if (self.categoryTitles.count == 1) {
            item.type = GinPullDownMenuItemTypeSingle;
            item.titleLabel.textAlignment = NSTextAlignmentLeft;
        }
        
        [item setTapBlock:^(GinPullDownMenuItem *item) {
            NSInteger index = [self.menuItems indexOfObject:item];
            self.currentIndex = index;
        }];
        
        item.titleLabel.attributedText = str;
        [self addSubview:item];
        [self.menuItems addObject:item];
    }];
    
    for (NSInteger i = 0; i < self.menuItems.count-1; i++) {
        UIView *itemSeparator = [[UIView alloc] init];
        itemSeparator.backgroundColor = self.itemSeparatorColor?self.itemSeparatorColor:[UIColor lightGrayColor];
        
        [self addSubview:itemSeparator];
        [self.itemSeparators addObject:itemSeparator];
    }
    [self needsUpdateConstraints];
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        _tableView.tintColor = self.selectedColor;
        _tableView.rowHeight = 44;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerClass:[GinPullDownMenuCell class] forCellReuseIdentifier:NSStringFromClass([GinPullDownMenuCell class])];
    }
    return _tableView;
}

- (UIControl *)backgroundControl
{
    if (!_backgroundControl) {
        _backgroundControl = [[UIControl alloc] init];
        _backgroundControl.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        [_backgroundControl addTarget:self action:@selector(backgroundControlAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backgroundControl;
}

- (void)backgroundControlAction:(id)sender
{
    [self showMenuList:NO];
}

- (void)setCategoryTitles:(NSArray *)categoryTitles
{
    _categoryTitles = categoryTitles;
    self.categorySeletedIndex = [NSMutableArray array];
    self.menuCellDataList = [NSMutableArray array];
    for (NSInteger i = 0; i < self.categoryTitles.count; i++) {
        [self.categorySeletedIndex addObject:@(0)];
        [self.menuCellDataList addObject:@[]];
    }
    
    [self createViews];
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
    _currentIndex = currentIndex;
    if (currentIndex == self.selectedIndex) {
        [self showMenuList:NO];
    } else {
        self.selectedIndex = currentIndex;
        [self showMenuList:YES];
    }
}

- (void)showMenuList:(BOOL)selected
{
    if (selected) {
        [self.menuItems enumerateObjectsUsingBlock:^(GinPullDownMenuItem *item, NSUInteger idx, BOOL *stop) {
            if (idx == self.selectedIndex) {
                if (self.animateMenuItemSelected) {
                    [item animateTitleLabel:YES];
                }
                [item animateIndicator:YES completedBlock:^{}];
            } else {
                if (self.animateMenuItemSelected) {
                    [item animateTitleLabel:NO];
                }
                [item animateIndicator:NO completedBlock:^{}];
            }
        }];
        [self animateBackgroundControl:YES completedBlock:^{}];
        
        if (self.tableView.superview) {
            [self animateTableView:NO completedBlock:^{
                [self animateTableView:YES completedBlock:^{}];
            }];
        } else {
            [self animateTableView:YES completedBlock:^{}];
        }
    } else {
        GinPullDownMenuItem *item = self.menuItems[self.selectedIndex];
        [item animateTitleLabel:NO];
        [item animateIndicator:NO completedBlock:^{}];
        [self animateBackgroundControl:NO completedBlock:^{}];
        [self animateTableView:NO completedBlock:^{}];
        self.selectedIndex = -1;
    }
}

- (void)animateBackgroundControl:(BOOL)selected completedBlock:(void(^)())completedBlock
{
    if (selected) {
        
        [self.superview addSubview:self.backgroundControl];
        
        [self.backgroundControl mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom);
            make.left.equalTo(self.backgroundControl.superview);
            make.right.equalTo(self.backgroundControl.superview);
            make.bottom.equalTo(self.backgroundControl.superview);
        }];
        
        [self.backgroundControl.superview layoutIfNeeded];
        
        [UIView animateWithDuration:0.2 animations:^{
            self.backgroundControl.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
            [self.backgroundControl.superview layoutIfNeeded];
        }];
        
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.backgroundControl.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
            [self.backgroundControl.superview layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self.backgroundControl removeFromSuperview];
        }];
    }
    
    if (completedBlock) {
        completedBlock();
    }
}

- (void)animateTableView:(BOOL)selected completedBlock:(void(^)())completedBlock
{
    if (selected) {
        [self.tableView reloadData];
        [self.superview addSubview:self.tableView];
        
        CGFloat tableViewHeight = ([self.tableView numberOfRowsInSection:0] > 5) ? (5 * self.tableView.rowHeight) : ([self.tableView numberOfRowsInSection:0] * self.tableView.rowHeight);
        
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_bottom);
            make.left.equalTo(self);
            make.right.equalTo(self);
            make.height.offset(tableViewHeight);
        }];
        [self.tableView.superview layoutIfNeeded];
        
        [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.offset(0);
        }];
        
        [self.tableView.superview layoutIfNeeded];
        
        [UIView animateWithDuration:0.2 animations:^{
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(tableViewHeight);
            }];
            
            [self.tableView.superview layoutIfNeeded];
        } completion:^(BOOL finished) {
            if (completedBlock) {
                completedBlock();
            }}];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.offset(0);
            }];
            [self.tableView.superview layoutIfNeeded];
        } completion:^(BOOL finished) {
            [self.tableView removeFromSuperview];
            if (completedBlock) {
                completedBlock();
            }
        }];
    }
}


#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.categorySeletedIndex[self.selectedIndex] = @(indexPath.row);
    
    GinPullDownMenuItem *item = self.menuItems[self.selectedIndex];
    
    item.titleLabel.attributedText = self.menuCellDataList[self.selectedIndex][indexPath.row];
    [item setNeedsLayout];
    
    [self showMenuList:NO];
    
    if (self.categorySelectedIndexBlock) {
        self.categorySelectedIndexBlock(self.categorySeletedIndex);
    }
}

#pragma mark tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.menuCellDataList[self.selectedIndex] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GinPullDownMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GinPullDownMenuCell class])];
    
    cell.textLabel.attributedText = self.menuCellDataList[self.selectedIndex][indexPath.row];
    
    NSInteger selectedIndex = ((NSNumber *)self.categorySeletedIndex[self.selectedIndex]).integerValue;
    if (selectedIndex == indexPath.row) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}





@end
