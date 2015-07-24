//
//  DDBBookmarkViewController.m
//  DayDayBuy
//
//  Created by 王晨晓 on 15/7/2.
//  Copyright (c) 2015年 chinsyo. All rights reserved.
//

#import "DDBBookmarkViewController.h"
#import "DDBDetailViewController.h"
#import "DDBGoodsItem.h"
@interface DDBBookmarkViewController ()
{
    NSMutableArray *_removeArray;
}
@end

@implementation DDBBookmarkViewController

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
    [self.dataArray removeAllObjects];
    [self.tableView reloadData];
    [self setUpNavigationBar];
    
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    _removeArray = [[NSMutableArray alloc] init];
    NSArray *array = [NSMutableArray arrayWithArray:[[DBManager sharedManager] readItemsFromCollection]];
    for (int i = 0; i < array.count; i++) {
        DDBGoodsItem *item = array[i];
        [self.dataArray addObject:item];
    }
    [self.tableView reloadData];
}

- (void)setUpNavigationBar {
    self.title = NSLocalizedString(@"Bookmark", nil);
    [self.navigationItem setTitleViewWitnTitle:self.title];
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeSystem];
    editButton.frame = CGRectMake(0, 0, 45, 35);
    [editButton setTitle:NSLocalizedString(@"Edit", nil) forState:UIControlStateNormal];
    [editButton setTitle:NSLocalizedString(@"Delete", nil) forState:UIControlStateSelected];
    [editButton addTarget:self action:@selector(editButton:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:editButton];
    self.navigationItem.rightBarButtonItem = item;
    self.navigationItem.leftBarButtonItem = nil;
}

- (NSString *)requestUrl {
    return kIndexUrl;
}

#pragma mark - 编辑收藏夹
- (void)editButton:(UIButton *)button {
    if (button.isSelected) {
        for (DDBGoodsItem *item in _removeArray) {
            [self.dataArray removeObject:item];
            [[DBManager sharedManager] deleteItemWithId:item.id];
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            [self.tableView reloadData];
        }];
    }
    
    button.selected = !button.selected;
    [self.tableView setEditing:button.selected animated:YES];
}

// cell的编辑风格
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

// 加选中的对象加入到将要删除的数组里面去（removeArray用以存储将要被删除的学生对象）
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView.isEditing) { // 如果表格处于编辑状态
        DDBGoodsItem *item = self.dataArray[indexPath.row];
        [_removeArray addObject:item];
    } else {
        DDBGoodsItem *item = self.dataArray[indexPath.row];
        DDBDetailViewController *detailController = [[DDBDetailViewController alloc] init];
        detailController.item = item;
        [self.navigationController pushViewController:detailController animated:YES];
    }
    
}

// 把removeArray中对应的对象移除去，表明当前对象不准备删除了
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.tableView.isEditing) {
        DDBGoodsItem *item = self.dataArray[indexPath.row];
        [_removeArray removeObject:item];
    }
}


@end
