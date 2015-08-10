//
//  AddressSearchResultViewController.m
//  shuangdaojia_customer
//
//  Created by JunhuaShao on 15/7/17.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import <Masonry.h>
#import <BMapKit.h>

#import "GinhoorFramework.h"
#import "AddressSearchResultViewController.h"
#import "UIViewController+GinBaseTableView.h"

@interface AddressSearchResultViewController () <UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate, BMKSuggestionSearchDelegate>

@property (strong, nonatomic) UINavigationBar *navBar;
@property (strong, nonatomic, readwrite) UISearchBar *searchBar;

@property (strong, nonatomic) UIButton *cancelButton;

@property (strong, nonatomic) BMKSuggestionSearch *searcher;
@property (strong, nonatomic) BMKSuggestionResult *result;
@end

@implementation AddressSearchResultViewController

- (void)dealloc
{
    self.searcher.delegate = nil;
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
    self.hidesBottomBarWhenPushed = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.navBar];
    [self.view addSubview:self.tableView];
    
    [self.tableView config:^(UITableView *tableView) {
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        tableView.separatorColor = [UIColor colorWithHex:0xf1f1f1];
        
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }];
    
    [self.view updateConstraintsIfNeeded];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.searchBar becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.searchBar resignFirstResponder];
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(64);
        make.left.offset(0);
        make.right.offset(0);
        make.bottom.offset(0);
    }];
}

- (UINavigationBar *)navBar
{
    if (!_navBar) {
        _navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
        
        _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelButton.frame = CGRectMake(SCREEN_WIDTH-60-5, 20, 60, 44);
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        
        [_cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
        
        [_navBar addSubview:self.searchBar];
        [_navBar addSubview:self.cancelButton];
        
    }
    return _navBar;
}

- (UISearchBar *)searchBar
{
    if (!_searcher) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 20, SCREEN_WIDTH-10-60-5, 44)];
        _searchBar.placeholder = @"输入地点";
        _searchBar.backgroundImage = [UIImage imageByColor:[UIColor clearColor] size:CGSizeMake(1, 1)];
        _searchBar.delegate = self;
        _searchBar.keyboardType = UIKeyboardTypeDefault;
        _searchBar.returnKeyType = UIReturnKeyDone;
    }
    return _searchBar;
}

- (void)cancel:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:NO completion:^{
        }];
    });
}

- (BMKSuggestionSearch *)searcher
{
    if (!_searcher) {
        //初始化检索对象
        _searcher =[[BMKSuggestionSearch alloc]init];
        _searcher.delegate = self;
    }
    return _searcher;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cellDataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.cellDataList[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didAddressSelectedBlock) {
        self.didAddressSelectedBlock(ComboString(@"%@%@%@", self.result.cityList[indexPath.row],self.result.districtList[indexPath.row],self.cellDataList[indexPath.row]),self.result.cityList[indexPath.row],self.result.districtList[indexPath.row],self.cellDataList[indexPath.row]);
        [self cancel:tableView];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}

#pragma mark- SearchBar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (self.searchBar.text.length == 0) {
        [UIAlertView alertView:@"提示" message:@"请输入地址" cancelTitle:@"确认" cancelBlock:^{
        }];
        return;
    }
    
    if (self.didAddressSelectedBlock) {
        self.didAddressSelectedBlock(searchBar.text,nil,nil,nil);
        [self cancel:searchBar];
    }
}


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    BMKSuggestionSearchOption *option = [[BMKSuggestionSearchOption alloc] init];
    
    option.cityname = self.currentCityName;
    
    option.keyword = searchText;
    
    BOOL flag = [self.searcher suggestionSearch:option];
    
    if(flag) {
        NSLog(@"建议检索发送成功");
    } else {
        NSLog(@"建议检索发送失败");
    }
}


#pragma mark- BMKSuggestionSearch Delegate

- (void)onGetSuggestionResult:(BMKSuggestionSearch*)searcher result:(BMKSuggestionResult*)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        
    } else {
        NSLog(@"抱歉，未找到结果");
    }
    
    self.result = result;
    
    [self GinSetupTableDataBlock](result.keyList);
    [self.tableView reloadData];
}



@end
