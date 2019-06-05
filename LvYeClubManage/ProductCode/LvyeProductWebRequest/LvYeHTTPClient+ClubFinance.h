//
//  LvYeHTTPClient+ClubFinance.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/11.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvYeHTTPClient.h"


/**
 俱乐部财务管理
 */
@interface LvYeHTTPClient (ClubFinance)

//TODO:账单记录接口内容


/**
 查询俱乐部的账单记录列表

 @param clubId 俱乐部 ID
 @param userId  用户 ID
 @param orderNumber 订单号
 @param tourId 线路编号
 @param tourName 线路名字
 @param state 账单状态
 @param pageSize  页面大小
 @param number 当前页面
 @param completionBlock 请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubShowClubBillInfoWithClubId:(NSString *)clubId
                                                    userId:(NSString *)userId
                                                  orderNum:(NSString *)orderNumber
                                                    tourId:(NSString *)tourId
                                                  tourName:(NSString *)tourName
                                                     state:(NSString *)state
                                                  pageSize:(NSInteger)pageSize
                                                pageNumber:(NSInteger)number
                                                completion:(WebAPIResponstComlitionBlock)completionBlock;


/**
 俱乐部用户申请结算操作

 @param clubId 俱乐部 ID
 @param userId  用户 ID
 @param orderNumber 订单号
 @param completionBlock 请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubUserApplySettleOperationWithClubId:(NSString *)clubId
                                                            userId:(NSString *)userId
                                                          orderNum:(NSString *)orderNumber
                                                        completion:(WebAPIResponstComlitionBlock)completionBlock;


//TODO:结算记录接口内容


/**
 根据俱乐部信息及查询条件，获取该俱乐部的结算记录内容

 @param clubId 俱乐部 ID
 @param userId  用户 ID
 @param billNum 结算单号
 @param state 账单状态
 @param addTime 添加时间
 @param pageSize  页面大小
 @param number 当前页面
 @param completionBlock 请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubShowClubBillsettleUpListWithClubId:(NSString *)clubId
                                                            userId:(NSString *)userId
                                                           billNum:(NSString *)billNum
                                                             state:(NSString *)state
                                                           addTime:(NSString *)addTime
                                                          pageSize:(NSInteger)pageSize
                                                        pageNumber:(NSInteger)number
                                                        completion:(WebAPIResponstComlitionBlock)completionBlock;

/**
 根据俱乐部 ID 和结算单 ID，获取该结算单下的全部账单记录信息
 
 @param clubId 俱乐部 ID
 @param billNum 结算单号
 @param completionBlock 请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubShowClubBillSettleDetailWithBillNum:(NSString *)billNum
                                                             clubId:(NSString *)clubId
                                                         completion:(WebAPIResponstComlitionBlock)completionBlock;


//TODO: 资金管理内容接口
/**
 获取俱乐部已经完成提现操作的数据内容

 @param clubId 俱乐部 ID
 @param userId  用户 ID
 @param pageSize  页面大小
 @param number 当前页面
 @param completionBlock 请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubOperationFinishWithdrawListWithClubId:(NSString *)clubId
                                                               userId:(NSString *)userId
                                                             pageSize:(NSInteger)pageSize
                                                           pageNumber:(NSInteger)number
                                                           completion:(WebAPIResponstComlitionBlock)completionBlock;



/**
 俱乐部资金管理中，账户资金池中资金剩余情况

 @param clubId 俱乐部 Id
 @param completionBlock 请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubCapitalAccountCapitalShowWithClubId:(NSString *)clubId
                                                         completion:(WebAPIResponstComlitionBlock)completionBlock;

/**
 获取俱乐部提现规则说明信息

 @param clubId 俱乐部 ID
 @param completionBlock 请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubOperationWithdrawRulesWithClubId:(NSString *)clubId
                                                      completion:(WebAPIResponstComlitionBlock)completionBlock;


/**
 获取当前俱乐部可以进行提现的金额信息
 
 @param clubId 当前俱乐部
 @param userId 当前用户 ID
 @param completionBlock 请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubCanDepositFundsInfowWithClubId:(NSString *)clubId
                                                        userId:(NSString *)userId
                                                    completion:(WebAPIResponstComlitionBlock)completionBlock;


/**
  俱乐部用户进行提现操作

 @param clubId 俱乐部 ID
 @param userId 用户 ID
 @param amount  提现金额
 @param cardId 俱乐部的银行卡卡编号
 @param completionBlock 请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubUserWithdrawOperaWithClubId:(NSString *)clubId
                                                     userId:(NSString *)userId
                                                     amount:(NSString *)amount
                                                     cardId:(NSString *)cardId
                                                 completion:(WebAPIResponstComlitionBlock)completionBlock;

/**
 获取俱乐部可以绑定的银行信息
 
 @param completionBlock 请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubCanConnectBankInfoCompletion:(WebAPIResponstComlitionBlock)completionBlock;


/**
 获取俱乐部绑定过的银行卡信息
 
 @param clubId 俱乐部 ID
 @param completionBlock  请求完成后返回的数据内容 Block
 @return 网络请求实例
 */
- (AFHTTPRequestOperation *)clubConnectedBankInfoWithClubId:(NSString *)clubId
                                                 completion:(WebAPIResponstComlitionBlock)completionBlock;

@end
