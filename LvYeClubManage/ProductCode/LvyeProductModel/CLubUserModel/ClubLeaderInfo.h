//
//  ClubLeaderInfo.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubUserInfo.h"
#import "NSObject+PropertyExport.h"

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
 * @brief 所属民族 eg. 汉，回族，维吾尔族
 */
@property (nonatomic , copy)      NSString          *leaderNationName;

/*!
 * @property
 * @brief 领队籍贯
 */
@property (nonatomic , copy)      NSString          *leaderNativePlaceStr;

/*!
 * @property
 * @brief 领队星级
 */
@property (nonatomic , copy)      NSString          *leaderStarStr;

/*!
 * @property
 * @brief 领队职位
 */
@property (nonatomic , copy)      NSString          *leaderPositionStation;

/*!
 * @property
 * @brief 领队自我评价 self_assessment
 */
@property (nonatomic , copy)      NSString          *leaderEvaluation;


/*!
 * @property
 * @brief 领队个人介绍 introduction
 */
@property (nonatomic , copy)      NSString          *leaderIntroduction;

/*!
 * @property
 * @brief 领队紧急联系电话
 */
@property (nonatomic , copy)      NSString          *leaderImportantLinkMobile;

/*!
 * @property
 * @brief 领队是否被禁用 =0，表示正常，=1表示被禁用；
 */
@property (nonatomic , assign)      NSInteger       leaderState;

/*!
 * @property
 * @brief 领队普通话能力
 */
@property (nonatomic , copy)        NSString        *leaderStandardChinese;

/*!
 * @property
 * @brief 领队方言能力
 */
@property (nonatomic ,  copy)      NSString         *leaderNativeDialect;

/*!
 * @property
 * @brief 领队英语能力
 */
@property (nonatomic , copy)      NSString          *leaderEnglishCompetence;

/*!
 * @property
 * @brief 领队其他语言能力
 */
@property (nonatomic , copy)      NSString          *leaderOtherLanguageCompetence;

/*!
 * @property
 * @brief 领队技能专长
 */
@property (nonatomic , copy)      NSString          *leaderSpecialtyContent;

/*!
 * @property
 * @brief 领队工作经验
 */
@property (nonatomic , copy)      NSString          *leaderWorkExperience;


/*
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



/**
 俱乐部登录者，添加领队所需参数内容

 @return 参数Dictionary
 */
- (NSMutableDictionary *)parameterForClubUserInsertLeaderInfo;

- (NSMutableDictionary *)parameterForClubUserUpdateLeaderInfo;
@end
