//
//  LvYeHTTPClient+ClubFinance.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/11.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvYeHTTPClient+ClubFinance.h"

@implementation LvYeHTTPClient (ClubFinance)



#pragma mark -
#pragma mark -  查询俱乐部的账单记录列表
- (AFHTTPRequestOperation *)clubShowClubBillInfoWithClubId:(NSString *)clubId
                                                    userId:(NSString *)userId
                                                  orderNum:(NSString *)orderNumber
                                                    tourId:(NSString *)tourId
                                                  tourName:(NSString *)tourName
                                                     state:(NSString *)state
                                                  pageSize:(NSInteger)pageSize
                                                pageNumber:(NSInteger)number
                                                completion:(WebAPIResponstComlitionBlock)completionBlock{
    NSDictionary *param = @{KDataKeyClubID:clubId,
                            KDataKeyUserId:userId,
                            KDataKeyPageSize:[NSNumber numberWithInteger:pageSize],
                            KDataKeyPageNumber:[NSNumber numberWithInteger:number]};
    
    return [self getPath:KURLClubBillRecordListURL parameters:param completion:completionBlock];
}


///KURLClubSettleAccountsAddOperURL
- (AFHTTPRequestOperation *)clubUserApplySettleOperationWithClubId:(NSString *)clubId
                                                            userId:(NSString *)userId
                                                            billId:(NSString *)billIds orderCount:(NSInteger)count
                                                        completion:(WebAPIResponstComlitionBlock)completionBlock{
    
    NSDictionary *param = @{KDataKeyClubID:clubId,
                            KDataKeyUserId:userId,
                            @"billCheckIds":billIds,
                            @"orderCount":[NSNumber numberWithInteger:count]
                            };
     return [self postPath:KURLClubSettleAccountsAddOperURL parameters:param completion:completionBlock];
}


//TODO:结算记录接口内容
#pragma mark -
#pragma mark -  根据俱乐部信息及查询条件，获取该俱乐部的结算记录内容
- (AFHTTPRequestOperation *)clubShowClubBillsettleUpListWithClubId:(NSString *)clubId
                                                            userId:(NSString *)userId
                                                           billNum:(NSString *)billNum
                                                             state:(NSString *)state
                                                           addTime:(NSString *)addTime
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
                            KDataKeyUserId:userId,
                            KDataKeyPageSize:[NSNumber numberWithInteger:pageSize],
                            KDataKeyPageNumber:[NSNumber numberWithInteger:number]};
    
    return [self getPath:KURLClubSettleAccountsRecordListURL parameters:param completion:completionBlock];
}

#pragma mark -
#pragma mark -  根据俱乐部 ID 和结算单 ID，获取该结算单下的全部账单记录信息
- (AFHTTPRequestOperation *)clubShowClubBillSettleDetailWithBillNum:(NSString *)billNum
                                                             clubId:(NSString *)clubId
                                                         completion:(WebAPIResponstComlitionBlock)completionBlock{
    if (clubId ==nil || [clubId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubID:clubId,
                            @"billCheckNum":billNum,};
    
    return [self getPath:KURLClubSettleItemRecordDetailURL parameters:param completion:completionBlock];
}
//TODO: 资金管理内容接口

#pragma mark -
#pragma mark -  获取俱乐部已经完成提现操作的数据内容
- (AFHTTPRequestOperation *)clubOperationFinishWithdrawListWithClubId:(NSString *)clubId
                                                               userId:(NSString *)userId
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
                            KDataKeyUserId:userId,
                            KDataKeyPageSize:[NSNumber numberWithInteger:pageSize],
                            KDataKeyPageNumber:[NSNumber numberWithInteger:number]};
    
    return [self getPath:KURLClubWithdrawListURL parameters:param completion:completionBlock];
}


#pragma mark -
#pragma mark -  俱乐部资金管理中，账户资金池中资金剩余情况
- (AFHTTPRequestOperation *)clubCapitalAccountCapitalShowWithClubId:(NSString *)clubId
                                                         completion:(WebAPIResponstComlitionBlock)completionBlock{
    
    if (clubId ==nil || [clubId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubID:clubId,};
    
    return [self getPath:KURLClubCapitalShowURL parameters:param completion:completionBlock];
}

#pragma mark -
#pragma mark -  获取俱乐部提现规则说明信息
- (AFHTTPRequestOperation *)clubOperationWithdrawRulesWithClubId:(NSString *)clubId
                                                      completion:(WebAPIResponstComlitionBlock)completionBlock{
    return nil;
}


#pragma mark -
#pragma mark -  获取当前俱乐部可以进行提现的金额信息
- (AFHTTPRequestOperation *)clubCanDepositFundsInfowWithClubId:(NSString *)clubId
                                                        userId:(NSString *)userId
                                                    completion:(WebAPIResponstComlitionBlock)completionBlock{
    if (clubId ==nil || [clubId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubID:clubId,
                            KDataKeyUserId:userId };
    
    return [self getPath:KURLClubCanWithdrawURL parameters:param completion:completionBlock];
}


#pragma mark -
#pragma mark -   俱乐部用户进行提现操作
- (AFHTTPRequestOperation *)clubUserWithdrawOperaWithClubId:(NSString *)clubId
                                                     userId:(NSString *)userId
                                                     amount:(NSString *)amount
                                                     cardId:(NSString *)cardId
                                                 completion:(WebAPIResponstComlitionBlock)completionBlock{
    if (clubId ==nil || [clubId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubID:clubId,
                            KDataKeyUserId:userId,
                            @"amount":amount,
                            @"clubCardId":cardId};
    
    return [self getPath:KURLClubWithdrawOperaURL parameters:param completion:completionBlock];
}

#pragma mark -
#pragma mark -   获取俱乐部可以绑定的银行信息
- (AFHTTPRequestOperation *)clubCanConnectBankInfoCompletion:(WebAPIResponstComlitionBlock)completionBlock{
    
    return [self getPath:KURLClubAllBankURL parameters:nil completion:completionBlock];
}


#pragma mark -
#pragma mark -  获取俱乐部绑定过的银行卡信息
- (AFHTTPRequestOperation *)clubConnectedBankInfoWithClubId:(NSString *)clubId
                                                 completion:(WebAPIResponstComlitionBlock)completionBlock{
    if (clubId ==nil || [clubId length] < 1) {
        if (completionBlock) {
            completionBlock([WebAPIResponse invalidArgumentsResonse]);
        }
        return nil;
    }
    
    NSDictionary *param = @{KDataKeyClubID:clubId};
    
    return [self getPath:KURLClubConnectedBankURL parameters:param completion:completionBlock];
}

@end
