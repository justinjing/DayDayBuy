//
//  AppDelegate.m
//  DayDayBuy
//
//  Created by 王晨晓 on 15/6/30.
//  Copyright (c) 2015年 chinsyo. All rights reserved.
//

#import "DDBAppDelegate.h"
#import "DDBHomeViewController.h"
#import "DDBAbroadViewController.h"
#import "DDBRankViewController.h"
#import "DDBSettingViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
@interface DDBAppDelegate ()

@end

@implementation DDBAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // 设置友盟分享
    [UMSocialData setAppKey:@"559492be67e58eb659002a3d"];
    /**
        设置tabController为根视图控制器
     */
    DDBHomeViewController *homeController = [[DDBHomeViewController alloc] init];
    UINavigationController *homeNavController = [[UINavigationController alloc] initWithRootViewController:homeController];
    homeNavController.tabBarItem = [DDBAppDelegate setTabViewWithImage:@"tabicon_home" title:NSLocalizedString(@"Home", nil)];
    
    DDBAbroadViewController *abroadController = [[DDBAbroadViewController alloc] init];
    UINavigationController *abroadNavController = [[UINavigationController alloc] initWithRootViewController:abroadController];
    abroadNavController.tabBarItem = [DDBAppDelegate setTabViewWithImage:@"tabicon_abroad" title:NSLocalizedString(@"Abroad", nil)];
    
    DDBRankViewController *rankController = [[DDBRankViewController alloc] init];
    UINavigationController *rankNavController = [[UINavigationController alloc] initWithRootViewController:rankController];
    rankNavController.tabBarItem = [DDBAppDelegate setTabViewWithImage:@"tabicon_rank" title:NSLocalizedString(@"Rank", nil)];
    
    DDBSettingViewController *settingController = [[DDBSettingViewController alloc] init];
    UINavigationController *settingNavController = [[UINavigationController alloc] initWithRootViewController:settingController];
    settingController.tabBarItem = [DDBAppDelegate setTabViewWithImage:@"tabicon_setting" title:NSLocalizedString(@"Setting", nil)];
    
    
    UITabBarController *tabController = [[UITabBarController alloc] init];
    tabController.viewControllers = @[homeNavController, abroadNavController, rankNavController, settingNavController];
    [tabController.view setTintColor:kCustomGreen];
    self.window.rootViewController = tabController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

+ (UITabBarItem *)setTabViewWithImage:(NSString *)image title:(NSString *)title {
    return [[UITabBarItem alloc] initWithTitle:title image:[UIImage imageNamed:image] selectedImage:nil];
}

@end
