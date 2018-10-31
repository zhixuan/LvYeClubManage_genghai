//
//  ClubTravellerUserInfo.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/30.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubTravellerUserInfo.h"

@implementation ClubTravellerUserInfo


#pragma mark -
#pragma mark -  根据 JSON 数据解析旅客信息，获取旅客对象
+ (ClubTravellerUserInfo *)initWithClubTravellerUserInfoWithUnserializedJSONDic:(NSDictionary *)dic{
    
    ClubTravellerUserInfo *itemUser = [[ClubTravellerUserInfo alloc]init];
    [itemUser setUserId:StringForKeyInUnserializedJSONDic(dic, @"userId")];
    [itemUser setUserName:StringForKeyInUnserializedJSONDic(dic, @"userName")];
    [itemUser setUserMobile:StringForKeyInUnserializedJSONDic(dic, @"userMobile")];
    [itemUser setUserEmail:StringForKeyInUnserializedJSONDic(dic, @"userEmail")];
    [itemUser setClubTravellerUserStyleInt:IntForKeyInUnserializedJSONDic(dic, @"type")];
    [itemUser setClubTravellerUserCardStyle:IntForKeyInUnserializedJSONDic(dic, @"cardType")];
    [itemUser setClubTravellerUserCardCodeStr:StringForKeyInUnserializedJSONDic(dic, @"cardCode")];
    return itemUser;
}
@end
