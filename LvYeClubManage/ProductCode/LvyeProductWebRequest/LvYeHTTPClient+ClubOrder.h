//
//  LvYeHTTPClient+ClubOrder.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/11.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvYeHTTPClient.h"



/**
 俱乐部订单管理
 */
@interface LvYeHTTPClient (ClubOrder)



/**
 俱乐部订单管理列表接口

 @param clubId 俱乐部 ID
 @param orderStyle  订单支付情况
 @param operstionStyle 用户操作情况
 @param key 查询内容
 @param pageSize 页面大小
 @param number 当前页面
 @param completionBlock 查询操作 Block
 @return 查询
 */
- (AFHTTPRequestOperation *)clubOrderForOrderManageListInforWithClubId:(NSString *)clubId
                                                            orderStyle:(NSString *)orderStyle
                                                        operationStyle:(NSString *)operstionStyle
                                                             searchKey:(NSString *)key
                                                              pageSize:(NSInteger)pageSize
                                                            pageNumber:(NSInteger)number
                                                            completion:(WebAPIResponstComlitionBlock)completionBlock;

/**
 俱乐部订单管理--活动详情接口
 
 @param clubId 俱乐部 ID
 @param orderNum  订单编号
 @param completionBlock 查询操作 Block
 @return 查询
 */
- (AFHTTPRequestOperation *)clubOrderForOrderManageItemOrderDetailInforWithClubId:(NSString *)clubId
                                                                      orderNumber:(NSString *)orderNum
                                                                       completion:(WebAPIResponstComlitionBlock)completionBlock;
@end
