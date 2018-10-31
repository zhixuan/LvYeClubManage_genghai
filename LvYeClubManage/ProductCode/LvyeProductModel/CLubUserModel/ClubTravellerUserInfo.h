//
//  ClubTravellerUserInfo.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/30.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubUserInfo.h"

@interface ClubTravellerUserInfo : ClubUserInfo

/*!
 * @property
 * @brief 旅客类型
 */
@property (nonatomic , assign)      NSInteger       clubTravellerUserStyleInt;


/*!
 * @property
 * @brief 旅客证件类型
 */
@property (nonatomic ,  assign) ClubUserCardStyle   clubTravellerUserCardStyle;

/*!
 * @property
 * @brief 旅客证件编码
 */
@property (nonatomic , copy)      NSString          *clubTravellerUserCardCodeStr;


/**
 根据 JSON 数据解析旅客信息，获取旅客对象
 
 @param dic  JSON 数据
 @return ClubUserInfo 对象
 */
+ (ClubTravellerUserInfo *)initWithClubTravellerUserInfoWithUnserializedJSONDic:(NSDictionary *)dic;
@end
