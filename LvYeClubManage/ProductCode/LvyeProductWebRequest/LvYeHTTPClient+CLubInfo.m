//
//  LvYeHTTPClient+CLubInfo.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/11.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvYeHTTPClient+CLubInfo.h"

@implementation LvYeHTTPClient (CLubInfo)


#pragma mark -
#pragma mark -  获取俱乐部基本信息内容
- (AFHTTPRequestOperation *)clubBasicInfoWithClubId:(NSString *)clubId
                                         completion:(WebAPIResponstComlitionBlock)completionBlock{
    
    if (clubId ==nil || [clubId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubId:clubId};
    return [self getPath:KURLClubBaseInfoURL parameters:param completion:completionBlock];
}

#pragma mark -
#pragma mark -  获取俱乐部全部领队基本信息内容
- (AFHTTPRequestOperation *)clubAllLeaderInfoWithClubId:(NSString *)clubId
                                               pageSize:(NSInteger)pageSize
                                             pageNumber:(NSInteger)pageNumber
                                             completion:(WebAPIResponstComlitionBlock)completionBlock{
    if (clubId ==nil || [clubId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubID:clubId,
                            KDataKeyPageSize:[NSNumber numberWithInteger:pageSize],
                            KDataKeyPageNumber:[NSNumber numberWithInteger:pageNumber]
                            };
    return [self getPath:KURLClubBaseLeaderInfoURL parameters:param completion:completionBlock];
}

#pragma mark -
#pragma mark -  获取俱乐部-账户管理中-机构管理列表数据信息 （部门信息+各部门人员配置信息）
- (AFHTTPRequestOperation *)clubAccountManageGetDepartmentUsersWithClubId:(NSString *)clubId
                                                               completion:(WebAPIResponstComlitionBlock)completionBlock{
    if (clubId ==nil || [clubId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubID:clubId
                            };
    return [self getPath:KURLClubAccountDepartmentUsersURL parameters:param completion:completionBlock];
}


#pragma mark -
#pragma mark -  获取俱乐部-账户管理中-机构管理列表中-俱乐部的部门列表
- (AFHTTPRequestOperation *)clubAccountManageGetDepartmentListsWithClubId:(NSString *)clubId
                                                               completion:(WebAPIResponstComlitionBlock)completionBlock{
    if (clubId ==nil || [clubId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubID:clubId
                            };
    return [self getPath:KURLClubAccountDepartmentListURL parameters:param completion:completionBlock];
}

- (AFHTTPRequestOperation *)clubbAccountAddDepartmentInfoWithClubId:(NSString *)clubId department:(NSDictionary *)info completion:(WebAPIResponstComlitionBlock)completionBlock{
    
    
    if (clubId ==nil || [clubId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    if (info ==nil || [info count] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubID:clubId,
                            @"departmentName":StringForKeyInUnserializedJSONDic(info, @"departmentName"),
                            @"departmentContent":StringForKeyInUnserializedJSONDic(info, @"departmentContent"),
                            };
    
    return [self postPath:KURLClubAccountADDDepartmentURL parameters: (NSDictionary *)param completion:completionBlock];

}
@end
