//
//  AppDelegate+ServiceInfo.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/10.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "AppDelegate+ServiceInfo.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+ClubUser.h"

@implementation AppDelegate (ServiceInfo)


- (void)clubUserAutoLogin{
    
    if (!KLvyeProductClubSettings.isClubUserLogin) {
        return;
    }
    
    if (!IsNormalMobileNum(KLvyeProductClubSettings.clubLoginUserMobile)) {
        return;
    }
    
    if (IsStringEmptyOrNull(KLvyeProductClubSettings.clubLoginUserPassword)) {
        return;
    }
    
    [KShareHTTPLvyeHTTPClient userLoginWithUsrMobile:KLvyeProductClubSettings.clubLoginUserMobile password:KLvyeProductClubSettings.clubLoginUserPassword completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if (response.code == WebAPIResponseCodeSuccess) {
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    NSDictionary * datainfo =(NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    [KLvyeClubCurrentUser initClubCurrentUserInfoWithUnserializedJSONDic:datainfo];
                    [self clubUserUpdateAPPPushToken];
                }
            }
        });
    }];
}

- (void)clubUserUpdateAPPPushToken{
    [KShareHTTPLvyeHTTPClient userUpdateAPPPushDeviceToken:KLvyeProductClubSettings.clubloginUserPerId token:KLvyeProductClubSettings.userAPPDeviceTokenStr completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if (response.code == WebAPIResponseCodeSuccess) {
                NSLog(@"response.responseObject is %@",response.responseObject);
            }
        });
    }];
}
@end
