//
//  ClubInfo.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 @class 俱乐部信息
 */
@interface ClubInfo : NSObject



/*!
 * @property
 * @brief 信息 ID
 */
@property (nonatomic , copy)      NSString              *infoId;
/*!
 * @breif 俱乐部 ID
 * @See 俱乐部 ID
 */
@property (nonatomic , copy)      NSString              *clubId;

/*!
 * @breif 俱乐部名字
 * @See 俱乐部名字
 */
@property (nonatomic , copy)      NSString               *clubName;

/*!
 * @breif 俱乐部所在地址
 * @See 俱乐部所在地址
 */
@property (nonatomic , copy)      NSString               *clubAddress;

/*!
 * @breif 俱乐部公司名
 * @See 俱乐部公司名
 */
@property (nonatomic , copy)      NSString              *clubCompanyName;

/*!
 * @property
 * @brief 俱乐部 salon 内容
 */
@property (nonatomic , copy)      NSString              *clubSalonContent;

//company_evaluat_per
/*!
 * @property
 * @brief 俱乐部好评率
 */
@property (nonatomic ,  assign)      float             clubEvaluatPer;

/*!
 * @property
 * @brief 俱乐部 logo
 */
@property (nonatomic , copy)      NSString              *clubLogoImageURL;

/*!
 * @property
 * @brief 俱乐部宣传背景图
 */
@property (nonatomic , copy)      NSString              *clubBgImageURL;

/*!
 * @property
 * @brief 俱乐部有效出行人数
 */
@property (nonatomic , assign)      NSInteger           clubValidityTouristCount;

/*!
 * @property
 * @brief 俱乐部入驻时间
 */
@property (nonatomic , copy)      NSString              *clubRegisterDate;

/*!
 * @property
 * @brief 俱乐部是否被禁用
 */
@property (nonatomic , assign)      BOOL                clubIsLock;

/*!
 * @property
 * @brief 俱乐部入账资金金额
 */
@property (nonatomic , copy)      NSString              *clubInsertCapital;

/*!
 * @property
 * @brief 俱乐部提现出账资金额
 */
@property (nonatomic , copy)      NSString              *clubSubtractCapital;

/*!
 * @property
 * @brief 俱乐部资金账户可提现总金额
 */
@property (nonatomic , copy)      NSString              *clubCapitalSurplusMoney;

/**
 初始化俱乐部具体内容

 @param dic  JSON 数据
 */
- (void)initClubInfoWithUnserializedJSONDic:(NSDictionary *)dic;
@end
