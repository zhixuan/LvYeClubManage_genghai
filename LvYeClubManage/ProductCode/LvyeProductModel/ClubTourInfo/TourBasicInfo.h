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
 * @brief 线路 ID
 */
@property (nonatomic , copy)      NSString      *tourBasicId;

/*!
 * @property
 * @brief 线路名字
 */
@property (nonatomic , copy)      NSString      *tourName;

/*!
 * @property
 * @brief 线路出行天数
 */
@property (nonatomic , copy)      NSString      *tourTeamDays;

/*!
 * @property
 * @brief 线路出行大交通
 */
@property (nonatomic , copy)      NSString      *tourBigTraffic;

/*!
 * @property
 * @brief 线路发行领队 ID
 */
@property (nonatomic , copy)      NSString      *tourUserForLeaderId;

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
 * @brief 线路产品副标题
 */
@property (nonatomic , copy)      NSString      *tourAdverbTitle;

@end
