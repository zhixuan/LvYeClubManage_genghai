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


- (NSMutableDictionary *)parameterForClubUserInsertLeaderInfo{
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    
    AddObjectForKeyIntoDictionary(self.clubId, @"clubId", paramDic);
    AddObjectForKeyIntoDictionary(self.userName, @"name", paramDic);
    AddObjectForKeyIntoDictionary(self.leaderCardCode, @"idCard", paramDic);
    AddObjectForKeyIntoDictionary([NSNumber  numberWithInteger:self.userGenderStyle], @"sex", paramDic);
    AddObjectForKeyIntoDictionary(self.leaderLocationCityName, @"locationNow", paramDic);
    AddObjectForKeyIntoDictionary(self.userMobile, @"tel", paramDic);
    AddObjectForKeyIntoDictionary(self.leaderImportantLinkMobile, @"immediateTel", paramDic);
    AddObjectForKeyIntoDictionary(self.userQQCode, @"qq", paramDic);
    AddObjectForKeyIntoDictionary(self.userWeChatCode, @"wechat", paramDic);
    AddObjectForKeyIntoDictionary(self.leaderEvaluation, @"selfAssessment", paramDic);
    AddObjectForKeyIntoDictionary(self.leaderIntroduction, @"introduction", paramDic);
    AddObjectForKeyIntoDictionary([NSNumber numberWithInteger:self.leaderState], @"state", paramDic);
    AddObjectForKeyIntoDictionary(self.userPhotoImageURL, @"photo", paramDic);
    AddObjectForKeyIntoDictionary(self.userPhotoImageURL, @"headPhoto", paramDic);
    
    
    
    
    AddObjectForKeyIntoDictionary(IsStringEmptyOrNull(self.leaderNationName)?@"":self.leaderNationName, @"nation", paramDic);
    AddObjectForKeyIntoDictionary(IsStringEmptyOrNull(self.leaderNativePlaceStr)?@"":self.leaderNativePlaceStr, @"placeOrigin", paramDic);
    AddObjectForKeyIntoDictionary(IsStringEmptyOrNull(self.leaderPositionStation)?@"":self.leaderPositionStation, @"station", paramDic);
    AddObjectForKeyIntoDictionary(IsStringEmptyOrNull(self.leaderStarStr)?@"":self.leaderStarStr, @"star", paramDic);
    
    
    AddObjectForKeyIntoDictionary(IsStringEmptyOrNull(self.leaderStandardChinese)?@"":self.leaderStandardChinese, @"pth", paramDic);
    AddObjectForKeyIntoDictionary(IsStringEmptyOrNull(self.leaderNativeDialect)?@"":self.leaderNativeDialect, @"fynl", paramDic);
    AddObjectForKeyIntoDictionary(IsStringEmptyOrNull(self.leaderEnglishCompetence)?@"":self.leaderEnglishCompetence, @"english", paramDic);
    AddObjectForKeyIntoDictionary(IsStringEmptyOrNull(self.leaderOtherLanguageCompetence)?@"":self.leaderOtherLanguageCompetence, @"orther", paramDic);
    
    
    AddObjectForKeyIntoDictionary(IsStringEmptyOrNull(self.leaderWorkExperience)?@"":self.leaderWorkExperience, @"experienceYear", paramDic);
    AddObjectForKeyIntoDictionary(IsStringEmptyOrNull(self.leaderSpecialtyContent)?@"":self.leaderSpecialtyContent, @"experience", paramDic);
    AddObjectForKeyIntoDictionary(@"0", @"Id", paramDic);
    
    
    NSLog(@"%@ ",[self toPropertyExportString]);
    return paramDic;
}

- (NSMutableDictionary *)parameterForClubUserUpdateLeaderInfo{
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setDictionary:[self parameterForClubUserInsertLeaderInfo]];
    AddObjectForKeyIntoDictionary(self.userId, @"leaderPoolId", paramDic);
    AddObjectForKeyIntoDictionary(@"0", @"Id", paramDic);
    
    return paramDic;
}
@end
