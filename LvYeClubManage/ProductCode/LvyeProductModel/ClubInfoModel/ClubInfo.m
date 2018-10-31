//
//  ClubInfo.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubInfo.h"

@implementation ClubInfo
- (id)init{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}
#pragma mark -
#pragma mark -  初始化俱乐部具体内容
- (void)initClubInfoWithUnserializedJSONDic:(NSDictionary *)dic{
    
    self.clubId = StringForKeyInUnserializedJSONDic(dic, @"os_company_id");
    self.clubName = StringForKeyInUnserializedJSONDic(dic, @"club_name");
    self.clubCompanyName = StringForKeyInUnserializedJSONDic(dic, @"company_name");
    self.clubAddress = StringForKeyInUnserializedJSONDic(dic, @"club_address");
    self.clubEvaluatPer = FloatForKeyInUnserializedJSONDic(dic, @"company_evaluat_per");
    
    self.clubRegisterDate  = StringForKeyInUnserializedJSONDic(dic, @"add_date");
    self.clubLogoImageURL = StringForKeyInUnserializedJSONDic(dic, @"company_logo");
    self.clubBgImageURL = StringForKeyInUnserializedJSONDic(dic, @"club_bg_image");
    self.clubSalonContent = StringForKeyInUnserializedJSONDic(dic, @"slogan_content");
    self.clubValidityTouristCount = IntForKeyInUnserializedJSONDic(dic, @"company_valid_out");
}
@end
