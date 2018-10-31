//
//  ClubModelEnumKit.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/17.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#ifndef ClubModelEnumKit_h
#define ClubModelEnumKit_h


/**
 俱乐部用户性别

 - ClubUserGenderDefineStyle:  俱乐部用户性别
 */
typedef NS_ENUM(NSInteger,ClubUserGenderStyle){
    
    ClubUserGenderDefineStyle = 0,              /**< = 0 默认性别：男*/
    ClubUserGenderMaleStyle = 0,                /**< = 0 性别：男*/
    ClubUserGenderFemaleStyle = 1,              /**< = 1 性别：女*/
};

/**
 俱乐部绑定卡类别

 - ClubBankPersoanlStyle: 个人账户
 */
typedef NS_ENUM(NSInteger,ClubBankStyle){
    ClubBankPublicStyle = 0,                    /**< = 0 对公账户*/
    ClubBankPersoanlStyle = 1,                  /**< = 1 个人账户*/
};

/**
 俱乐部订单支付方式

 - ClubOrderPayForAliPayStyle: 马云Pay
 - ClubOrderPaylWeChatPayStyle：马化腾Pay
 */
typedef NS_ENUM(NSInteger,ClubOrderPayStyle){
    ClubOrderPayForAliPayStyle = 6,                    /**< = 6 支付宝支付*/
    ClubOrderPaylWeChatPayStyle = 7,                  /**< = 7 微信支付*/
};


/**
 订单下单来源

 - ClubOrderConsultForMobileClientStyle: 手机移动站 m.lvye.com
 - ClubOrderConsultForPCClientStyle: PC 网页站 lvye.com
 - ClubOrderConsultForH5APPClientStyle: H5 六只脚 APP
 */
typedef NS_ENUM(NSInteger,ClubOrderConsultStyle) {
    ClubOrderConsultForMobileClientStyle = 3,
    ClubOrderConsultForPCClientStyle = 73,
    ClubOrderConsultForH5APPClientStyle = 88,
    ClubOrderConsultForBToBClientStyle = 65,
};


/**
 用户证件类型

 - ClubUserCardForIdentityCardStyle: 身份证
 - ClubUserCardForOfficerStyle: 军官证
 - ClubUserCardForPassportStyle: 护照
 - ClubUserCardForOtherStyle: 身份证
 */
typedef  NS_ENUM(NSInteger,ClubUserCardStyle) {
    ClubUserCardForIdentityCardStyle = 1,
    ClubUserCardForOfficerStyle = 2,
    ClubUserCardForPassportStyle = 3,
    ClubUserCardForOtherStyle = 1,
};

#endif /* ClubModelEnumKit_h */
