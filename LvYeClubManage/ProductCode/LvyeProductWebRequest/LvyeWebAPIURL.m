//
//  LvyeWebAPIURL.m
//  LvYeClubManage
//
//  Created by LiGuang Zhang on 2020/1/11.
//  Copyright © 2020 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//



#import "LvyeWebAPIURL.h"
static LvyeWebAPIURL *singleClass  = nil;
static dispatch_once_t once_token;
@implementation LvyeWebAPIURL

+ (LvyeWebAPIURL *)shareLvyeWebAPIURL{
    dispatch_once(&once_token, ^{
        if (!singleClass) {
            singleClass = [super init];
        }
    });
    return singleClass;
}

- (instancetype)init{
    
    self = [super init];
    if (self) {
        _clubOrderAPI.clubOrderListURL = @"clubOrder/clubOrderList";
        _clubOrderAPI.clubOrderListDetailURL = @"clubOrder/itemOrderInfo";
        
    
        _clubLeaderUrlAPI.clubLeaderListInfo = @"clubLeader/leaderList";
        _clubLeaderUrlAPI.clubLeaderItemDetail = @"clubLeader/leaderDetail";
        _clubLeaderUrlAPI.clubLeaderInfoInsert = @"clubLeader/leaderInsertl";
        _clubLeaderUrlAPI.clubLeaderInfoUpdate = @"clubLeader/leaderUpdate";
    }
    
    return self;
}

@end
