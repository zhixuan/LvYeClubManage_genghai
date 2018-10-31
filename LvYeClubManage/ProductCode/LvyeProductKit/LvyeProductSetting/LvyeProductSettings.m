//
//  LvyeProductSettings.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/23.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeProductSettings.h"

@implementation LvyeProductSettings

//声明静态实例
static LvyeProductSettings       *lvyeProductSettings = nil;

#pragma mark -
#pragma mark - 编辑系统设置参数信息内容
+(LvyeProductSettings *)shareLvyeProductSettings{
    
    @synchronized(self){
        if (!lvyeProductSettings) {
            lvyeProductSettings = [[self alloc]init];
        }
    }
    return lvyeProductSettings;
}

- (id)init{
    self = [super init];
    if (self == nil)
        return nil;
    
    return self;
}


- (void)setUserAPPDeviceTokenStr:(NSString *)userAPPDeviceTokenStr{
    [[NSUserDefaults standardUserDefaults] setObject:userAPPDeviceTokenStr forKey:@"LvyeProductUserAPPDeviceTokenStr"];
}

- (NSString *)userAPPDeviceTokenStr{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"LvyeProductUserAPPDeviceTokenStr"]) {
        return @"";
    }
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"LvyeProductUserAPPDeviceTokenStr"];
}

#pragma mark -
#pragma mark -  登录状态存储
- (void)setIsClubUserLogin:(BOOL)isClubUserLogin{
    [[NSUserDefaults standardUserDefaults] setBool:isClubUserLogin forKey:@"LvyeProductIsClubUserLogin"];
}

- (BOOL)isClubUserLogin{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"LvyeProductIsClubUserLogin"]) {
        return NO;
    }
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"LvyeProductIsClubUserLogin"];
}

#pragma mark -
#pragma mark -  用户信息存储
- (void)setClubLoginUserMobile:(NSString *)clubLoginUserMobile{
    [[NSUserDefaults standardUserDefaults] setObject:clubLoginUserMobile forKey:@"LvyeProductClubLoginUserMobile"];
}

- (NSString*)clubLoginUserMobile{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"LvyeProductClubLoginUserMobile"]) {
        return @"";
    }
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"LvyeProductClubLoginUserMobile"];
}

- (void)setClubLoginUserPassword:(NSString *)clubLoginUserPassword{
    [[NSUserDefaults standardUserDefaults] setObject:clubLoginUserPassword forKey:@"LvyeProductClubLoginUserPassword"];
}

- (NSString *)clubLoginUserPassword{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"LvyeProductClubLoginUserPassword"]) {
        return @"";
    }
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"LvyeProductClubLoginUserPassword"];
}

- (void)setClubLoginUserModelIdArray:(NSArray *)clubLoginUserModelIdArray{
     [[NSUserDefaults standardUserDefaults] setObject:clubLoginUserModelIdArray forKey:@"LvyeProductClubLoginUserModelIdArray"];
}
- (NSArray*)clubLoginUserModelIdArray{
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"LvyeProductClubLoginUserModelIdArray"]) {
        return [NSArray array];
    }
    return (NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:@"LvyeProductClubLoginUserModelIdArray"];
}

- (void)setClubLoginUserModelInfoArray:(NSArray *)clubLoginUserModelInfoArray{
    [[NSUserDefaults standardUserDefaults] setObject:clubLoginUserModelInfoArray forKey:@"LvyeProductClubLoginUserModelInfomationArray"];
}
- (NSArray*)clubLoginUserModelInfoArray{
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"LvyeProductClubLoginUserModelInfomationArray"]) {
        return [NSArray array];
    }
    return (NSArray *)[[NSUserDefaults standardUserDefaults] objectForKey:@"LvyeProductClubLoginUserModelInfomationArray"];
}


- (void)setClubloginUserPerId:(NSString *)clubloginUserPerId{
    [[NSUserDefaults standardUserDefaults] setObject:clubloginUserPerId forKey:@"LvyeProductClubloginUserPerId"];
}

- (NSString *)clubloginUserPerId{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"LvyeProductClubloginUserPerId"]) {
        return @"";
    }
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"LvyeProductClubloginUserPerId"];
}

- (void)setClubLoginUserAtClubId:(NSString *)clubLoginUserAtClubId{
     [[NSUserDefaults standardUserDefaults] setObject:clubLoginUserAtClubId forKey:@"LvyeProductClubLoginUserAtClubId"];
}
- (NSString *)clubLoginUserAtClubId{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"LvyeProductClubLoginUserAtClubId"]) {
        return @"";
    }
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"LvyeProductClubLoginUserAtClubId"];
}

#pragma mark -
#pragma mark -  模块功能信息存储

- (void)setClubFunctionDataModuleDictionary:(NSDictionary *)clubFunctionDataModuleDictionary{
    [[NSUserDefaults standardUserDefaults] setObject:clubFunctionDataModuleDictionary
                                              forKey:@"LvyeProductClubFunctionDataModuleDictionary"];
}

- (NSDictionary *)clubFunctionDataModuleDictionary{
    if (![[NSUserDefaults standardUserDefaults] stringForKey:@"LvyeProductClubFunctionDataModuleDictionary"]) {
        return [NSDictionary dictionary];
    }
    
    return (NSDictionary *)[[NSUserDefaults standardUserDefaults] stringForKey:@"LvyeProductClubFunctionDataModuleDictionary"];
}
@end

