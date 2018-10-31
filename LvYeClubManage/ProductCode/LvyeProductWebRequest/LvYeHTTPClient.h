//
//  LvYeHTTPClient.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/10.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFNetworking.h"
#import "LvYeWebAPIDefine.h"
#import "WebAPIResponse.h"

//定义网络错误提示信息
#define NETERROR_LOADERR_TIP            @"读取失败,网络异常"


#define KShareHTTPLvyeHTTPClient [LvYeHTTPClient shareLvYeHTTPClient]

typedef void(^WebAPIResponstComlitionBlock) (WebAPIResponse *response);

@interface LvYeHTTPClient : AFHTTPClient


+ (LvYeHTTPClient *)shareLvYeHTTPClient;

/**
 AFHTTP GET 请求操作

 @param path 接口名
 @param parameters 参数字典
 @param completionBlock  JSON 数据内容
 @return 请求线程
 */
- (AFHTTPRequestOperation *)getPath:(NSString *)path
                         parameters:(NSDictionary *)parameters
                         completion:(WebAPIResponstComlitionBlock)completionBlock;

/**
 *
 * AFHTTP POST 请求操作
 
 @param path 接口名
 @param parameters 参数字典
 @param completionBlock  JSON 数据内容
 @return 请求线程
 */
- (AFHTTPRequestOperation *)postPath:(NSString *)path
                          parameters:(NSDictionary *)parameters
                          completion:(WebAPIResponstComlitionBlock)completionBlock;


@end
