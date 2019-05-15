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

#pragma mark -
#pragma mark -  根据 JSON 数据解析用户信息，获取订单联系人信息
+ (ClubUserInfo *)initClubUserInfoForOrderLinkUserInfoWithUnserializedJSONDic:(NSDictionary *)dic{
    ClubUserInfo *userInfo = [[ClubUserInfo alloc]init];
    [userInfo setUserName:StringForKeyInUnserializedJSONDic(dic, @"user_name")];
    [userInfo setUserEmail:StringForKeyInUnserializedJSONDic(dic, @"user_email")];
    [userInfo setUserMobile:StringForKeyInUnserializedJSONDic(dic, @"user_phone")];
    
    NSLog(@"dic is %@",dic);
    return userInfo;
}

#pragma mark -
#pragma mark -  初始化创建俱乐部管理员参数信息
- (NSMutableDictionary *)parameterInitDictionaryWithUserAddClubAdministrator{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];

    
//   [Hash = 1360080751, osLoginUserId=null, userName=xinkuanxiaodangjia, userPassword=6PJVDEM37NGRT3QC670B14728AD9902AECBA32E22FA4F6BDQE6UTCD8DIGH7RQU, loginnum=0, islock=0, userCo=1501, userTeam=172, workjob=0, teamaspect=null, name=新款小当家, tourRole=0, saleRole=0, userRole=null, companyType=0, mobile=186154596807, tel=null, fax=null, email=小积石山姐姐, msn=null, qqnum=null, lastIp=null, lastTime=null, allotOrder=0, resultOrder=0, transferOrder=0, orderSearch=0, editTourlineSearch=0, saleTourlineSearch=0, extension=null, extensionPass=null, isCall=0, device=null, optionalOrder=0, lockedOrder=0, optionalOrderNum=null, seeTel=null, isFinance=0, callPostSet=0, consultingWay=null, signIn=null, sendCity=null, isAnyPermissions=null, todayOrder=0, noneDetail=0, regPic=upload/155358408800004926.png, roleId=null, loginType=null, osGTripTypeId=null, osGDestinationId=null, serialVersionUID=1]
    
 
    AddObjectForKeyIntoDictionary(self.clubId, @"userCo", param);
    AddObjectForKeyIntoDictionary(self.userName, @"name", param);
    AddObjectForKeyIntoDictionary(self.userNameSimple, @"userName", param);
    AddObjectForKeyIntoDictionary(self.userMobile, @"mobile", param);
    AddObjectForKeyIntoDictionary(self.userPassword, @"userPassword", param);
    AddObjectForKeyIntoDictionary(self.userPhotoImageURL, @"regPic", param);
    AddObjectForKeyIntoDictionary([NSNumber numberWithInt:0], @"islock", param);
    AddObjectForKeyIntoDictionary(self.userEmail, @"email", param);
    AddObjectForKeyIntoDictionary(self.clubDepartmentId, @"userTeam", param);
    AddObjectForKeyIntoDictionary(@"0,18,19,20,21,22,23,24,", @"roleId", param);

    
    ///默认参数信息
    AddObjectForKeyIntoDictionary(@"0", @"loginnum", param);
    AddObjectForKeyIntoDictionary(@"0", @"workjob", param);
    
    AddObjectForKeyIntoDictionary(@"0", @"tourRole", param);
    AddObjectForKeyIntoDictionary(@"0", @"saleRole", param);
    AddObjectForKeyIntoDictionary(@"0", @"userRole", param);
    AddObjectForKeyIntoDictionary(@"0", @"companyType", param);
    
    AddObjectForKeyIntoDictionary(@"0", @"allotOrder", param);
    AddObjectForKeyIntoDictionary(@"0", @"resultOrder", param);
    AddObjectForKeyIntoDictionary(@"0", @"transferOrder", param);
    AddObjectForKeyIntoDictionary(@"0", @"orderSearch", param);
    AddObjectForKeyIntoDictionary(@"0", @"editTourlineSearch", param);
    AddObjectForKeyIntoDictionary(@"0", @"saleTourlineSearch", param);
    
    AddObjectForKeyIntoDictionary(@"0", @"extension", param);
    AddObjectForKeyIntoDictionary(@"0", @"extensionPass", param);
    AddObjectForKeyIntoDictionary(@"0", @"isCall", param);
    AddObjectForKeyIntoDictionary(@"0", @"optionalOrder", param);
    AddObjectForKeyIntoDictionary(@"0", @"lockedOrder", param);
    AddObjectForKeyIntoDictionary(@"0", @"optionalOrderNum", param);
    AddObjectForKeyIntoDictionary(@"0", @"seeTel", param);
    AddObjectForKeyIntoDictionary(@"0", @"isFinance", param);
    AddObjectForKeyIntoDictionary(@"0", @"callPostSet", param);
    AddObjectForKeyIntoDictionary(@"0", @"todayOrder", param);
    AddObjectForKeyIntoDictionary(@"0", @"noneDetail", param);
    AddObjectForKeyIntoDictionary(@"0", @"id", param);
    


    return param;
}

- (NSMutableDictionary *)parameterInitDictionaryWithUserUpdateClubAdministrator{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setDictionary:[self parameterInitDictionaryWithUserAddClubAdministrator]];
    AddObjectForKeyIntoDictionary(self.userId, @"osLoginUserId", param);
    
    return param;
    
}
@end
