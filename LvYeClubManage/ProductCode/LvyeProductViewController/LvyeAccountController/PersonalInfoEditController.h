//
//  PersonalInfoEditController.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/9.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseViewController.h"



/**
 编辑用户信息枚举

 - EditUserNameStyle: 编辑用户名字
 - EditUserPasswordStyle: 编辑用户密码
 - EditUserEmailStyle: 编辑用户邮箱
 */
typedef NS_ENUM(NSUInteger,EditUserStyle) {
    EditUserNameStyle = 1,
    EditUserPasswordStyle,
    EditUserEmailStyle,
    EditUserMoblieStyle,
};

@interface PersonalInfoEditController : LvyeBaseViewController


- (instancetype)initWithEditUserStyle:(EditUserStyle)style;
@end
