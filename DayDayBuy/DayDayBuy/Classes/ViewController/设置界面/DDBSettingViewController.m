//
//  DDBSettingViewController.m
//  DayDayBuy
//
//  Created by 王晨晓 on 15/7/1.
//  Copyright (c) 2015年 chinsyo. All rights reserved.
//

#import "DDBSettingViewController.h"
#import "DDBBookmarkViewController.h"
#import "SDImageCache.h"
@interface DDBSettingViewController () <UITableViewDataSource, UITableViewDelegate>
{
    NSArray *_dataArray;
}
@end

@implementation DDBSettingViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
//    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
//    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Setting", nil);
    [self.navigationItem setTitleViewWitnTitle:self.title];
    self.view.tintColor = kCustomGreen;
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    
    [self.navigationItem setTitleViewWitnTitle:self.title];
    
//    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissSettingController)];
//    self.navigationItem.leftBarButtonItem = leftItem;
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    NSArray *section1 = @[NSLocalizedString(@"Official Weibo", nil), NSLocalizedString(@"Official Site", nil)/**, NSLocalizedString(@"Comments It", nil)*/];
    NSArray *section2 = @[NSLocalizedString(@"Clean Cache", nil), NSLocalizedString(@"My Bookmark", nil)];
    _dataArray = @[section1, section2];
}

- (void)dismissSettingController {
    [self.tabBarController setSelectedIndex:0];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = _dataArray[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                // 官方微博
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://weibo.com/u/3304801113"]];
                break;
            }
                
            case 1: {
                // 官方网站
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.guangdiu.com/"]];
                break;
            }
        //TODO:  更新时增加跳转到appstore评价页面
            /**
            case 2: {
                // itunes链接
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/guang-diu-shi-shi-tong-bu/id1002856207?mt=8"]];
                break;
            }
             */
            default:
                break;
        }
    } else {
        switch (indexPath.row) {
            case 0: {
                // 清除缓存
                NSString *title = NSLocalizedString(@"Clean Cache File", nil);
                UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                [actionSheet addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Clean", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
                    [[SDImageCache sharedImageCache] clearMemory];
                    [[SDImageCache sharedImageCache] clearDisk];
                }]];
                [actionSheet addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil) style:UIAlertActionStyleCancel handler:nil]];
                [self presentViewController:actionSheet animated:YES completion:nil];
                break;
            }
                
            case 1: {
                // 我的收藏
                DDBBookmarkViewController *bookmarkController = [[DDBBookmarkViewController alloc] init];
                [self.navigationController pushViewController:bookmarkController animated:YES];
                break;
            }
                
            default:
                break;
        }
    }
}

@end
