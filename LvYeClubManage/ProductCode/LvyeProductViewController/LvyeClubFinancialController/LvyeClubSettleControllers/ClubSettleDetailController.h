//
//  ClubSettleDetailController.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/29.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseViewController.h"
#import "ClubFinanceCapitalRecod.h"

@interface ClubSettleDetailController : LvyeBaseViewController

- (instancetype)initWithBillCheckNumber:(NSString *)checkNum;

- (instancetype)initWithClubFinanceCapitalRecord:(ClubFinanceCapitalRecod *)record;
@end
