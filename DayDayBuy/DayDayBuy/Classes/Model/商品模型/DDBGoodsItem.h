//
//  DDBGoodsItem.h
//  DayDayBuy
//
//  Created by 王晨晓 on 15/7/1.
//  Copyright (c) 2015年 chinsyo. All rights reserved.
//

#import "DDBBaseItem.h"

@interface DDBGoodsItem : DDBBaseItem
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *rank;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *pubtime;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *imgw;
@property (nonatomic, copy) NSString *imgh;
@property (nonatomic, copy) NSString *iftobuy;
@property (nonatomic, copy) NSString *buyurl;
@property (nonatomic, copy) NSString *fromsite;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *mall;
@property (nonatomic, copy) NSString *dealfeature;
@property (nonatomic, strong) NSMutableArray *cates;
@end
