//
//  DDBGoodsItem.m
//  DayDayBuy
//
//  Created by 王晨晓 on 15/7/1.
//  Copyright (c) 2015年 chinsyo. All rights reserved.
//

#import "DDBGoodsItem.h"
@implementation DDBGoodsItem
@synthesize id = _id;
- (NSString *)description {
    return [NSString stringWithFormat:@"%@ %@ %@", self.title, self.id, self.buyurl];
}
@end
