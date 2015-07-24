//
//  DDBCustomCell.m
//  DayDayBuy
//
//  Created by 王晨晓 on 15/7/1.
//  Copyright (c) 2015年 chinsyo. All rights reserved.
//

#import "DDBCustomCell.h"
#import "UIImageView+WebCache.h"
@interface DDBCustomCell ()
@property (weak, nonatomic) IBOutlet UIImageView *thumbImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mallLabel;
@property (weak, nonatomic) IBOutlet UILabel *pubtimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromsiteLabel;
@end

@implementation DDBCustomCell
- (void)awakeFromNib {
    self.mallLabel.textColor = kCustomGreen;
    self.pubtimeLabel.textColor = kFontColor;
    self.fromsiteLabel.textColor = kFontColor;
}

- (void)showDataWithItem:(DDBGoodsItem *)item {
    [self.thumbImage sd_setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:[UIImage imageNamed:@"default_thumb"]];
    self.titleLabel.text = item.title;
    self.mallLabel.text = item.mall;
    self.fromsiteLabel.text = item.fromsite;
    self.pubtimeLabel.text = [MyHelper stringFromNowToDate:item.pubtime];
}

@end
