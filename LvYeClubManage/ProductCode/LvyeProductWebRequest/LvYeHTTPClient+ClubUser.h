//
//  LvYeHTTPClient+ClubUser.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/11.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvYeHTTPClient.h"

/**
 * 俱乐部人员信息管理 （个人登录、领队管理）
 */
@interface LvYeHTTPClient (ClubUser)


/**
 用户登录操作接口

 @param mobile 用户已被绑定的手机号
 @param password 用户密码
 @param completionBlock 登录操作请求完成后的返回结果
 @return AFHTTPRequestOperation 实例
 */
- (AFHTTPRequestOperation *)userLoginWithUsrMobile:(NSString *)mobile
                                         password:(NSString *)password
                                       completion:(WebAPIResponstComlitionBlock)completionBlock;


/**
 登录用户上传获取到的推送 TOKEN

 @param userId  登录用户ID
 @param token 推送 TOKEN
 @param completionBlock 登录操作请求完成后的返回结果Block
 @return AFHTTPRequestOperation 实例
 */
- (AFHTTPRequestOperation *)userUpdateAPPPushDeviceToken:(NSString *)userId
                                                   token:(NSString *)token
                                              completion:(WebAPIResponstComlitionBlock)completionBlock;



/**
 登录者给俱乐部某部门添加俱乐部管理者

 @param userInfo 管理者用户
 @param completionBlock 登录操作请求完成后的返回结果Block
 @return AFHTTPRequestOperation 实例
 */
- (AFHTTPRequestOperation *)userAddClubAdministarorWithUserInfo:(ClubUserInfo *)userInfo
                                                    completion:(WebAPIResponstComlitionBlock)completionBlock;




/**
 用户根据个人 ID，修改个人信息内容（头像、邮箱、姓名）
 
 @param clubId 用户所在俱乐部信息
 @param userId 用户 ID
 @param info 需要修改的信息
 @param completionBlock 操作 Block
 @return 请求实例
 */
- (AFHTTPRequestOperation *)clubUserEditPersonalInfWithClubId:(NSString *)clubId
                                                       userId:(NSString *)userId
                                                         info:(NSDictionary *)info
                                                   completion:(WebAPIResponstComlitionBlock)completionBlock;




/**
 用户修改个人密码

 @param clubId 用户所在俱乐部 ID
 @param userId 用户 ID
 @param oldPwd 旧密码
 @param newPwd 新密码
 @param completionBlock 操作 Block
 @return 请求实例
 */
- (AFHTTPRequestOperation *)clubUserUpdatePersonalPasswordWithClubId:(NSString *)clubId
                                                              userId:(NSString *)userId
                                                                 old:(NSString *)oldPwd
                                                                 new:(NSString *)newPwd
                                                          completion:(WebAPIResponstComlitionBlock)completionBlock;
@end
