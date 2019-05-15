//
//  LvYeHTTPClient+CLubInfo.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/11.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvYeHTTPClient.h"
#import "ClubLeaderInfo.h"



/**
 俱乐部信息管理 数据请求
 */
@interface LvYeHTTPClient (CLubInfo)


/**
 获取俱乐部基本信息内容

 @param clubId 俱乐部 ID
 @param completionBlock  请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubBasicInfoWithClubId:(NSString *)clubId
                                         completion:(WebAPIResponstComlitionBlock)completionBlock;

/**
 获取俱乐部全部领队基本信息内容
 
 @param clubId 俱乐部 ID
 @param completionBlock  请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubAllLeaderInfoWithClubId:(NSString *)clubId
                                               pageSize:(NSInteger)pageSize
                                             pageNumber:(NSInteger)pageNumber
                                             completion:(WebAPIResponstComlitionBlock)completionBlock;



/**
 添加领队信息

 @param clubId 俱乐部 ID
 @param leader 领队信息
 @param completionBlock  请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubInsertLeaderInfoWithClubId:(NSString *)clubId
                                                    leader:(ClubLeaderInfo *)leader
                                                completion:(WebAPIResponstComlitionBlock)completionBlock;

/**
 添加领队信息
 
 @param clubId 俱乐部 ID
 @param leader 领队信息
 @param completionBlock  请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubUpdateLeaderInfoWithClubId:(NSString *)clubId
                                                    leader:(ClubLeaderInfo *)leader
                                                completion:(WebAPIResponstComlitionBlock)completionBlock;




/**
 获取俱乐部-账户管理中-机构管理列表数据信息 （部门信息+各部门人员配置信息）

 @param clubId  俱乐部 ID
 @param completionBlock 请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubAccountManageGetDepartmentUsersWithClubId:(NSString *)clubId
                                                               completion:(WebAPIResponstComlitionBlock)completionBlock;

/**
 获取俱乐部-账户管理中-机构管理列表中-俱乐部的部门列表
 
 @param clubId  俱乐部 ID
 @param completionBlock 请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubAccountManageGetDepartmentListsWithClubId:(NSString *)clubId
                                                               completion:(WebAPIResponstComlitionBlock)completionBlock;


/**
 俱乐部账户管理 --- 机构管理  -- 添加部门

 @param clubId 俱乐部 ID
 @param info  部门信息
 @param completionBlock 请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubbAccountAddDepartmentInfoWithClubId:(NSString *)clubId
                                                         department:(NSDictionary *)info
                                                         completion:(WebAPIResponstComlitionBlock)completionBlock;
@end
