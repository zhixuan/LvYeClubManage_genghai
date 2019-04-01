//
//  LvYeWebAPIDefine.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/10.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#ifndef LvYeWebAPIDefine_h
#define LvYeWebAPIDefine_h

//#define KEY_LVYE_API_URL                        @"http://114.55.107.181:8999/"
//#define KEY_LVYE_API_URL                        @"http://192.168.24.62:8999/"
//#define KEY_LVYE_WEB_RESPONSE_URL               KEY_LVYE_API_URL
//#define KEY_LVYE_API_URL_TEST                   KEY_LVYE_API_URL
//#define KEY_LVYE_WEB_RESPONSE_URL_TEST          KEY_LVYE_API_URL
//
//#define KEY_LVYE_API_URL_TEST                   @"http://192.168.24.47:8999/"
//#define KEY_LVYE_WEB_RESPONSE_URL_TEST          @"http://192.168.24.47:8999/"
//
//#define KEY_LVYE_API_URL                        @"http://192.168.24.47:8999/"
//#define KEY_LVYE_WEB_RESPONSE_URL               @"http://192.168.24.47:8999/"
//




/////正式环境
#define KEY_LVYE_API_URL_TEST                   @"http://club.lvye.com:8999/"
#define KEY_LVYE_WEB_RESPONSE_URL_TEST          @"http://club.lvye.com:8999/"



///正式环境数据内容
//#define KEY_LVYE_API_URL                        @"http://192.168.24.74:8999/"
#define KEY_LVYE_API_URL                        @"http://club.lvye.com:8999/"
#define KEY_LVYE_WEB_RESPONSE_URL               KEY_LVYE_API_URL


#define KEY_RESPONSE_LVYE_IMAGE_URL             @"http://res.lvye.com/"
#define KEY_RESPONSE_LVYE_CLUB_IMAGE_URL        @"http://club.lvye.com"


////MARK:常用参数
////常用参数
#pragma mark - common key

#define KDataKeyLanguageKey                     @"lang"
#define KDataKeyLogindeviceId                   @"logindevice"
#define KDataKeyLoginuserId                     @"loginuser"
#define KDataKeyClubId                          @"clubId"
#define KDataKeyClubID                          @"clubID"
#define KDataKeyClubName                        @"clubName"
#define KDataKeyClubPhoto                       @"clubHeader"
#define KDataKeyClubBGImage                     @"clubBGImage"

#define KDataKeyPageSize                        @"pageSize"
#define KDataKeyPageNumber                      @"pageNo"

#define KDataKeyLeaderId                        @"leaderId"
#define KDataKeyLeaderName                      @"leaderName"


#define KDataKeyUserId                          @"userId"
#define KDataKeyUserID                          @"userID"
#define KDataKeyUserPwd                         @"password"


#define KDataKeyOrderNumber                     @"orderNumber"
#define KDataKeyOrderNum                        @"orderNum"



////返回数据内容KEY
#define KDataKeyData                            @"data"
#define KDataKeyMsg                             @"message"
#define KDataKeyCode                            @"code"
#define KDataKeyStateFlag                       @"flag"




///MARK:接口信息



#pragma mark -
#pragma mark -  --活动管理接口--
#pragma mark -

//MARK: -活动管理接口-- 领队管理
///俱乐部领队基本信息列表接口
#define KURLClubBaseLeaderInfoURL               @"clubLeader/leaderList"
///俱乐部领队详情接口
#define KURLClubLeaderDetailInfoURL             @"clubLeader/leaderDetail"
///添加领队接口
#define KURLClubLeaderInsertURL                 @"clubLeader/leaderInsert"
///俱乐部领队编辑接口
#define KURLClubLeaderEditURL                   @"clubLeader/leaderUpdate"


#pragma mark -
#pragma mark -  --俱乐部订单管理（俱乐部退款管理）--
#pragma mark -
#define KURLClubOrderList                       @"clubOrder/clubOrderList"
#define KURLClubOrderItemOrderDetail            @"clubOrder/itemOrderInfo"



#pragma mark -
#pragma mark -  --俱乐部管理接口--
#pragma mark -
//TODO:俱乐部管理接口 - 我的评价--
///俱乐部基本信息接口
#define KURLClubBaseInfoURL                     @"clubInfo/info"
///俱乐部评价列表
#define KURLClubCommentListURL                  @"clubShopManage/clubCommentList"






#pragma mark -
#pragma mark -  --财务管理--
#pragma mark -

///MARK:--财务管理--账单记录
///俱乐部账单记录列表
#define KURLClubBillRecordListURL               @"capitalManage/billList"
///俱乐部账单申请结算
#define KURLClubSettleAccountsAddOperURL        @"capitalManage/settleUpList"
///MARK:--财务管理--结算记录
///俱乐部结算单记录列表
#define KURLClubSettleAccountsRecordListURL     @"capitalManage/settleUpList"
///
#define KURLClubSettleItemRecordDetailURL       @"capitalManage/settleUpDetail"

///MARK:--财务管理--资金管理
///用户俱乐部的提现明细列表
#define KURLClubWithdrawListURL                 @"capitalManage/withdrawalDetail"
///俱乐部账户中资金剩余情况
#define KURLClubCapitalShowURL                  @"capitalManage/capitalShow"
///俱乐部可以绑定的全部银行信息
#define KURLClubAllBankURL                      @"capitalManage/bankSpareList"
///俱乐部已经绑定好的银行卡列表
#define KURLClubConnectedBankURL                @"capitalManage/clubBankList"

///俱乐部提现规则
#define KURLClubWithdrawRulesURL                @"capitalManage/withdrawalRules"
///俱乐部财务管理中用户可用于提现的全部资金
#define KURLClubCanWithdrawURL                  @"capitalManage/canWithdrawMoney"
///获取进行提现操作接口
#define KURLClubWithdrawOperaURL                @"capitalManage/withdrawOpera"


#pragma mark -
#pragma mark -  --账户管理--
#pragma mark -

///MARK:--账户管理--机构管理
#define KURLClubAccountPerFunctionURL           @"accountManage/userPerFunction"
///俱乐部中机构管理列表（部门+各部门人员）
#define KURLClubAccountDepartmentUsersURL       @"accountManage/departmentUsers"
///俱乐部中每个俱乐部中各部门列表信息
#define KURLClubAccountDepartmentListURL        @"accountManage/departmentList"
///俱乐部中添加部门操作
#define KURLClubAccountADDDepartmentURL        @"accountManage/addDepartment"
///俱乐部添加管理员
#define KURLClubAccountAddUserURL               @"accountManage/userInfo"


///MARK:用户信息
#define KURLLoginURL                            @"userInfo/login"
#define KURLUpdateTokenURL                      @"userInfo/updateToken"
#define KURLUpdateUserBaseInfoURL               @"userInfo/updateLoginInfo"
#define KURLUpdateUserPasswordURL               @"userInfo/updatePassword"

#endif /* LvYeWebAPIDefine_h */
