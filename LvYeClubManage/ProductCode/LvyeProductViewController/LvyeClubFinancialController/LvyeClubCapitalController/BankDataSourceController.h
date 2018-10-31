//
//  BankDataSourceController.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/10.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseViewController.h"
#import "BankInfo.h"

@protocol UserSelectedBankSourceDelegate <NSObject>

- (void)userPersonalSelectedOperation:(BankInfo *)bank;

@end

@interface BankDataSourceController : LvyeBaseViewController


- (instancetype)initWithDelegate:(id<UserSelectedBankSourceDelegate>) delegate;
@end
