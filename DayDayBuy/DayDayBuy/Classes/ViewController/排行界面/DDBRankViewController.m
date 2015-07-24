//
//  DDBRankViewController.m
//  DayDayBuy
//
//  Created by 王晨晓 on 15/6/30.
//  Copyright (c) 2015年 chinsyo. All rights reserved.
//

#import "DDBRankViewController.h"
#import "DDBGoodsItem.h"
@interface DDBRankViewController ()

@end

@implementation DDBRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Rank", nil);
    [self.navigationItem setTitleViewWitnTitle:self.title];
    [self firstDownload];
    [self createRefreshView];
}

- (NSString *)requestUrl {
    return kRankUrl;
}

@end
