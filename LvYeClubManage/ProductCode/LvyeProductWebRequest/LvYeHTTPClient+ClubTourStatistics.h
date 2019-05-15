//
//  LvYeHTTPClient+ClubTourStatistics.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/4/15.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "LvYeHTTPClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface LvYeHTTPClient (ClubTourStatistics)
/**
 俱乐部数据管理中获取活动统计数据信息

 @param clubId 俱乐部 ID
 
 @param completionBlock 请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubDataManageClubTourStatisticsInfoWithClubId:(NSString *)clubId
                                                                completion:(WebAPIResponstComlitionBlock)completionBlock;
@end

NS_ASSUME_NONNULL_END
