//
//  AppDelegate.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/8.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+VendorsProxy.h"
#import "AppDelegate+UmengPush.h"
#import "AppDelegate+ServiceInfo.h"

#import "LoginViewController.h"
#import "LvyeBaseNavigationController.h"
#import "LvyeBaseTabBarController.h"

///系统的
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    
    

    ///初始化友盟统计
    [self setupUmengSDKInfor];
//    ///初始化友盟推送
    [self didFinishLaunchingWithOptions:launchOptions id:self];

    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    

    if(KLvyeProductClubSettings.isClubUserLogin){
        LvyeBaseTabBarController *tabBarController = [[LvyeBaseTabBarController alloc]init];
        tabBarController.selectedIndex = 0;
        [self.window setRootViewController:tabBarController];
    }else{
        LoginViewController * viewController = [[LoginViewController alloc] init];
        [viewController settingNavTitle:@"登录" color:[UIColor redColor]];
        LvyeBaseNavigationController *navController = [[LvyeBaseNavigationController alloc]initWithRootViewController:viewController];
        [self.window setRootViewController:navController];
        
        viewController.block = ^(WebAPIResponseCode code) {
            LvyeBaseTabBarController *tabBarController = [[LvyeBaseTabBarController alloc]init];
            tabBarController.selectedIndex = 0;
            [self.window setRootViewController:tabBarController];
        };
    }
    
    [self clubUserAutoLogin];

    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



/// TODO: 获取到推送得到的 TOKEN 信息
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
   
    
    NSLog(@"\n\n打印 deviceToken \n\n");
    
    NSString *tokenStr =[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                          stringByReplacingOccurrencesOfString: @">" withString: @""]
                         stringByReplacingOccurrencesOfString: @" " withString: @""];
    if (!IsStringEmptyOrNull(tokenStr)) {
        [KLvyeProductClubSettings setUserAPPDeviceTokenStr:tokenStr];
    }
    NSLog(@"%@",tokenStr);
}

/// TODO： 获取推送信息内容
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler{
    [self application:application umengDidReceiveRemoteNotification:userInfo fetchCompletionHandler:completionHandler];
}

/// TODO:推送通知异常处理
#ifdef __IPHONE_8_0
- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}
#endif
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0)){
    if (@available(iOS 10.0, *)) {
        [self userNotificationCenter:center willPresentNotification:notification withCompletionHandler:completionHandler];
    } else {
        // Fallback on earlier versions
    }
}




@end
