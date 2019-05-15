//
//  TourBasicInfo.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/28.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubInfo.h"

@interface TourBasicInfo : ClubInfo


/*!
 * @property
 * @brief 线路编号
 */
@property (nonatomic , copy)      NSString      *tourBasicId;

/*!
 * @property
 * @brief 线路 ID
 */
@property (nonatomic , copy)      NSString      *tourId;

/*!
 * @property
 * @brief 线路名字
 */
@property (nonatomic , copy)      NSString      *tourName;

/*!
 * @property
 * @brief 线路状态
 */
@property (nonatomic , copy)      NSString      *tourStatus;

/*!
 * @property
 * @brief 线路出行天数
 */
@property (nonatomic , copy)      NSString      *tourTeamDays;

/*!
 * @property
 * @brief 线路产品副标题
 */
@property (nonatomic , copy)      NSString      *tourAdverbTitle;

/*!
 * @property
 * @brief 线路出行大交通
 */
@property (nonatomic , copy)      NSString      *tourBigTrafficId;

/*!
 * @property
 * @brief 线路出行大交通名字
 */
@property (nonatomic , copy)      NSString      *tourBigTrafficName;

/*!
 * @property
 * @brief 线路发行领队 ID
 */
@property (nonatomic , copy)      NSString      *tourUserForLeaderId;

/*!
 * @property
 * @brief 线路发行领队名字
 */
@property (nonatomic , copy)      NSString      *tourUserForLeaderName;

/*!
 * @property
 * @brief 线路首图地址
 */
@property (nonatomic , copy)      NSString      *tourPublicizeImageURL;

/*!
 * @property
 * @brief 线路j起步价
 */
@property (nonatomic , copy)      NSString      *tourStartingPrice;

/*!
 * @property
 * @brief 线路修改时间
 */
@property (nonatomic , copy)      NSString      *tourModDateTime;

/*!
 * @property
 * @brief 线路添加时间
 */
@property (nonatomic , copy)      NSString      *tourAddDateTime;

/*!
 * @property
 * @brief 线路是否有保险
 */
@property (nonatomic , assign)      BOOL        tourHasIsInsurance;

/*!
 * @property
 * @brief 线路出发城市
 */
@property (nonatomic , copy)      NSString      *tourSendCitiesName;


/*!
 * @property
 * @brief 线路出发城市编号
 */
@property (nonatomic , copy)      NSString      *tourSendCitiesIds;

/*!
 * @property
 * @brief 线路平台结算率
 */
@property (nonatomic , assign)      NSInteger   tourOpPercentInteger;

/*!
 * @property
 * @brief 线路渠道结算率
 */
@property (nonatomic , assign)      NSInteger   tourChPercentInteger;

/*!
 * @property
 * @brief 保险价格
 */
@property (nonatomic , copy)      NSString      *tourInsurancePrice;




/**
 初始化俱乐部活动管理中活动列表数据内容

 @param dic JSON数据
 @return ClubFinanceCapitalRecod 对象实例
 */
+ (TourBasicInfo *)initClubTourBasicInfoForClubTourManagesTourTableWithUnserializedJSONDic:(NSDictionary *)dic;

@end
