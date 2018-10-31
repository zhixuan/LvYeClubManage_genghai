//
//  ClubLeaderInfo.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubUserInfo.h"

/**
 俱乐部领队人员信息
 */
@interface ClubLeaderInfo : ClubUserInfo


/*!
 * @property
 * @brief 领队身份证号
 */
@property (nonatomic , copy)      NSString          *leaderCardCode;

/*!
 * @property
 * @brief 领队编号
 */
@property (nonatomic , copy)      NSString          *leaderCodeNumber;

/*!
 * @property
 * @brief 领队所在城市
 */
@property (nonatomic , copy)      NSString          *leaderLocationCityName;

/*!
 * @property
 * @brief 领队自我评价
 */
@property (nonatomic , copy)      NSString          *leaderEvaluation;
/**
 *  @method
 *
 *  @brief          初始化俱乐部领队用户信息
 *
 *  @param          dic JSON 数据内容
 *
 *  @discussion     根据 JSON 数据解析得到领队对象数据
 *
 *  @return         ClubLeaderInfo 领队信息
 *
 */
+ (ClubLeaderInfo *)initClubLeaderInfoWithUnserializedJSONDic:(NSDictionary *)dic;
@end
