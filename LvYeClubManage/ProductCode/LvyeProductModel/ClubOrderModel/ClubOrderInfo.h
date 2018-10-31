//
//  ClubOrderInfo.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/28.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "TourPriceInfo.h"

@interface ClubOrderInfo : TourPriceInfo

/*!
 * @property
 * @brief 订单号
 */
@property (nonatomic , copy)      NSString              *orderNumber;

/*!
 * @property
 * @brief 订单支付状态
 */
@property (nonatomic , copy)      NSString              *orderPaymentStatus;

/*!
 * @property
 * @brief 订单下单用户会员号
 */
@property (nonatomic , copy)      NSString              *orderMemberId;

/*!
 * @property
 * @brief 成人实际售卖价
 */
@property (nonatomic , copy)      NSNumber              *orderReprice;

/*!
 * @property
 * @brief 儿童实际售卖价
 */
@property (nonatomic , copy)      NSNumber              *orderReChildrenprice;

/*!
 * @property
 * @brief  房差价实际售卖价
 */
@property (nonatomic , copy)      NSNumber              *orderReRoomprice;

/*!
 * @property
 * @brief 订单下单时间
 */
@property (nonatomic , copy)      NSString              *orderAddDateTime;

/*!
 * @property
 * @brief 订单下单渠道
 */
@property (nonatomic , assign)    ClubOrderConsultStyle  orderConsultRoad;

/*!
 * @property
 * @brief 订单下单总人数
 */
@property (nonatomic , assign)      NSInteger           orderManPeopleCount;

/*!
 * @property
 * @brief 订单下单成人数
 */
@property (nonatomic , assign)      NSInteger           orderManAdultPeopleCount;

/*!
 * @property
 * @brief 订单下单儿童数
 */
@property (nonatomic , assign)      NSInteger           orderManChildrenPeopleCount;


/*!
 * @property
 * @brief 订单总金额
 */
@property (nonatomic , copy)      NSString              *orderTotalAmountMoney;

/*!
 * @property
 * @brief 订单实际支付总金额
 */
@property (nonatomic , copy)      NSString              *orderRealityPayTotalMoney;

/*!
 * @property
 * @brief 订单支付交易号
 */
@property (nonatomic , copy)      NSString              *orderTransactionId;

/*!
 * @property
 * @brief 订单支付方式
 */
@property (nonatomic , assign)      ClubOrderPayStyle   orderPayStyle;

/*!
 * @property
 * @brief 订单实际出团时间
 */
@property (nonatomic ,  copy)      NSString             *orderOutDateTime;

/*!
 * @property
 * @brief 订单实际返团时间
 */
@property (nonatomic ,  copy)      NSString             *orderBackDateTime;

/*!
 * @property
 * @brief 订单下单用户的备注
 */
@property (nonatomic , copy)      NSString              *orderRemarkContent;

/*!
 * @property
 * @brief 订单下单所属运营商Id
 */
@property (nonatomic , copy)      NSString              *orderSubstationId;

/*!
 * @property
 * @brief 订单下单所属运营商名字
 */
@property (nonatomic , copy)      NSString              *orderSubstationName;

/*!
 * @property
 * @brief 订单联系人名字
 */
@property (nonatomic , copy)      NSString              *orderLinkUserName;

/*!
 * @property
 * @brief 订单联系人电话
 */
@property (nonatomic , copy)      NSString              *orderLinkUserMobile;

/*!
 * @property
 * @brief 定点是否已经生成账单
 */
@property (nonatomic , assign)      BOOL                orderIsBillBool;



+ (instancetype)initWithClubOrderInfoWithUnserializedJSONDic:(NSDictionary *)dic;
@end
