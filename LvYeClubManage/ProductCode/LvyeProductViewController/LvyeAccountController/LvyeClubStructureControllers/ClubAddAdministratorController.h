//
//  ClubAddAdministratorController.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseViewController.h"


/**
 俱乐部添加管理者界面
 */
@interface ClubAddAdministratorController : LvyeBaseViewController



/**
 编辑或者查看用户信息

 @param userInfo 用户信息
 @return 视图控制器
 */
- (instancetype)initWithUserInfo:(ClubUserInfo *)userInfo;
@end
