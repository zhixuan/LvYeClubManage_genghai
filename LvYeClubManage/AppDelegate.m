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

extern CFAbsoluteTime startTime;
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    ////验证信息测试操作
    
    ///提交g个人更改操作你饿哦让。
    double launchTime = (CFAbsoluteTimeGetCurrent() - startTime);
    NSLog(@"launchTime is %lf ----- startTime is %f",launchTime,startTime);
//    int x=3;
//    int y= 10;
//    x=y^0;
//    NSLog(@"x is  %i, y is %i",x,y);
//
    
    
//    NSString *str1=@"zhixuan";
//    NSString *str2=str1;
//    NSLog(@"str1 is %@ str1P is %p  str2 is %@  ,str2P=%p",str1,str1,str2,str2);
//    str2=@"newxuanxuan";
//    NSLog(@"str1 is %@ str1P is %p  str2 is %@  ,str2P=%p",str1,str1,str2,str2);
//
//    NSLog(@"%ld",[@"67WTW1DO9H97OEQW670B14728AD9902AECBA32E22FA4F6BD3VXXW4QRSF07VDA4" length])
//#if ZLG_DEBUG
//    printf("zhangliguangTEST");
//#endif
//
//#if ZLG_RELEASE
//    printf("zhangliguang_Release");
//#endif
    
    NSString *lowStr = [@"DYLD_PRINT_STATISTICS" lowercaseString];
    NSLog(@"lowStr is %@",lowStr);

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
        [viewController settingNavTitle:@"登录" color:KButtonStateNormalColor];
        LvyeBaseNavigationController *navController = [[LvyeBaseNavigationController alloc]initWithRootViewController:viewController];
        [self.window setRootViewController:navController];
        
        viewController.block = ^(WebAPIResponseCode code) {
            LvyeBaseTabBarController *tabBarController = [[LvyeBaseTabBarController alloc]init];
            tabBarController.selectedIndex = 0;
            [self.window setRootViewController:tabBarController];
        };
    }
    
    
    
    /*
    
    NSMutableString * userName = [[NSMutableString alloc]initWithString:@"JSON"];
    [userName appendString:@"_JSON"];
    BOOL isStr = [userName isMemberOfClass:[NSMutableString class]];
    
    
    
    
    NSString  *strA = [[NSString alloc]initWithFormat:@"%@",@"ABC"];
    
    NSString  *strB = [strA mutableCopy];
    
    NSLog(@"strA is %@ %@   \n strB is %@ and strB is %@",strA,[strA class],strB,[strB class]  );
     
     
     */
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
    
    if (@available(iOS 13.0, *)) {
        
        if (![deviceToken isKindOfClass:[NSData class]]) {
            //记录获取token失败的描述
            return;
        }
        const unsigned *tokenBytes = (const unsigned *)[deviceToken bytes];
        NSString *strToken = [NSString stringWithFormat:@"%08x%08x%08x%08x%08x%08x%08x%08x",
                              ntohl(tokenBytes[0]), ntohl(tokenBytes[1]), ntohl(tokenBytes[2]),
                              ntohl(tokenBytes[3]), ntohl(tokenBytes[4]), ntohl(tokenBytes[5]),
                              ntohl(tokenBytes[6]), ntohl(tokenBytes[7])];
        NSLog(@"deviceToken1:%@", strToken);
//        NSDictionary *tokenDic = [deviceToken di ];
        
        
        
        
        
//        NSMutableString *deviceTokenString = [NSMutableString string];
//             const char *bytes = deviceToken.bytes;
//             NSInteger count = deviceToken.length;
//             for (int i = 0; i < count; i++) {
//                 [deviceTokenString appendFormat:@"%02x", bytes[i]&0x000000FF];
//             }
//
//        NSLog(@"deviceToken1:%@"[NSString string]);
        
        if (!IsStringEmptyOrNull(strToken)) {
            [KLvyeProductClubSettings setUserAPPDeviceTokenStr:strToken];
        }
        NSLog(@"%@",strToken);
    }else{
        NSString *tokenStr =[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                              stringByReplacingOccurrencesOfString: @">" withString: @""]
                             stringByReplacingOccurrencesOfString: @" " withString: @""];
        if (!IsStringEmptyOrNull(tokenStr)) {
            [KLvyeProductClubSettings setUserAPPDeviceTokenStr:tokenStr];
        }
        NSLog(@"%@",tokenStr);
    }
    
    
    
    
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


- (void)userNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification API_AVAILABLE(ios(10.0)){
    
    NSLog(@"%@%@",@"开启推送操作， ",@"操作处理");
}

@end
