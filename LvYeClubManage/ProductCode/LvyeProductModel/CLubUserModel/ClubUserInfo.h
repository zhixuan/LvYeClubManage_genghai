//
//  ClubUserInfo.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//
#import "ClubDepartmentInfo.h"



/**
 * @class  俱乐部用户信息
 */
@interface ClubUserInfo : ClubDepartmentInfo


/*!
 * @property
 * @brief 用户 ID
 */
@property (nonatomic , copy)      NSString            *userId;

/*!
 * @property 用户名缩写
 * @brief 用户名
 */
@property (nonatomic , copy)      NSString            *userNameSimple;

/*!
 * @property
 * @brief 用户密码
 */
@property (nonatomic ,  copy)      NSString         *userPassword;

/*!
 * @property 用户名
 * @brief  用户名
 */
@property (nonatomic , copy)      NSString            *userName;


/*!
 * @property
 * @brief 用户性别 \ref 男是0，女是1
 */
@property (nonatomic , assign)      ClubUserGenderStyle  userGenderStyle;

/*!
 * @property
 * @brief 用户微信号
 */
@property (nonatomic , copy)      NSString           *userWeChatCode;

/*!
 * @property
 * @brief 用户 QQ 号码
 */
@property (nonatomic , copy)      NSString          *userQQCode;

/*!
 * @property
 * @brief 用户手机号
 */
@property (nonatomic , copy)      NSString          *userMobile;

/*!
 * @property
 * @brief 用户电话
 */
@property (nonatomic , copy)      NSString          *userTelCode;

/*!
 * @property
 * @brief 用户邮箱
 */
@property (nonatomic , copy)      NSString          *userEmail;

/*!
 * @property
 * @brief 用户头像
 */
@property (nonatomic , copy)      NSString          *userPhotoImageURL;

/*!
 * @property
 * @brief 用户是否被禁用 \ref userIsLock== YES，表示该用户被禁用；若==NO，则表示没有被禁用
 */
@property (nonatomic , assign)      BOOL            userIsLock;

/**
 根据 JSON 数据解析用户信息，获取俱乐部用户对象

 @param dic  JSON 数据
 @return ClubUserInfo 对象
 */
+ (ClubUserInfo *)initClubUserInfoWithUnserializedJSONDic:(NSDictionary *)dic;



/**
 根据 JSON 数据解析用户信息，获取俱乐部各部门中的用户信息
 
 @param dic  JSON 数据
 @return ClubUserInfo 对象
 */
+ (ClubUserInfo *)initClubUserInfoForDepartmenUserWithUnserializedJSONDic:(NSDictionary *)dic;


/**
 根据 JSON 数据解析用户信息，获取订单联系人信息
 
 @param dic  JSON 数据
 @return ClubUserInfo 对象
 */
+ (ClubUserInfo *)initClubUserInfoForOrderLinkUserInfoWithUnserializedJSONDic:(NSDictionary *)dic;


/**
 初始化创建俱乐部管理员参数信息

 @return NSDictionary
 */
- (NSDictionary *)parameterInitDictionaryWithUserAddClubAdministrator;


@end
