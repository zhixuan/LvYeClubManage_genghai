//
//  LvYeHTTPClient+ClubTour.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/4/9.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "LvYeHTTPClient.h"

NS_ASSUME_NONNULL_BEGIN

@interface LvYeHTTPClient (ClubTour)



/**
 俱乐部活动g管理-活动管理列表数据内容-活动数据

 @param clubId 俱乐部 ID
 @param pageSize 页面大小
 @param pageNumber y当前页面
 @param info 查询参数
 @param completionBlock 请求结果 Block
 @return 请求Request
 */
- (AFHTTPRequestOperation *)clubTourManageTourListDataInfoWithClubId:(NSString *)clubId
                                                            pageSize:(NSInteger)pageSize
                                                          pageNumber:(NSInteger)pageNumber
                                                               param:(NSDictionary *)info
                                                          completion:(WebAPIResponstComlitionBlock)completionBlock;



/**
 根据俱乐部 ID，活动信息，修改该活动的状态用于审核或者停用该活动

 @param clubId 俱乐部 ID
 @param tourId 线路 ID
 @param tourBaseId 线路编号
 @param operaType 操作类别 =1，表示提交审核； =2，表示停用该活动。
 @param completionBlock 请求结果 Block
 @return 请求Request
 */
- (AFHTTPRequestOperation *)clubTourManageUpdateItemTourStatueWithClubId:(NSString *)clubId
                                                                 tourId:(NSString *)tourId
                                                             tourBaseId:(NSString *)tourBaseId
                                                              opeartion:(NSInteger) operaType
                                                             completion:(WebAPIResponstComlitionBlock)completionBlock;
@end

NS_ASSUME_NONNULL_END
