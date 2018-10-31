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
@end
