//
//  LvYeHTTPClient+ClubTourStatistics.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/4/15.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "LvYeHTTPClient+ClubTourStatistics.h"

@implementation LvYeHTTPClient (ClubTourStatistics)


- (AFHTTPRequestOperation *)clubDataManageClubTourStatisticsInfoWithClubId:(NSString *)clubId
                                                                completion:(WebAPIResponstComlitionBlock)completionBlock{
    
    
    
    if (clubId ==nil || [clubId length] < 1 ) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubId:clubId};
    
    return [self getPath:KURLClubTourStatisticsURL parameters:param completion:completionBlock];
}
@end
