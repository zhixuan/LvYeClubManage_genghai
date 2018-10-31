//
//  ClubDepartmentViewController.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseViewController.h"


@protocol ClubDepartmentSelectDelegate <NSObject>

- (void)userSelectedClubDepartmentFinishOperation:(NSDictionary*)info;

@end
/**
 俱乐部的部门列表
 */
@interface ClubDepartmentViewController : LvyeBaseViewController
- (instancetype)initWithDelegate:(id<ClubDepartmentSelectDelegate>) delegate;

@end
