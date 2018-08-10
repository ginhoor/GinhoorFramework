//
//  EmptyTableViewController.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/6/11.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "EmptyTableViewController.h"
#import "UIViewController+GinBaseTableView.h"
#import "UIScrollView+EmptyDataSet.h"
#import "UIColor+Hex.h"

@interface EmptyTableViewController () <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation EmptyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView config:^(UITableView *tableView) {
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.emptyDataSetDelegate = self;
        tableView.emptyDataSetSource = self;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        tableView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds));
    }];
    
    self.cellDataList = @[];
    
    [self.tableView reloadData];
    
    [self.view addSubview:self.tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = self.cellDataList[indexPath.row];
    return cell;
}



#pragma mark - DZNEmptyDataSetSource Methods

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"No Application Found";
    return [[NSAttributedString alloc] initWithString:text attributes:nil];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = [NSString stringWithFormat:@"There are no empty dataset examples for \"%@\".", @"Ginhoor"];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:nil];
    
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:17.0] range:[attributedString.string rangeOfString:@"Ginhoor"]];
    
    return attributedString;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIImage imageNamed:@"test"];
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
{
    NSString *text = @"Search on the App Store";
    UIFont *font = [UIFont systemFontOfSize:16.0];
    
    UIColor *textColor = [UIColor colorWithHex:state == UIControlStateNormal ? 0x007aff : 0xc6def9];
    
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor whiteColor];
}

- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView
{
    return CGPointMake(0, -64.0);
}


#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldShow:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
{
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}

//- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView
//{
//    NSLog(@"%s",__FUNCTION__);
//}
//
//- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView
//{
//    UISearchBar *searchBar = self.searchDisplayController.searchBar;
//    
//    NSURL *URL = [NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.com/apps/%@", searchBar.text]];
//    
//    if ([[UIApplication sharedApplication] canOpenURL:URL]) {
//        [[UIApplication sharedApplication] openURL:URL];
//    }
//}

@end
