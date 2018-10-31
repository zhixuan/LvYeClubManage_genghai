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
@end
