//
//  UINavigationItem+TitleView.m
//  DayDayBuy
//
//  Created by 王晨晓 on 15/7/2.
//  Copyright (c) 2015年 chinsyo. All rights reserved.
//

#import "UINavigationItem+TitleView.h"

@implementation UINavigationItem (TitleView)
- (void)setTitleViewWitnTitle:(NSString *)title {
    UILabel *headlinelabel = [UILabel new];
    headlinelabel.font = [UIFont boldSystemFontOfSize:22.0];
    headlinelabel.textAlignment = NSTextAlignmentCenter;
    headlinelabel.textColor = kFontColor;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:kCustomGreen
                             range:NSMakeRange(0, 1)];

    headlinelabel.attributedText = attributedString;
    [headlinelabel sizeToFit];
    [self setTitleView:headlinelabel];
}
@end
