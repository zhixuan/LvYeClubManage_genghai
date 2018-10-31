//
//  ClubCurrentUserInfo.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubUserInfo.h"
#import "WebAPIResponse.h"


#define KLvyeClubCurrentUser [ClubCurrentUserInfo shareClubCurrentUserInfo]




@interface ClubCurrentUserInfo : ClubUserInfo<NSCoding>


/*!
 * @breif 用户当前是否在登录状态
 * @See 默认是 NO，登录成功后，可直接改为 YES；
 */
@property (nonatomic , assign)      BOOL                userIsLogin;


/*!
 * @property
 * @brief 当前登录者所对应的全部模块功能信息
 */
@property (nonatomic , strong)      NSMutableArray      *userSystemArray;

/*!
 * @property
 * @brief 当前登录者所对应的全部模块功能Id信息
 */
@property (nonatomic , strong)      NSMutableArray      *userSystemModleIdArray;

/*!
 * @property
 * @brief 用户当前操作权限字段
 */
@property (nonatomic , strong)      NSString            *userAuthorityIdStr;

/*!
 * @property
 * @brief 当前登录者所对应的功能信息
 */
@property (nonatomic , strong)      NSMutableArray      *userFunctionMutableArray;


+ (ClubCurrentUserInfo *)shareClubCurrentUserInfo;
- (void)initClubCurrentUserInfoWithUnserializedJSONDic:(NSDictionary *)dic;


- (void)clubUserLogoutAndClearCurrentUserInfo;
@end
