//
//  LoginViewController.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/17.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseViewController.h"


typedef void (^LoginSuccessfullyBlock) (WebAPIResponseCode code);
/**
 用户登录操作处理界面
 */
@interface LoginViewController : LvyeBaseViewController

/*!
 * @property
 * @brief 用户登录操作 Block
 */
@property (nonatomic , copy)      LoginSuccessfullyBlock        block;

@end
