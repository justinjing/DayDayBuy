//
//  DDBMallViewController.m
//  DayDayBuy
//
//  Created by 王晨晓 on 15/7/1.
//  Copyright (c) 2015年 chinsyo. All rights reserved.
//

#import "DDBMallViewController.h"
#import "UMSocial.h"
#define kItunesUrl @"https://itunes.apple.com/cn/app/guang-diu-shi-shi-tong-bu/id1002856207?mt=8"
@interface DDBMallViewController () <UMSocialUIDelegate>
@property (nonatomic, strong) UIToolbar *toolBar;
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation DDBMallViewController

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
    // self.item = [[DDBGoodsItem alloc] init];
    self.title = NSLocalizedString(@"Buy Now", nil);
    self.navigationItem.rightBarButtonItem = nil;
    [self.navigationItem setTitleViewWitnTitle:self.title];
    
    [self setUpWebView];
    [self setUpToolBar];
}

- (void)setUpWebView {
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.scalesPageToFit = YES;
    NSString *string = [self.requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

- (void)setUpToolBar {
    UIBarButtonItem *reloadButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(reloadButtonClick)];
    UIBarButtonItem *actionButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(actionButtonClick)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(backButtonClick)];
    UIBarButtonItem *forwardButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(forwardButtonClick)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    self.toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, kScreenSize.height-49, kScreenSize.width, 49)];
    self.toolBar.items = @[reloadButton, space, actionButton, space, backButton, space, forwardButton];
    [self.view addSubview:self.toolBar];
}

- (void)reloadButtonClick {
    [self.webView reload];
}

- (void)actionButtonClick {
    NSString *shareString = [NSString stringWithFormat:@"我在最潮最酷的天天买发现了超级划算的大宝贝，还不快来下载 %@和我一起买买买！%@", kItunesUrl, self.requestUrl];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:nil
                                      shareText:shareString
                                     shareImage:[UIImage imageNamed:@"share.png"]
                                 shareToSnsNames:[NSArray arrayWithObjects:UMShareToSms,UMShareToSina/**,UMShareToWechatTimeline, UMShareToQzone, UMShareToWechatSession, UMShareToQQ*/, nil]
                                       delegate:self];

    
}

- (void)backButtonClick {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }
}

- (void)forwardButtonClick {
    if (self.webView.canGoForward) {
        [self.webView goForward];
    }
}

@end
