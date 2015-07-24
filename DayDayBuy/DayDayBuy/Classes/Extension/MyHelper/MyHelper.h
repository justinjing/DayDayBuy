//
//  LZXHelper.h
//  Connotation
//
//  Created by LZXuan on 14-12-20.
//  Copyright (c) 2014年 LZXuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MyHelper : NSObject

+ (NSString *)getFullPathWithFile:(NSString *)urlName;
+ (NSString *)stringFromNowToDate:(NSString *)dateString;
+ (BOOL)isTimeOutWithFile:(NSString *)filePath timeOut:(double)timeOut;

@end





