//
//  ClubAddDepartmentViewController.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseViewController.h"


@protocol ClubAddDepartmentDelegate <NSObject>

- (void)userAddClubAddDepartmentOperationSuccessful;
@end
/**
 俱乐部添加部门操作
 */
@interface ClubAddDepartmentViewController : LvyeBaseViewController

- (instancetype)initWithDelegate:(id<ClubAddDepartmentDelegate>) delegate;
@end
