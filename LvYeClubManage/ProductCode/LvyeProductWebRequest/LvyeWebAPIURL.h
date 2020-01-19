//
//  LvyeWebAPIURL.h
//  LvYeClubManage
//
//  Created by LiGuang Zhang on 2020/1/11.
//  Copyright © 2020 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#define KLvyeShareLvyeWebAPIURL [LvyeWebAPIURL shareLvyeWebAPIURL]

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN




/// 俱乐部订单接口集合
struct ClubOrderAPI{
    
    __unsafe_unretained NSString  *  clubOrderListURL;          /**< 俱乐部订单列表接口    \ref 接口名       clubOrder/clubOrderList*/
    __unsafe_unretained NSString  *  clubOrderListDetailURL;    /**< 俱乐部订单详情接口   \ref clubOrder/itemOrderInfo */
};


/// 领队信息API接口集合
struct ClubLeaderURLApi {
    __unsafe_unretained NSString  * clubLeaderListInfo;         /**< 领队列表接口    \ref clubLeader/leaderList */
    __unsafe_unretained NSString  * clubLeaderItemDetail;       /**< 领队详情接口    \ref clubLeader/leaderDetail */
    __unsafe_unretained NSString  * clubLeaderInfoInsert;       /**< 领队添加接口    \ref clubLeader/leaderInsertl */
    __unsafe_unretained NSString  * clubLeaderInfoUpdate;       /**< 领队修改接口    \ref clubLeader/leaderUpdate */
};
@interface LvyeWebAPIURL : NSObject

/*!
 * @property
 * @brief 俱乐部订单接口
 */
@property (nonatomic , assign)  struct    ClubOrderAPI clubOrderAPI;

/*!
 * @property
 * @brief l领队信息接口
 */
@property (nonatomic , assign) struct   ClubLeaderURLApi clubLeaderUrlAPI;

+ (LvyeWebAPIURL *)shareLvyeWebAPIURL;
@end

NS_ASSUME_NONNULL_END
