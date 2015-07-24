//
//  DDBDetailViewController.m
//  DayDayBuy
//
//  Created by 王晨晓 on 15/7/1.
//  Copyright (c) 2015年 chinsyo. All rights reserved.
//

#import "DDBDetailViewController.h"
#import "DDBMallViewController.h"
#import "MBProgressHUD.h"
@interface DDBDetailViewController ()
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIToolbar *toolBar;
@end

@implementation DDBDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.title = self.item.title;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    UIButton *barButton= [UIButton buttonWithType:UIButtonTypeSystem];
    BOOL isExist = [[DBManager sharedManager] isExistItemWithId:self.item.id];
    barButton.selected = isExist;
    [barButton setTitle:NSLocalizedString(@"Mark", nil) forState:UIControlStateNormal];
    [barButton setTitle:NSLocalizedString(@"Cancel", nil) forState:UIControlStateSelected];
    barButton.frame = CGRectMake(0, 0, 50, 30);
    [barButton addTarget:self action:@selector(bookmarkItemClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    self.requestUrl = [NSString stringWithFormat:@"%@%@", kDetailUrl, self.item.id];
    [self loadWebView];
    [self createBuyButton];
}


- (void)loadWebView {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.requestUrl]];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.scalesPageToFit = YES;
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
}

- (void)createBuyButton {

    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 0, kScreenSize.width, 49);
    
    BOOL iftobuy = self.item.iftobuy.boolValue;
    button.enabled = iftobuy;
    [button setTitle:iftobuy ? NSLocalizedString(@"Buy Now", nil) : @"" forState:UIControlStateNormal];
    
    button.titleLabel.font = [UIFont systemFontOfSize:22.0];
    [button addTarget:self action:@selector(buyButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, kScreenSize.height-49, kScreenSize.width, 49)];
    self.toolBar.items = @[item];
    [self.view addSubview:self.toolBar];
}

- (void)buyButtonClick {
    DDBMallViewController *mallController = [[DDBMallViewController alloc] init];
    mallController.requestUrl = self.item.buyurl;
    mallController.item = self.item;
    [self.navigationController pushViewController:mallController animated:YES];    
}

- (void)bookmarkItemClick:(UIButton *)barButton {
    MBProgressHUD *hud =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeText;
    if (barButton.isSelected) {
        [[DBManager sharedManager] deleteItemWithId:self.item.id];
        hud.labelText = NSLocalizedString(@"Cancel Bookmark", nil);
    } else {
        [[DBManager sharedManager] insertGoods:self.item];
        hud.labelText = NSLocalizedString(@"Bookmark Success", nil);
    }
    [hud hide:YES afterDelay:0.6];
    barButton.selected =! barButton.isSelected;
}

@end
