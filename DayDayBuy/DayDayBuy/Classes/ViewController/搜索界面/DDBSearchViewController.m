//
//  DDBSearchViewController.m
//  DayDayBuy
//
//  Created by 王晨晓 on 15/7/1.
//  Copyright (c) 2015年 chinsyo. All rights reserved.
//

#import "DDBSearchViewController.h"
#import "DDBGoodsItem.h"
@interface DDBSearchViewController () <UISearchBarDelegate>
{
    UISearchBar *_searchBar;
}
@end

@implementation DDBSearchViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Search", nil);
    self.navigationItem.leftBarButtonItem = nil;
    [self.navigationItem setTitleViewWitnTitle:self.title];

    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 30)];
    _searchBar.delegate = self;
    _searchBar.placeholder = NSLocalizedString(@"DayDayBuy", nil);
    _searchBar.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = _searchBar;
}

- (NSString *)requestUrl {
    return [[NSString stringWithFormat:@"%@%@", kSearchUrl, _searchBar.text] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

#pragma mark - UISearcharBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self addTaskWithUrl:self.requestUrl isRefresh:YES];
    [self.tableView reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:NO animated:YES];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    searchBar.text = @"";
    [searchBar resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_searchBar resignFirstResponder];
}

@end
