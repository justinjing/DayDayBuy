//
//  DDBBaseViewController.h
//  DayDayBuy
//
//  Created by 王晨晓 on 15/6/30.
//  Copyright (c) 2015年 chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@interface DDBBaseViewController : UITableViewController
{
    AFHTTPRequestOperationManager *_manager;
}
@property (nonatomic) NSInteger currentPage;
@property (nonatomic, copy) NSString *requestUrl;
@property (nonatomic, strong) NSMutableArray *dataArray;
- (void)firstDownload;
- (void)addTaskWithUrl:(NSString *)url isRefresh:(BOOL)isRefresh;
- (void)checkReachabilityStatus;
- (void)createRefreshView;
- (void)setBarButtonWithImage:(NSString *)image target:(id)target action:(SEL)action isLeft:(BOOL)isLeft;
@end
