//
//  DDBAbroadViewController.m
//  DayDayBuy
//
//  Created by 王晨晓 on 15/6/30.
//  Copyright (c) 2015年 chinsyo. All rights reserved.
//

#import "DDBAbroadViewController.h"

@interface DDBAbroadViewController ()

@end

@implementation DDBAbroadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Abroad", nil);
    [self.navigationItem setTitleViewWitnTitle:self.title];
    [self firstDownload];
    [self createRefreshView];
}

- (NSString *)requestUrl {
    return kAbroadUrl;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
