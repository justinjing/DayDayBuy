//
//  LZXHelper.m
//  Connotation
//
//  Created by LZXuan on 14-12-20.
//  Copyright (c) 2014年 LZXuan. All rights reserved.
//

#import "MyHelper.h"
#import "NSString+Hashing.h"

@implementation MyHelper
// 获取文件在沙盒Library/Caches/ 目录下的路径
+ (NSString *)getFullPathWithFile:(NSString *)urlName {
    
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *myCacheDirectory = [docPath stringByAppendingPathComponent:@"MyCaches"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:myCacheDirectory]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:myCacheDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    // 用md5进行加密
    NSString * newName = [urlName MD5Hash];
    return [myCacheDirectory stringByAppendingPathComponent:newName];
}

// 获取时间差字符串,用于cell显示pubdate
+ (NSString *)stringFromNowToDate:(NSString *)dateString {
    NSDateFormatter * dm = [[NSDateFormatter alloc] init];
    [dm setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate * newdate = [dm dateFromString:dateString];
    long subtraction = (long)[[NSDate date] timeIntervalSince1970] - [newdate timeIntervalSince1970];
    NSString *timeString = @"";
    if (subtraction/3600<1) {
        timeString = [NSString stringWithFormat:@"%ld", subtraction/60];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    } else if (subtraction/3600>1&&subtraction/86400<1) {
        timeString = [NSString stringWithFormat:@"%ld", subtraction/3600];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    } else if (subtraction/86400>1) {
        timeString = [NSString stringWithFormat:@"%ld", subtraction/86400];
        timeString=[NSString stringWithFormat:@"%@天前", timeString];
    } else {
        timeString = dateString;
    }
    return timeString;
}


// 检测缓存文件 是否超时
+ (BOOL)isTimeOutWithFile:(NSString *)filePath timeOut:(double)timeOut {

    NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
    NSDate *lastModfyDate = fileDict.fileModificationDate;
    NSTimeInterval subtraction = [[NSDate date] timeIntervalSinceDate:lastModfyDate];
    return subtraction > timeOut ? YES : NO;
}

@end


