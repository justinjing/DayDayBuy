//
//  DDBDetailViewController.h
//  DayDayBuy
//
//  Created by 王晨晓 on 15/7/1.
//  Copyright (c) 2015年 chinsyo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDBGoodsItem.h"
@interface DDBDetailViewController : UIViewController
@property (nonatomic, strong) DDBGoodsItem *item;
@property (nonatomic, copy) NSString *requestUrl;
@end
