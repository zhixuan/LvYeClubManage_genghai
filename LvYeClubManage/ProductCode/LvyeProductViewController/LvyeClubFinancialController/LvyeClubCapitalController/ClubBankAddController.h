//
//  ClubBankAddController.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/10.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseViewController.h"



@protocol ClubUserAddBandDelegate <NSObject>


/**
 用户添加银行卡操作

 @param finish 是否添加完成
 */
- (void)clubUserAddClubBandOperation:(BOOL)finish;
@end
/**
 俱乐部管理用户添加银行卡
 */
@interface ClubBankAddController : LvyeBaseViewController


- (instancetype)initWithDelegate:(id<ClubUserAddBandDelegate>) delegate;
@end
