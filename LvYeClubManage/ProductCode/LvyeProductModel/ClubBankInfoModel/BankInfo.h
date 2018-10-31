//
//  BankInfo.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/11.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubInfo.h"

@interface BankInfo : ClubInfo


/*!
 * @breif 银行数据源编号
 * @See 银行数据源编号
 */
@property (nonatomic , strong)      NSString                *bankSourceId;

/*!
 * @breif 银行数据源名字
 * @See 银行数据源名字
 */
@property (nonatomic , strong)      NSString                *bankSourceName;

/*!
 * @breif 银行数据源ID
 * @See 银行数据源ID
 */
@property (nonatomic , strong)      NSString                *bankInfoId;






/**
 根据 JSON 解析的数据，得到银行信息

 @param dic  JSON 信息
 @return 银行信息实例
 */
+ (BankInfo *)initBankInfoWithUnserializedJSONDic:(NSDictionary *)dic;
@end
