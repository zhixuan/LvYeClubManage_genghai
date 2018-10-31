//
//  LvyeProductSettings.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/23.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#define KLvyeProductClubSettings        [LvyeProductSettings shareLvyeProductSettings]

@interface LvyeProductSettings : NSObject

/*!
 * @property
 * @brief 用户的个人推送Token
 */
@property (nonatomic , copy)      NSString              *userAPPDeviceTokenStr;


/*!
 * @property
 * @brief 用户是否登录了
 */
@property (nonatomic , assign)      BOOL                isClubUserLogin;

/*!
 * @property
 * @brief 登录者的手机号
 */
@property (nonatomic , copy)      NSString              *clubLoginUserMobile;

/*!
 * @property
 * @brief 登录者的密码
 */
@property (nonatomic , copy)      NSString              *clubLoginUserPassword;

/*!
  * @property
  * @brief 登录者的操作权限
  */
@property (nonatomic , strong)      NSArray             *clubLoginUserModelIdArray;

/*!
 * @property
 * @brief 登录者的操作权限
 */
@property (nonatomic , strong)      NSArray             *clubLoginUserModelInfoArray;

/*!
 * @property
 * @brief 用户 ID
 */
@property (nonatomic , copy)      NSString              *clubloginUserPerId;

/*!
 * @property
 * @brief 登录用户所在俱乐部 ID
 */
@property (nonatomic , copy)      NSString              *clubLoginUserAtClubId;

/*!
 * @property
 * @brief 订单管理模块功能操作
 */
@property (nonatomic , strong)      NSDictionary        *clubFunctionOrderModuleFunctionDictionary;

/*!
 * @property
 * @brief 财务管理模块功能操作
 */
@property (nonatomic , strong)      NSDictionary        *clubFunctionFinancialModuleDictionary;

/*!
 * @property
 * @brief 数据统计管理模块功能操作
 */
@property (nonatomic , strong)      NSDictionary        *clubFunctionDataModuleDictionary;

/*!
 * @property
 * @brief 账户管理模块功能操作
 */
@property (nonatomic , strong)      NSDictionary        *clubFunctionAccountModuleDictionary;

/*!
 * @property
 * @brief 俱乐部管理模块功能操作
 */
@property (nonatomic , strong)      NSDictionary        *clubFunctionManageModuleDictionary;

+ (LvyeProductSettings *)shareLvyeProductSettings;
@end
