//
//  LvYeHTTPClient+ClubTour.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/4/9.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "LvYeHTTPClient+ClubTour.h"

@implementation LvYeHTTPClient (ClubTour)
- (AFHTTPRequestOperation *)clubTourManageTourListDataInfoWithClubId:(NSString *)clubId
                                                            pageSize:(NSInteger)pageSize
                                                          pageNumber:(NSInteger)pageNumber
                                                               param:(NSDictionary *)info
                                                          completion:(WebAPIResponstComlitionBlock)completionBlock{
    
    
    if (clubId ==nil || [clubId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubId:clubId,
                            KDataKeyPageSize:[NSNumber numberWithInteger:pageSize],
                            KDataKeyPageNumber:[NSNumber numberWithInteger:pageNumber],
                            @"tourStatus":StringForKeyInUnserializedJSONDic(info, @"tourStatus"),
                            @"operaType":StringForKeyInUnserializedJSONDic(info, @"operaType"),
                            @"searchKey":StringForKeyInUnserializedJSONDic(info, @"searchKey")
                            };
    return [self getPath:KURLClubTourTableListURL parameters:param completion:completionBlock];
}


- (AFHTTPRequestOperation *)clubTourManageUpdateItemTourStatueWithClubId:(NSString *)clubId
                                                                 tourId:(NSString *)tourId
                                                             tourBaseId:(NSString *)tourBaseId
                                                              opeartion:(NSInteger) operaType
                                                             completion:(WebAPIResponstComlitionBlock)completionBlock{
    
    if (clubId ==nil || [clubId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    
    NSDictionary *param = @{KDataKeyClubId:clubId,
                            @"operaType":[NSNumber numberWithInteger:operaType],
                            @"tourBaseId":tourBaseId,
                            @"tourId":tourId
                            };
     return [self postPath:KURLClubUpdateTourStatusURL parameters:param completion:completionBlock];
}

@end
