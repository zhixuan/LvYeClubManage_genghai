//
//  TourPriceInfo.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/28.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "TourBasicInfo.h"

@interface TourPriceInfo : TourBasicInfo
/*!
 * @property
 * @brief 团期 ID
 */
@property (nonatomic , copy)      NSString          *tourPriceInfoId;

/*!
 * @property
 * @brief 团期出发时间
 */
@property (nonatomic , copy)      NSString          *tourPriceLeaveDate;

/*!
 * @property
 * @brief 团期返回时间
 */
@property (nonatomic , copy)      NSString          *tourPriceBackDate;

/*!
 * @property
 * @brief 成人结算价
 */
@property (nonatomic , copy)      NSNumber          *tourPriceReprice;

/*!
 * @property
 * @brief 儿童结算价
 */
@property (nonatomic , copy)      NSNumber          *tourPriceReChildrenprice;

/*!
 * @property
 * @brief  房差价结算价
 */
@property (nonatomic , copy)      NSNumber          *tourPriceReRoomprice;

/*!
 * @property
 * @brief 团期主题
 */
@property (nonatomic , copy)      NSString          *tourPriceTheme;

/*!
 * @property
 * @brief 团期出游天数
 */
@property (nonatomic , copy)      NSString          *tourPriceTeamDays;

/*!
 * @property
 * @brief 渠道结算率
 */
@property (nonatomic , assign)   NSInteger          tourChPercent;

/*!
 * @property
 * @brief 平台结算率
 */
@property (nonatomic , assign)   NSInteger          tourOPPercent;
@end
