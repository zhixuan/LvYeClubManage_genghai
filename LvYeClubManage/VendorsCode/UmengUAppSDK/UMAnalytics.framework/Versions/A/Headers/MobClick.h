//
//  MobClick.h
//  Analytics
//
//  Copyright (C) 2010-2017 Umeng.com . All rights reserved.

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^CallbackBlock)(void);

/**
 统计的场景类别，默认为普通统计；若使用游戏统计API，则需选择游戏场景类别，如E_UM_GAME。
 */
typedef NS_ENUM (NSUInteger, eScenarioType)
{
    E_UM_NORMAL = 0,    // default value
    E_UM_GAME   = 1,    // game
    E_UM_DPLUS  = 4    // DPlus
};

@class CLLocation;
@interface MobClick : NSObject <UIAlertViewDelegate>

#pragma mark basics

///---------------------------------------------------------------------------------------
/// @name  设置
///---------------------------------------------------------------------------------------

/** 设置 统计场景类型，默认为普通应用统计：E_UM_NORMAL
 @param eSType 游戏统计必须设置为：E_UM_GAME.
 */
+ (void)setScenarioType:(eScenarioType)eSType;

/** 开启CrashReport收集, 默认YES(开启状态).
 @param value 设置为NO,可关闭友盟CrashReport收集功能.
*/
+ (void)setCrashReportEnabled:(BOOL)value;

#pragma mark event logs
///---------------------------------------------------------------------------------------
/// @name  页面计时
///---------------------------------------------------------------------------------------

/** 手动页面时长统计, 记录某个页面展示的时长.
 @param pageName 统计的页面名称.
 @param seconds 单位为秒，int型.
 */
+ (void)logPageView:(NSString *)pageName seconds:(int)seconds;

/** 自动页面时长统计, 开始记录某个页面展示时长.
 使用方法：必须配对调用beginLogPageView:和endLogPageView:两个函数来完成自动统计，若只调用某一个函数不会生成有效数据。
 在该页面展示时调用beginLogPageView:，当退出该页面时调用endLogPageView:
 @param pageName 统计的页面名称.
 */
+ (void)beginLogPageView:(NSString *)pageName;

/** 自动页面时长统计, 结束记录某个页面展示时长.
 使用方法：必须配对调用beginLogPageView:和endLogPageView:两个函数来完成自动统计，若只调用某一个函数不会生成有效数据。
 在该页面展示时调用beginLogPageView:，当退出该页面时调用endLogPageView:
 @param pageName 统计的页面名称.
 */
+ (void)endLogPageView:(NSString *)pageName;


///---------------------------------------------------------------------------------------
/// @name  事件统计
///---------------------------------------------------------------------------------------

/** 自定义事件,数量统计.
使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID
 
 @param  eventId 网站上注册的事件Id.
 */
+ (void)event:(NSString *)eventId; //等同于 event:eventId label:eventId;
/** 自定义事件,数量统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID
 */
+ (void)event:(NSString *)eventId label:(NSString *)label; // label为nil或@""时，等同于 event:eventId label:eventId;

/** 自定义事件,数量统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID
 */
+ (void)event:(NSString *)eventId attributes:(NSDictionary *)attributes;

+ (void)event:(NSString *)eventId attributes:(NSDictionary *)attributes counter:(int)number;

/** 自定义事件,时长统计.
    使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
    beginEvent,endEvent要配对使用,也可以自己计时后通过durations参数传递进来
 
 @param  eventId 网站上注册的事件Id.

 @warning 每个event的attributes不能超过10个
    eventId、attributes中key和value都不能使用空格和特殊字符，必须是NSString,且长度不能超过255个字符（否则将截取前255个字符）
    id， ts， du是保留字段，不能作为eventId及key的名称
*/
+ (void)beginEvent:(NSString *)eventId;

/** 自定义事件,时长统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
 */

+ (void)endEvent:(NSString *)eventId;
/** 自定义事件,时长统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
 */

+ (void)beginEvent:(NSString *)eventId label:(NSString *)label;
/** 自定义事件,时长统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
 */

+ (void)endEvent:(NSString *)eventId label:(NSString *)label;
/** 自定义事件,时长统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
 */

+ (void)beginEvent:(NSString *)eventId primarykey :(NSString *)keyName attributes:(NSDictionary *)attributes;
/** 自定义事件,时长统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
 */

+ (void)endEvent:(NSString *)eventId primarykey:(NSString *)keyName;
/** 自定义事件,时长统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
 */

+ (void)event:(NSString *)eventId durations:(int)millisecond;
/** 自定义事件,时长统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
 */

+ (void)event:(NSString *)eventId label:(NSString *)label durations:(int)millisecond;
/** 自定义事件,时长统计.
 使用前，请先到友盟App管理后台的设置->编辑自定义事件 中添加相应的事件ID，然后在工程中传入相应的事件ID.
 */
+ (void)event:(NSString *)eventId attributes:(NSDictionary *)attributes durations:(int)millisecond;


#pragma mark - user methods
/** active user sign-in.
 使用sign-In函数后，如果结束该PUID的统计，需要调用sign-Off函数
 @param puid : user's ID
 */
+ (void)profileSignInWithPUID:(NSString *)puid;
/** active user sign-in.
 使用sign-In函数后，如果结束该PUID的统计，需要调用sign-Off函数
 @param puid : user's ID
 @param provider : 不能以下划线"_"开头，使用大写字母和数字标识; 如果是上市公司，建议使用股票代码。
 */
+ (void)profileSignInWithPUID:(NSString *)puid provider:(NSString *)provider;

/** active user sign-off.
 停止sign-in PUID的统计
 */
+ (void)profileSignOff;

///---------------------------------------------------------------------------------------
/// @name 地理位置设置
/// 需要链接 CoreLocation.framework 并且 #import <CoreLocation/CoreLocation.h>
///---------------------------------------------------------------------------------------

/** 设置经纬度信息
 @param latitude 纬度.
 @param longitude 经度.
 */
+ (void)setLatitude:(double)latitude longitude:(double)longitude;

/** 设置经纬度信息
 @param location CLLocation 经纬度信息
 */
+ (void)setLocation:(CLLocation *)location;

///---------------------------------------------------------------------------------------
/// @name Utility函数
///---------------------------------------------------------------------------------------

/** 判断设备是否越狱，依据是否存在apt和Cydia.app
 */
+ (BOOL)isJailbroken;

/** 判断App是否被破解
 */
+ (BOOL)isPirated;

/** 设置 app secret
 @param secret string
 */
+ (void)setSecret:(NSString *)secret;

+ (void)setCrashCBBlock:(CallbackBlock)cbBlock;

/** DeepLink事件
 @param link 唤起应用的link
 */
+ (void)onDeepLinkReceived:(NSURL *)link;

@end
