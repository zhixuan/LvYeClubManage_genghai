//
//  ClubOrderRefundInfo.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/30.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubOrderInfo.h"

@interface ClubOrderRefundInfo : ClubOrderInfo


/*!
 * @property
 * @brief 订单退款 ID
 */
@property (nonatomic , copy)      NSString              *orderRefundId;

/*!
 * @property
 * @brief 订单退款金额
 */
@property (nonatomic , copy)      NSString              *orderRefundPrice;

/*!
 * @property
 * @brief 订单退款状态
 */
@property (nonatomic , assign)      NSInteger           *orderRefundStateInt;

/*!
 * @property
 * @brief 订单退款提交时间
 */
@property (nonatomic ,  assign)     NSString            *orderRefundAddTime;

/*!
 * @property
 * @brief 订单退款说明
 */
@property (nonatomic , copy)      NSString              *orderRefundRemark;

/*!
 * @property
 * @brief 订单退款完成时间
 */
@property (nonatomic , copy)      NSString              *orderRefundTime;

/*!
 * @property
 * @brief 订单退款提交人ID
 */
@property (nonatomic , copy)      NSString              *orderRefundUserId;

/*!
 * @property
 * @brief 订单退款提交人Name
 */
@property (nonatomic , copy)      NSString              *orderRefuntdUserName;

/*!
 * @property
 * @brief 订单退款原因
 */
@property (nonatomic , copy)      NSString              *orderRefundReason;
@end
