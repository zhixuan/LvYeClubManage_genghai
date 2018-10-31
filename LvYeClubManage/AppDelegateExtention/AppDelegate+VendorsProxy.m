//
//  AppDelegate+VendorsProxy.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/9.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "AppDelegate+VendorsProxy.h"
#import <UMCommon/UMConfigure.h>

#import <UMAnalytics/MobClick.h>

#import <SMS_SDK/SMSSDK.h>

@implementation AppDelegate (VendorsProxy)


- (void)setupUmengSDKInfor{
    
    
    
    
    /**
     
    Could not successfully update network info during initialization.
    使用友盟，会提示上面的内容，同时长时间使用也会提示 TIC Read Status [1:0x600000169000]: 1:57 内容；
     ***/
    [UMConfigure initWithAppkey:KKeyUmengAppId channel:@"APP_Store"];
    [UMConfigure setLogEnabled:YES];
    [MobClick setScenarioType:E_UM_DPLUS];
    NSLog(@"已经进入到这里了 KKeyUmengAppId is %@",KKeyUmengAppId );


    NSString  *umidString =  [UMConfigure umidString];
    NSLog(@"umidString is %@",umidString );
    
//    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:@"15718806560" zone:@"86" template:@"123456" result:^(NSError *error) {
//        if (!error) {
//            NSLog(@"发送成功");
//        }else{
//            NSLog(@"发送失败 %@",error.userInfo);
//        }
//    }];
//    
//    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:@"15718806560" zone:@"86" result:^(NSError *error) {
//        if (!error) {
//            NSLog(@"1发送成功");
//        }else{
//            NSLog(@"1发送失败 %@",error.userInfo);
//        }
//    }];
    
    
    
    
}


/**
  根据用户 ID，获取用户名字

 @param userId 用户 ID
 @return void
 */
- (NSString *)userPersonalNameFromUserPersonalInfoWithUserId:(NSString *)userId{
    
    
    return @"";
}


- (void)setupGrowingIOSDKInfo{
    
    
//    growing.bdd7c5d46daad669
    
//       [Growing startWithAccountId:@"ba8bb9e6b164b0dc"];
    
}
@end
