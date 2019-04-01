//
//  LvyeFunctions.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/10.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//


#ifndef LvyeFunctions_h
#define LvyeFunctions_h

#if defined __cplusplus
extern "C" {
#endif
    

    
/***以 C 函数格式，定义宏函数  ***/
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "HUILoadMoreCell.h"
    
    
#pragma mark - JSON
    //将键-值对加入字典。会剔除object或key或dic为nil的情况
    extern void AddObjectForKeyIntoDictionary(id object, id key, NSMutableDictionary *dic);
    
    //从反JSON序列化后的字典里面读取Key对应的对象。 如果对象为NSString对象并且是@"", 会返回nil
    extern id ObjForKeyInUnserializedJSONDic(NSDictionary *unserializedJSONDic, id key);
    
    //从反JSON序列化后的字典里面读取Key对应的String,不是String的数据则进行转换
    extern NSString* StringForKeyInUnserializedJSONDic(NSDictionary *unserializedJSONDic, id key);
    
    //从反JSON序列化后的字典里面读取Key对应的CGFloat,不是CGFloat的数据则进行转换
    extern float FloatForKeyInUnserializedJSONDic(NSDictionary *unserializedJSONDic, id key);
    
    //从反JSON序列化后的字典里面读取Key对应的double,不是double的数据则进行转换
    extern double DoubleForKeyInUnserializedJSONDic(NSDictionary *unserializedJSONDic, id key);
    
    //从反JSON序列化后的字典里面读取Key对应的NSInteger,不是NSInteger的数据则进行转换
    extern NSInteger IntForKeyInUnserializedJSONDic(NSDictionary *unserializedJSONDic, id key);
    
    //从反JSON序列化后的字典里面读取Key对应的Boolean,不是Boolean的数据则进行转换
    extern Boolean BoolForKeyInUnserializedJSONDic(NSDictionary *unserializedJSONDic, id key);
    
    
#pragma mark -MD5加密
    extern NSString* EncryptPassword(NSString *str);
    
#pragma mark -判断是否为空
    extern Boolean IsStringEmptyOrNull(NSString * str);
    
#pragma mark -时间函数
    extern NSString *timeShortDesc(double localAddTime);
    
#pragma mark -是否为手机号
    extern Boolean IsNormalMobileNum(NSString  *userMobileNum);
#pragma mark - 判断是否为合法的含两位2小数的资金金额内容
    extern Boolean isValidateMoney(NSString *money);
    
    
#pragma mark -Image TOOL
    extern UIImage* createImageWithColor(UIColor *color);
    extern UIColor* colorAddAlpha(UIColor* color,CGFloat alpha);
    /**
     输入错误提示
     @param errorString *errorString 错误提示信息
     @See 返回一个对话框，且无标题，仅有错误提示内容和一个确定操作按键
     */
    extern void ShowImportErrorAlertView(NSString *errorString);
#pragma mark - RandString
    ///生成固定位数的随机字符串
    extern NSString* generateRandStringWithBity(int numberCount);
    
    
#pragma mark -MBProgressHUD
    extern void ShowAutoHideMBProgressHUD(UIView *onView, NSString *labelText);
    extern void ShowIMAutoHideMBProgressHUD(UIView *onView, NSString *labelText);
    extern void ShowAutoHideMBProgressHUDWithOneSec(UIView *onView, NSString *labelText);
    extern void WaittingMBProgressHUD(UIView *onView, NSString *labelText);
    extern void SuccessMBProgressHUD(UIView *onView, NSString *labelText);
    extern void FailedMBProgressHUD(UIView *onView, NSString *labelText);
    extern void FinishMBProgressHUD(UIView *onView);
#pragma mark -PullToRefreshView
    extern void UpdateLastRefreshDataForPullToRefreshViewOnView(UIScrollView *view);
    extern void ConfiguratePullToRefreshViewAppearanceForScrollView(UIScrollView *view);
#pragma mark -LoadMoreCell
    extern HUILoadMoreCell* CreateLoadMoreCell(void);
    //生成固定位数的随机字符串
    extern NSString * getranAutoImageName(int numberCount);
    
    
    /**
     根据固定格式格式化为时间字符串

     @param intformate 输入时间格式
     @param outFormate 输出时间格式
     @param dateStr 需要格式化的时间字符串
     @return 格式化后的时间字符串
     */
    extern NSString *formatDateWithFormat(NSString  *intformate,NSString  *outFormate,NSString *dateStr);

#if defined __cplusplus
};
#endif


#endif
