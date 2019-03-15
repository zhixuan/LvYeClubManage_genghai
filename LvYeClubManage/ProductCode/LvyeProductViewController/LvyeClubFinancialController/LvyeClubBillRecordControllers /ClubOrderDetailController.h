//
//  ClubOrderDetailController.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/9/4.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseViewController.h"
#import "ClubFinanceCapitalRecod.h"
#import "ClubOrderInfo.h"

@interface ClubOrderDetailController : LvyeBaseViewController


/*!
 * @property
 * @brief 订单内容
 */
@property (nonatomic , strong)ClubOrderInfo           *itemOrderInfo;
/**
 初始化订单详情界面

 @param orderInfo 根据内容，转化为订单
 @return 视图控制器
 */
- (instancetype)initWithOrderInfo:(ClubOrderInfo *)orderInfo;
@end
