//
//  LvYeHTTPClient+ClubUser.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/11.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvYeHTTPClient+ClubUser.h"

@implementation LvYeHTTPClient (ClubUser)

- (AFHTTPRequestOperation *)userLoginWithUsrMobile:(NSString *)mobile password:(NSString *)password completion:(WebAPIResponstComlitionBlock)completionBlock{
    
    if (mobile ==nil || [mobile length] < 11) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    if (password ==nil || [password length] < 11) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{@"userMobile":mobile,
                            @"userPass":password,
                            };
    return [self getPath:KURLLoginURL parameters:param completion:completionBlock];
}

/**
 登录用户上传获取到的推送 TOKEN
 
 @param userId  登录用户ID
 @param token 推送 TOKEN
 @param completionBlock 登录操作请求完成后的返回结果Block
 @return AFHTTPRequestOperation 实例
 */
- (AFHTTPRequestOperation *)userUpdateAPPPushDeviceToken:(NSString *)userId
                                                   token:(NSString *)token
                                              completion:(WebAPIResponstComlitionBlock)completionBlock{
    
    if (userId ==nil || [userId length] < 1 || token == nil || [token length] < 20) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    
    ////苹果登录为1，安卓登录为2
    NSDictionary *param = @{@"userId":userId,
                            @"token":token,
                            @"appType":[NSNumber numberWithInteger:1],
                            };
    return [self postPath:KURLUpdateTokenURL parameters:param completion:completionBlock];
}

- (AFHTTPRequestOperation *)userAddClubAdministarorWithUserInfo:(ClubUserInfo *)userInfo
                                                    completion:(WebAPIResponstComlitionBlock)completionBlock{
//
//    if (userId ==nil || [userId length] < 1 || token == nil || [token length] < 20) {
//        if (completionBlock) {
//            completionBlock([WebAPIResponse invalidArgumentsResonse]);
//        }
//        return nil;
//    }
    
    
    NSDictionary *param = [userInfo parameterInitDictionaryWithUserAddClubAdministrator];
    return [self postPath:KURLUpdateTokenURL parameters:param completion:completionBlock];
}

- (AFHTTPRequestOperation *)clubUserEditPersonalInfWithClubId:(NSString *)clubId userId:(NSString *)userId info:(NSDictionary *)info completion:(WebAPIResponstComlitionBlock)completionBlock{
    
    
    if (clubId ==nil || [clubId length] < 1 || [userId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubID:clubId,
                            KDataKeyUserId:userId,
                            @"name":StringForKeyInUnserializedJSONDic(info, @"userName"),
                            @"mobile":StringForKeyInUnserializedJSONDic(info, @"mobile"),
                            @"email":StringForKeyInUnserializedJSONDic(info, @"email"),
                            @"photoUrl":StringForKeyInUnserializedJSONDic(info, @"photoUrl"),
                            };
    
    return [self getPath:KURLUpdateUserBaseInfoURL parameters:param completion:completionBlock];
    
}

- (AFHTTPRequestOperation *)clubUserUpdatePersonalPasswordWithClubId:(NSString *)clubId userId:(NSString *)userId old:(NSString *)oldPwd new:(NSString *)newPwd completion:(WebAPIResponstComlitionBlock)completionBlock{
    
    if (clubId ==nil || [clubId length] < 1 || [userId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubID:clubId,
                            KDataKeyUserId:userId,
                            @"originalPwd":oldPwd,
                            @"newPwd":newPwd,};
    
    return [self getPath:KURLUpdateUserPasswordURL parameters:param completion:completionBlock];
    
}
@end
