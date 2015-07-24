//
//  kUrl.h
//  DayDayBuy
//
//  Created by 王晨晓 on 15/6/30.
//  Copyright (c) 2015年 chinsyo. All rights reserved.
//

#ifndef DayDayBuy_kUrl_h
#define DayDayBuy_kUrl_h

#define kIndexUrl @"http://guangdiu.com/api/"

#define kHomeUrl [NSString stringWithFormat:@"%@%@", kIndexUrl, @"getlist.php?count=30"]

#define kLoadUrl [NSString stringWithFormat:@"%@%@", kIndexUrl, @"getnewitemcount.php?cnmaxid=%@&usmaxid=%@"]

#define kAbroadUrl [NSString stringWithFormat:@"%@%@", kIndexUrl, @"getlist.php?country=us&count=30"]

#define kRankUrl [NSString stringWithFormat:@"%@%@", kIndexUrl, @"getranklist.php?"]

#define kSearchUrl [NSString stringWithFormat:@"%@%@", kIndexUrl, @"getresult.php?count=30&q="]

#define kDetailUrl [NSString stringWithFormat:@"%@%@", kIndexUrl, @"showdetail.php?id="]
#endif
