//
//  TourBasicInfo.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/28.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "TourBasicInfo.h"

@implementation TourBasicInfo

- (instancetype)init{
    
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (TourBasicInfo *)initClubTourBasicInfoForClubTourManagesTourTableWithUnserializedJSONDic:(NSDictionary *)dic{
    
    
    NSLog(@"dic is %@",dic)
    
    TourBasicInfo *itemTour = [[TourBasicInfo alloc]init];
    [itemTour setTourId:StringForKeyInUnserializedJSONDic(dic, @"id")];
    [itemTour setTourBasicId:StringForKeyInUnserializedJSONDic(dic, @"tour_basic_info_id")];
    [itemTour setTourName:StringForKeyInUnserializedJSONDic(dic, @"team_name")];
    [itemTour setTourStartingPrice:StringForKeyInUnserializedJSONDic(dic, @"price_up")];
    [itemTour setTourPublicizeImageURL:StringForKeyInUnserializedJSONDic(dic, @"recommre_photo")];
    [itemTour setTourBigTrafficName:StringForKeyInUnserializedJSONDic(dic, @"trafficName")];
    [itemTour setTourSendCitiesName:StringForKeyInUnserializedJSONDic(dic, @"send_cityName")];
    [itemTour setTourHasIsInsurance:BoolForKeyInUnserializedJSONDic(dic, @"is_insurance")];
    [itemTour setTourStatus:StringForKeyInUnserializedJSONDic(dic, @"status")];
    [itemTour setTourTeamDays:StringForKeyInUnserializedJSONDic(dic, @"TeamDays")];
    
    
    return itemTour;
}
@end
