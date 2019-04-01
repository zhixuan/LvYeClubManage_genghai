//
//  WebAPIResponse.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/10.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>



#define kCodeNameOnServer               @"code"
#define kCodeDescriptionNameOnServer    @"RetValue"

#pragma mark -WebAPIResponseCode(服务器WebAPI响应状态代码)
#pragma mark - 自定义 CodeSuccess 操作状态码，或100，或200
//From: 服务器端下发文档
typedef NS_ENUM(NSInteger, WebAPIResponseCode)
{
    WebAPIResponseCodeNetError              = 0,            /**< 网络请求错误 */
    WebAPIResponseCodeParamError            = 1,            /**< 请求参数错误 */
    WebAPIResponseCodeSuccess               = 100,          /**< = 100,服务器返回成功 */
    WebAPIResponseCodeTokenError            = 140,          /**< 帐号信息验证失败（token验证失败）*/
    WebAPIResponseCodeUserError             = 141,          /**< 账户或者密码错误*/
    WebAPIResponseCodeFailed                = 200,          /**< = 200,服务器返回失败*/
    WebAPIResponseCodeResourcesError        = 144,          /**< 请求的资源不存在或者无法找到该服务*/
    WebAPIResponseCodeLoginedError          = 146,          /**< 该账户已在其他终端登录*/
    WebAPIResponseCodeNOSpeakError          = 147,          /**< 该账户禁止发言*/
    WebAPIResponseCodeTitleRecurError       = 148,          /**< 话题的标题或者内容和上一条重复*/
    WebAPIResponseCodeAnsweRecurError       = 149,          /**< 话题回复的内容和上一条重复*/
    WebAPIResponseCodeForceUpdateError      = 600,          /**< 强制用户进行升级操作处理*/
    WebAPIResponseCodeBusinessError         = 504           /**< 业务逻辑或业务信息错误*/
};

@interface WebAPIResponse : NSObject

#pragma mark -
#pragma mark -  属性
/*!
 * @breif 返回信息状态码 \ref 表示API操作的结果状态, 见WebAPIResponseCode
 * code:状态码
 */
@property (nonatomic , assign)      WebAPIResponseCode          code;

/*!
 * @breif 状态码说明信息 \ref 是对code的解释说明.
 * codeDescription:    文本内容几乎都是由服务器端返回
 */
@property (nonatomic , strong)      NSString                    *codeDescription;

/*!
 * @breif 服务器返回的数据对象 \ref 服务器返回的数据对象
 * responseObject:    服务器返回的数据对象
 */
@property (nonatomic , strong)      NSDictionary                *responseObject;

#pragma mark -
#pragma mark -  操作方法

/**
返回code==WebAPIResponseCodeSuccess的WebAPIResponseCode对象

 @return WebAPIResponseCode对象
 */
+ (id)successedResponse;

/**
 invalidArgumentsResonse
 返回code==WebAPIResponseCodeParamError的WebAPIResponseCode对象
 */
+ (id)invalidArgumentsResonse;
+ (id)responseWithCode:(WebAPIResponseCode)code;
+ (id)responseWithCode:(WebAPIResponseCode)code description:(NSString *)codeDescription;
+ (id) responseWithImageURL:(NSString *)url;
/**
 根据返回JSON数据，构建response

 @param returnData 网络请求得到的数据信息
 @return WebAPIResponseCode对象
 */
+ (id)responseWithUnserializedJSONDic:(id)returnData;


@end
