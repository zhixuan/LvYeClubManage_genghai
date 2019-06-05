//
//  LvYeHTTPClient+ClubManage.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/25.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvYeHTTPClient.h"


/**
 俱乐部管理模块 网络请求   （俱乐部自己模块功能，操作功能请求，及 俱乐部人员管理的请求）
 */
@interface LvYeHTTPClient (ClubManage)

/**
 根据模块 ID，获取登录用户所有该模块下可操作功能信息

 @param clubId 俱乐部 iD
 @param userId  用户 ID
 @param moduleId  模块 ID
 @return AFHTTPRequestOperation 实例
 */
-(AFHTTPRequestOperation *)userClubOperationFunctionWithClubId:(NSString *)clubId
                                                        userId:(NSString *)userId
                                                      moduleId:(NSString *)moduleId
                                                    completion:(WebAPIResponstComlitionBlock)completionBlock;



/**
 获取登录俱乐部的评论线路列表

 @param clubId 俱乐部 ID
 @param pageSize  页面大小
 @param number 当前页面
 @param completionBlock 请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
-(AFHTTPRequestOperation *)userClubCommentListInfoWithClubId:(NSString  *)clubId
                                                    pageSize:(NSInteger)pageSize
                                                  pageNumber:(NSInteger)number
                                                  completion:(WebAPIResponstComlitionBlock)completionBlock;


/**
 获取登录俱乐部被评论线路的全部评论详情信息

 @param clubId 俱乐部 ID
 @param completionBlock 请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
-(AFHTTPRequestOperation *)userClubGetTourCommentDetailListWithCommentId:(NSString  *)commentId
                                                           completion:(WebAPIResponstComlitionBlock)completionBlock;

@end
