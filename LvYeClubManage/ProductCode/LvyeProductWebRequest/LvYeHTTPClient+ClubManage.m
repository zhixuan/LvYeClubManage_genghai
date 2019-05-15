//
//  LvYeHTTPClient+ClubManage.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/25.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvYeHTTPClient+ClubManage.h"

@implementation LvYeHTTPClient (ClubManage)


///MARK:根据模块 ID，获取登录用户所有该模块下可操作功能信息
-(AFHTTPRequestOperation *)userClubOperationFunctionWithClubId:(NSString *)clubId
                                                        userId:(NSString *)userId
                                                      moduleId:(NSString *)moduleId
                                                    completion:(WebAPIResponstComlitionBlock)completionBlock{
    
    if (clubId ==nil || [clubId length] < 1 || [moduleId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubID:clubId,
                            KDataKeyUserID:userId,
                            @"moduleId":moduleId};
    
    return [self getPath:KURLClubAccountPerFunctionURL parameters:param completion:completionBlock];
}


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
                                                  completion:(WebAPIResponstComlitionBlock)completionBlock{
    if (clubId ==nil || [clubId length] < 1 ) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubID:clubId,
                            KDataKeyPageNumber:[NSNumber numberWithInteger:number],
                            KDataKeyPageSize:[NSNumber numberWithInteger:pageSize]
                            };
    
    
    return [self getPath:KURLClubCommentListURL parameters:param completion:completionBlock];
    
}


/**
 获取登录俱乐部被评论线路的全部评论详情信息
 
 @param clubId 俱乐部 ID
 @param completionBlock 请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
-(AFHTTPRequestOperation *)userClubGetTourCommentDetailListWithClubId:(NSString  *)clubId
                                                           completion:(WebAPIResponstComlitionBlock)completionBlock{
    
    if (clubId ==nil || [clubId length] < 1 ) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubID:clubId,};
    return [self getPath:KURLClubTourCommentDetailURL parameters:param completion:completionBlock];
}
@end
