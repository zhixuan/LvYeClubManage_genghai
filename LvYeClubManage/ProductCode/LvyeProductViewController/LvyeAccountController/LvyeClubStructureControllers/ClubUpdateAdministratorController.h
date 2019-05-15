//
//  ClubUpdateAdministratorController.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/4/19.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


/**
 修改管理员信息
 */
@interface ClubUpdateAdministratorController : LvyeBaseViewController


/**
 编辑或者查看用户信息
 
 @param userInfo 用户信息
 @return 视图控制器
 */
- (instancetype)initWithUserInfo:(ClubUserInfo *)userInfo;
@end

NS_ASSUME_NONNULL_END
