//
//  AppDelegate+VendorsProxy.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/9.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (VendorsProxy)

#pragma mark -
#pragma mark -  友盟统计信息初始化
- (void)setupUmengSDKInfor;


/**
 GrowingIO_SDK_信息初始化
 */
- (void)setupGrowingIOSDKInfo;
@end
