//
//  ClubBankInfo.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/11.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "BankInfo.h"

@interface ClubBankInfo : BankInfo

/*!
 * @property
 * @brief 俱乐部绑定银行卡的
 */
@property (nonatomic , strong)      NSString            *clubAccountTitle;

/*!
 * @property
 * @brief 银行卡类别
 */
@property (nonatomic , assign)      ClubBankStyle       clubBankAccounStyle;

/*!
 * @property
 * @brief 银行卡卡号
 */
@property (nonatomic ,  strong)      NSString           *clubBankCardCode;

/*!
 * @property
 * @brief 银行卡开户行名称
 */
@property (nonatomic ,  strong)      NSString           *clubOpeningBankName;

/*!
 * @property
 * @brief 银行卡开户人名字
 */
@property (nonatomic ,  strong)      NSString           *clubOpeningUserName;

/**
 根据 JSON 解析的数据，得到银行信息
 
 @param dic  JSON 信息
 @return 银行信息实例
 */
+ (ClubBankInfo *)initClubBankInfoWithUnserializedJSONDic:(NSDictionary *)dic;
@end
