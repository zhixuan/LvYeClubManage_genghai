//
//  ClubUserInfo.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubUserInfo.h"

@implementation ClubUserInfo
- (id)init{
    self = [super init];
    if (self) {
        self.userGenderStyle = ClubUserGenderMaleStyle;
    }
    
    return self;
}


#pragma mark -
#pragma mark -  根据 JSON 数据解析用户信息，获取俱乐部用户对象
+ (ClubUserInfo *)initClubUserInfoWithUnserializedJSONDic:(NSDictionary *)dic{
    ClubUserInfo *userInfo = [[ClubUserInfo alloc]init];
    
    
    [userInfo setClubId:StringForKeyInUnserializedJSONDic(dic, @"clubId")];
    [userInfo setClubName:StringForKeyInUnserializedJSONDic(dic, @"clubName")];
    return userInfo;
}


#pragma mark -
#pragma mark -  根据 JSON 数据解析用户信息，获取俱乐部各部门中的用户信息
+ (ClubUserInfo *)initClubUserInfoForDepartmenUserWithUnserializedJSONDic:(NSDictionary *)dic{
    ClubUserInfo *userInfo = [[ClubUserInfo alloc]init];
    
    
    [userInfo setUserId:StringForKeyInUnserializedJSONDic(dic, @"userId")];
    [userInfo setUserName:StringForKeyInUnserializedJSONDic(dic, @"userName")];
    [userInfo setUserMobile:StringForKeyInUnserializedJSONDic(dic, @"userMobile")];
    [userInfo setClubDepartmentId:StringForKeyInUnserializedJSONDic(dic, @"user_team")];
    [userInfo setUserPhotoImageURL:StringForKeyInUnserializedJSONDic(dic, @"photourl")];
    
    [userInfo setUserIsLock:BoolForKeyInUnserializedJSONDic(dic, @"IsLock")];
    return userInfo;
}

- (NSDictionary *)parameterInitDictionaryWithUserAddClubAdministrator{
    
    NSDictionary *paramUser = @{@"userName":self.userName,
                                @"userNameSimple":self.userNameSimple,
                                @"userPwd":self.userPassword,
                                @"userEmail":self.userEmail,
                                @"userMobile":self.userMobile,
                                
                                @"userCo":self.clubId,
                                @"userDes":self.clubDepartmentId,
                                @"isLock":[NSNumber numberWithBool:self.userIsLock],
                                @"RordID":@"24,"
                                };
    
    return paramUser;
}
@end
