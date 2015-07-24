//
//  DDBHomeViewController.m
//  DayDayBuy
//
//  Created by 王晨晓 on 15/6/30.
//  Copyright (c) 2015年 chinsyo. All rights reserved.
//

#import "DDBHomeViewController.h"

@interface DDBHomeViewController ()

@end

@implementation DDBHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Home", nil);
    [self.navigationItem setTitleViewWitnTitle:self.title];
    [self firstDownload];
    [self createRefreshView];
}

- (NSString *)requestUrl {
    return kHomeUrl;
}

@end
