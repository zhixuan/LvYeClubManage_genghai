//
//  BankInfo.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/11.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "BankInfo.h"

@implementation BankInfo

- (id)init{
    self = [super init];
    if (self) {
        
    }
    
    return self;
}


+ (BankInfo *)initBankInfoWithUnserializedJSONDic:(NSDictionary *)dic{
    
    BankInfo *bank = [[BankInfo alloc] init];
    if(dic ==nil || [dic count] < 1){
        return bank;
    }
    [bank setBankSourceName:StringForKeyInUnserializedJSONDic(dic, @"bank_name")];
    [bank setBankSourceId:StringForKeyInUnserializedJSONDic(dic, @"bank_id")];
    [bank setBankInfoId:StringForKeyInUnserializedJSONDic(dic, @"bank_id")];
    return bank;
}
@end
