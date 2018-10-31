//
//  ClubLeaderInfo.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubLeaderInfo.h"

@implementation ClubLeaderInfo
- (id)init{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

+ (ClubLeaderInfo *)initClubLeaderInfoWithUnserializedJSONDic:(NSDictionary *)dic{
    
    ClubLeaderInfo *leader = [[ClubLeaderInfo alloc]init];
    
    [leader setUserId:StringForKeyInUnserializedJSONDic(dic, @"leader_pool_id")];
    [leader setUserName:StringForKeyInUnserializedJSONDic(dic, @"name")];
    [leader setUserTelCode:StringForKeyInUnserializedJSONDic(dic, @"tel")];
    [leader setUserGenderStyle:IntForKeyInUnserializedJSONDic(dic, @"sex")];
    [leader setUserPhotoImageURL:StringForKeyInUnserializedJSONDic(dic, @"head_photo")];
    
    [leader setLeaderEvaluation:StringForKeyInUnserializedJSONDic(dic, @"self_assessment")];
    [leader setLeaderLocationCityName:StringForKeyInUnserializedJSONDic(dic, @"location_now")];
    return leader;
}
@end
