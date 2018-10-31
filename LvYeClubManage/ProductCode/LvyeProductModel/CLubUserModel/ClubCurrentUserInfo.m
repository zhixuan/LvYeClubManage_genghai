//
//  ClubCurrentUserInfo.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubCurrentUserInfo.h"

@implementation ClubCurrentUserInfo


static ClubCurrentUserInfo *userInfo = nil;

- (id)init{
    self =[super init];
    if (self) {
        self.userIsLogin = NO;
        self.userSystemArray = [[NSMutableArray alloc]init];
        self.userFunctionMutableArray = [[NSMutableArray alloc]init];
    }
    
    return self;
}
+ (ClubCurrentUserInfo *)shareClubCurrentUserInfo{
    
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        userInfo = [[ClubCurrentUserInfo alloc]init];
    });
    
    return userInfo;
}

- (void)initClubCurrentUserInfoWithUnserializedJSONDic:(NSDictionary *)dic{
    
   
    NSLog(@"%@",dic);
    if (dic != NULL && [dic count] > 0) {
        
         ClubCurrentUserInfo *userInfo = KLvyeClubCurrentUser;
        
        [userInfo setUserIsLogin:YES];
        [userInfo setClubId:StringForKeyInUnserializedJSONDic(dic, @"user_co")];
        [userInfo setClubName:StringForKeyInUnserializedJSONDic(dic, @"company_name")];
        [userInfo setClubCompanyName:StringForKeyInUnserializedJSONDic(dic, @"company_BR")];
        
        [userInfo setUserId:StringForKeyInUnserializedJSONDic(dic, @"userId")];
        [userInfo setUserName:StringForKeyInUnserializedJSONDic(dic, @"name")];
        [userInfo setUserNameSimple:StringForKeyInUnserializedJSONDic(dic, @"user_name")];
        [userInfo setUserMobile:StringForKeyInUnserializedJSONDic(dic, @"mobile")];
        [userInfo setUserEmail:StringForKeyInUnserializedJSONDic(dic, @"email")];
        [userInfo setUserAuthorityIdStr:StringForKeyInUnserializedJSONDic(dic, @"Role_ID")];
        [userInfo setUserPhotoImageURL:StringForKeyInUnserializedJSONDic(dic, @"photo_url")];

        ////模块内容
        if ([ObjForKeyInUnserializedJSONDic(dic, @"moduleList") isKindOfClass:[NSArray class]]) {
            NSArray *moduleArray =ObjForKeyInUnserializedJSONDic(dic, @"moduleList") ;
            [userInfo setUserSystemArray: [NSMutableArray arrayWithArray:moduleArray]];
        }
        
        if([ObjForKeyInUnserializedJSONDic(dic, @"moduleIdList") isKindOfClass:[NSArray class]]){
            NSArray *moduleArray =ObjForKeyInUnserializedJSONDic(dic, @"moduleIdList") ;
            [userInfo setUserSystemModleIdArray:[NSMutableArray arrayWithArray:moduleArray]];
        }
        ///功能内容
        if ([ObjForKeyInUnserializedJSONDic(dic, @"functionList") isKindOfClass:[NSArray class]]) {
            NSArray *moduleArray =ObjForKeyInUnserializedJSONDic(dic, @"functionList") ;
            [userInfo setUserFunctionMutableArray: [NSMutableArray arrayWithArray:moduleArray]];
           
        }

        [KLvyeProductClubSettings setClubLoginUserMobile:userInfo.userMobile];
        [KLvyeProductClubSettings setIsClubUserLogin:YES];
        [KLvyeProductClubSettings setClubLoginUserModelIdArray:userInfo.userSystemModleIdArray];
        [KLvyeProductClubSettings setClubLoginUserModelInfoArray:userInfo.userSystemArray];
        
        [KLvyeProductClubSettings setClubLoginUserAtClubId:userInfo.clubId];
        [KLvyeProductClubSettings setClubloginUserPerId:userInfo.userId];

        
    }
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    
    NSLog(@"进入到这里了没有 initWithCoder");
    if (self) {
        self.userId =[aDecoder decodeObjectForKey:@"clubUserPerId"];
        self.userName = [aDecoder decodeObjectForKey:@"clubUserPerName"];
        self.userMobile = [aDecoder decodeObjectForKey:@"clubUserMobilePerName"];
        self.userEmail = [aDecoder decodeObjectForKey:@"clubUserPerEmail"];
       
        self.clubId = [aDecoder decodeObjectForKey:@"clubUserPerAtClubId"];
        self.clubName = [aDecoder decodeObjectForKey:@"clubUserPerAtClubName"];
        self.clubCompanyName = [aDecoder decodeObjectForKey:@"clubCompanyName"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    
    NSLog(@"进入到这里了没有 - (void)encodeWithCoder:(NSCoder *)aCoder");
    [aCoder encodeObject: self.userId forKey:@"clubUserPerId"];
    [aCoder encodeObject:self.userName forKey:@"clubUserPerName"];
    [aCoder encodeObject:self.userMobile forKey:@"clubUserMobilePerName"];
    [aCoder encodeObject:self.userEmail forKey:@"clubUserPerEmail"];
    
    [aCoder encodeObject:self.clubId forKey:@"clubUserPerAtClubId"];
    [aCoder encodeObject:self.clubName forKey:@"clubUserPerAtClubName"];
    [aCoder encodeObject:self.clubCompanyName forKey:@"clubCompanyName"];
}

- (void)clubUserLogoutAndClearCurrentUserInfo{
    [KLvyeProductClubSettings setClubLoginUserPassword:@""];
    [KLvyeProductClubSettings setIsClubUserLogin:NO];
    [KLvyeProductClubSettings setClubLoginUserMobile:@""];
    [KLvyeClubCurrentUser setUserIsLogin:NO];
    [KLvyeClubCurrentUser setUserMobile:@""];
}
@end
