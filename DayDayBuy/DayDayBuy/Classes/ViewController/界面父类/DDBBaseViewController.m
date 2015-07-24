//
//  DDBBaseViewController.m
//  DayDayBuy
//
//  Created by 王晨晓 on 15/6/30.
//  Copyright (c) 2015年 chinsyo. All rights reserved.
//
#import "MBProgressHUD.h"
#import "DDBBaseViewController.h"
#import "DDBRankViewController.h"
#import "DDBSearchViewController.h"
#import "DDBDetailViewController.h"
#import "JHRefresh.h"
#import "DDBGoodsItem.h"
#import "DDBCustomCell.h"
#import "DBManager.h"
@interface DDBBaseViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic) BOOL isRefreshing;
// @property (nonatomic) BOOL isLoadMore;
// @property (nonatomic, copy) NSString *loadmoreUrl;
@end

@implementation DDBBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setBarButtonWithImage:@"search_icon" target:self action:@selector(leftClick:) isLeft:YES];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"DDBCustomCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
    [self firstDownload];
    
}

#pragma mark - NetworkTask
- (void)firstDownload {

    [self.dataArray removeAllObjects];
    [self addTaskWithUrl:self.requestUrl isRefresh:YES];
}

/**
- (NSString *)loadmoreUrl {
    NSString *url = @"";
    DDBGoodsItem *item = [self.dataArray firstObject];
    switch (self.categoryId) {
        case kHomeType: {
            url = [kLoadUrl stringByAppendingString:[NSString stringWithFormat:@"&markid=%@", item.id]];
            NSLog(@"%@", url);
            break;
        }
        case kAbroadType: {
            url = [kLoadUrl stringByAppendingString:[NSString stringWithFormat:@"&markid=%@", item.id]];
            break;
        }
        case kRankType: {
            url = [kLoadUrl stringByAppendingString:[NSString stringWithFormat:@"&markid=%@", item.id]];
            break;
        }
        default:
            break;
    }
    return url;
}
 */

- (void)addTaskWithUrl:(NSString *)url isRefresh:(BOOL)isRefresh {
    _manager = [AFHTTPRequestOperationManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_queue_create("com.chinsyo", 0), ^{
        [weakSelf checkReachabilityStatus];
    });
    [_manager GET:url parameters:nil success:^(AFHTTPRequestOperation * operation, id requestObject) {
        [weakSelf.dataArray removeAllObjects];
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:requestObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array = dict[@"data"];
        for (NSDictionary *itemDict in array) {
            DDBGoodsItem *goods = [[DDBGoodsItem alloc] init];
            [goods setValuesForKeysWithDictionary:itemDict];
            [self.dataArray addObject:goods];
        }
        
        [self.tableView reloadData];
        [self endRefreshing];
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    [hud hide:YES afterDelay:0.2];
}

- (void)checkReachabilityStatus {
    AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager managerForDomain:kIndexUrl];
    if (reachability.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Disconnect", nil) message:NSLocalizedString(@"Disconnect Detail", nil) preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Ignore", nil) style:UIAlertActionStyleDefault handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Check", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - AddRefreshView
- (void)createRefreshView {
    __weak typeof (self) weakSelf = self;
    [self.tableView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isRefreshing) {
            return ;
        }
        weakSelf.isRefreshing = YES;
        weakSelf.currentPage = 1;
        [weakSelf addTaskWithUrl:weakSelf.requestUrl isRefresh:YES];
    }];
    
    //TODO: 更新时增加上拉加载更多
    /**
    [self.tableView addRefreshFooterViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        if (weakSelf.isLoadMore) {
            return ;
        }
        weakSelf.isLoadMore = YES;
        weakSelf.currentPage += 1;
        [weakSelf addTaskWithUrl:weakSelf.loadmoreUrl isRefresh:YES];
    }];
     */
}

- (void)endRefreshing {
    if (self.isRefreshing) {
        self.isRefreshing = NO;
        [self.tableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }
    /**
    if (self.isLoadMore) {
        self.isLoadMore = NO;
        [self.tableView footerEndRefreshing];
    }
      */
}


#pragma mark - SetUpThrNavigationBar
- (void)setBarButtonWithImage:(NSString *)image target:(id)target action:(SEL)action isLeft:(BOOL)isLeft {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:image] style:UIBarButtonItemStyleDone target:target action:action];
    if (isLeft) {
        self.navigationItem.leftBarButtonItem = item;
    } else {
        self.navigationItem.rightBarButtonItem = item;
    }
}

- (void)leftClick:(UIBarButtonItem *)item {
    DDBSearchViewController *searchController = [[DDBSearchViewController alloc] init];
    [self.navigationController pushViewController:searchController animated:YES];
}

#pragma mark - LazyLoadDataArray
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}


#pragma mark - <UITableViewDatasource, UITableViewDelegate>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDBGoodsItem *item = self.dataArray[indexPath.row];
    DDBCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.backgroundColor = indexPath.row%2 ? kCustomGray : [UIColor whiteColor];
    [cell showDataWithItem:item];
    if ([self isMemberOfClass:[DDBRankViewController class]]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, 30, 30)];
        label.backgroundColor = kCustomGreen;
        label.clipsToBounds = YES;
        label.layer.cornerRadius = 15.0;
        label.font = [UIFont boldSystemFontOfSize:16.0];
        label.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
        label.textColor = kFontColor;
        label.textAlignment = NSTextAlignmentCenter;
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell addSubview:label];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDBGoodsItem *item = self.dataArray[indexPath.row];
    DDBDetailViewController *detailController = [[DDBDetailViewController alloc] init];
    detailController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    detailController.item = item;
    [self.navigationController pushViewController:detailController animated:YES];
}

@end
