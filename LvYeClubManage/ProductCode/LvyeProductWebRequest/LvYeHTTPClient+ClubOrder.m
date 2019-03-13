//
//  LvYeHTTPClient+ClubOrder.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/11.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvYeHTTPClient+ClubOrder.h"



@implementation LvYeHTTPClient (ClubOrder)

#pragma mark -
#pragma mark -  俱乐部订单管理列表接口
- (AFHTTPRequestOperation *)clubOrderForOrderManageListInforWithClubId:(NSString *)clubId
                                                            orderStyle:(NSString *)orderStyle
                                                        operationStyle:(NSString *)operstionStyle
                                                             searchKey:(NSString *)key
                                                              pageSize:(NSInteger)pageSize
                                                            pageNumber:(NSInteger)number
                                                            completion:(WebAPIResponstComlitionBlock)completionBlock{
    
    if (clubId ==nil || [clubId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubID:clubId,
                            @"orderState":orderStyle,
                            KDataKeyPageSize:[NSNumber numberWithInteger:pageSize],
                            KDataKeyPageNumber:[NSNumber numberWithInteger:number]};
    
    
    return [self getPath:KURLClubOrderList parameters:param completion:completionBlock];
}


#pragma mark -
#pragma mark -  俱乐部订单管理--活动详情接口
- (AFHTTPRequestOperation *)clubOrderForOrderManageItemOrderDetailInforWithClubId:(NSString *)clubId
                                                                      orderNumber:(NSString *)orderNum
                                                                       completion:(WebAPIResponstComlitionBlock)completionBlock{
    if (clubId ==nil || [clubId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    if(orderNum ==nil || [orderNum length] < 10){
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubID:clubId,
                            KDataKeyOrderNumber:orderNum,};
    
    http://localhost:8999/clubOrder/itemOrderInfo?clubID=1784&orderNumber=1784s157y102257316
    return [self getPath:KURLClubOrderItemOrderDetail parameters:param completion:completionBlock];
}
@end
