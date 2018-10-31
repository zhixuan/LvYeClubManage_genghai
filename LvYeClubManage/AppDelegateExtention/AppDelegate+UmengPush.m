//
//  AppDelegate+UmengPush.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/9.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "AppDelegate+UmengPush.h"
#import <UMPush/UMessage.h>



@implementation AppDelegate (UmengPush)


- (void)didFinishLaunchingWithOptions:(NSDictionary *)launchOptions id:(id)selfId{
    
    
    UMessageRegisterEntity *entity = [[UMessageRegisterEntity alloc]init];
    //友盟自己的 type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    [entity setTypes:UMessageAuthorizationOptionBadge|UMessageAuthorizationOptionAlert];
    if (@available(iOS 10.0, *)) {
        [UNUserNotificationCenter currentNotificationCenter].delegate=selfId;
    } else {
        // Fallback on earlier versions
    }
    
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            
        }else
        {
        }
    }];
}


- (void)application:(UIApplication *)application umengDidReceiveRemoteNotification:(nonnull NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler{
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        [UMessage didReceiveRemoteNotification:userInfo];
        
        //    self.userInfo = userInfo;
        //    //定制自定的的弹出框
        //    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
        //    {
        //        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
        //                                                            message:@"Test On ApplicationStateActive"
        //                                                           delegate:self
        //                                                  cancelButtonTitle:@"确定"
        //                                                  otherButtonTitles:nil];
        //
        //        [alertView show];
        //
        //    }
        completionHandler(UIBackgroundFetchResultNewData);
    }
}

-(void)umengWillPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    
    NSDictionary * userInfo = notification.request.content.userInfo;
    
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            //应用处于前台时的远程推送接受
            //关闭U-Push自带的弹出框
            [UMessage setAutoAlert:NO];
            //必须加这句代码
            [UMessage didReceiveRemoteNotification:userInfo];
            
        }else{
            //应用处于前台时的本地推送接受
        }
        //当应用处于前台时提示设置，需要哪个可以设置哪一个
        completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    }
    

}
@end
