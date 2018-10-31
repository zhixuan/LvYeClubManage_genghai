//
//  ClubFinanceCapitalRecod.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/27.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubOrderRefundInfo.h"

@interface ClubFinanceCapitalRecod : ClubOrderRefundInfo


/*!
 * @property
 * @brief 财务资金记录 ID
 */
@property (nonatomic , copy)      NSString              *capitalDepositId;

/*!
 * @property
 * @brief 财务资金操作时间
 */
@property (nonatomic ,  copy)      NSString             *capitalAddTimeStr;

/*!
 * @property
 * @brief 财务资金记录订单号
 */
@property (nonatomic ,  copy)      NSString             *capitalRecodNumber;

/*!
 * @property
 * @brief 财务资金金额内容
 */
@property (nonatomic , copy)      NSString              *capitalMoneyCotnent;

/*!
 * @property
 * @brief 财务资金类别状态
 */
@property (nonatomic ,assign)      NSInteger            capitalRecodStatusType;

/*!
 * @property
 * @brief 本次结算订单个数
 */
@property (nonatomic , assign)      NSInteger           capitalOrderCount;

/*!
 * @property
 * @brief 本次结算订单中所有人数
 */
@property (nonatomic , assign)      NSInteger           capitalOrderPeopleCount;

/*!
 * @property
 * @brief 当前数据状态
 */
@property (nonatomic , assign)      NSInteger           capitalBillCheckStateType;

/*!
 * @property
 * @brief 财务资金操作用户名
 */
@property (nonatomic , copy)      NSString              *capitalUserName;


/**
 初始化资金管理中列表数据（包括入账数据，出账数据（手续费、提现信息）等）

 @param dic JSON数据
 @return ClubFinanceCapitalRecod 对象实例
 */
+ (ClubFinanceCapitalRecod *)initClubFinanceCapitalRecodWithUnserializedJSONDic:(NSDictionary *)dic;

/**
 初始化结算记录列表数据（包括每次申请结算的人数，订单数，结算额等信息）
 
 @param dic JSON数据
 @return ClubFinanceCapitalRecod 对象实例
 */
+ (ClubFinanceCapitalRecod *)initClubFinanceCapitalRecodForSettleUpListWithUnserializedJSONDic:(NSDictionary *)dic;


/**
 初始化财务结算中关于订单的数据内容

 @param dic JSON数据
 @return ClubFinanceCapitalRecod 对象实例
 */
+(ClubFinanceCapitalRecod *)initClubFinanceUserOrderInfoWithWithUnserializedJSONDic:(NSDictionary *)dic;
@end
