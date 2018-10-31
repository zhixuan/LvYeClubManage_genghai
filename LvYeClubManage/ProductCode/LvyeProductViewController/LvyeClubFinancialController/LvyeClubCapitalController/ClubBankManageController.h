//
//  ClubBankManageController.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/10.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseViewController.h"
#import "ClubBankInfo.h"


@protocol ClubSelectedBankDelegate <NSObject>


/**
 用户选择提现银行卡操作协议

 @param bank 选中的银行卡信息
 */
- (void)userPersonalSelectedBank:(ClubBankInfo *)bank;
@end
/**
 俱乐部银行账户列表
 */
@interface ClubBankManageController : LvyeBaseViewController


- (instancetype)initWithDelegate:(id<ClubSelectedBankDelegate>) delegate;
@end
