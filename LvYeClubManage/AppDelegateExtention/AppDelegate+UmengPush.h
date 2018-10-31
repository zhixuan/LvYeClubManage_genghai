//
//  AppDelegate+UmengPush.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/9.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "AppDelegate.h"
///系统的
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate (UmengPush)



/**
 初始化友盟推送信息内容

 @param launchOptions 参数内容
 */
- (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions id:(id)selfId;

/**
 二次封装友盟内容，达到代码隔离效果

 @param application application
 @param userInfo userInfo
 @param completionHandler completionHandler
 */
- (void)application:(UIApplication *)application umengDidReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler;


-(void)umengWillPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0));
@end
