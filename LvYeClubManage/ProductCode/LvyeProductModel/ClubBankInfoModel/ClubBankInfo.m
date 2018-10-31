//
//  ClubBankInfo.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/11.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubBankInfo.h"

@implementation ClubBankInfo

- (id)init{
    self = [super init];
    if (self) {
        self.clubBankAccounStyle = ClubBankPublicStyle;
    }
    return self;
}

+ (ClubBankInfo *)initClubBankInfoWithUnserializedJSONDic:(NSDictionary *)dic{
    ClubBankInfo *bankInfo = [[ClubBankInfo alloc] init];
    if(dic ==nil || [dic count] < 1){
        return bankInfo;
    }
    
    [bankInfo setBankInfoId:StringForKeyInUnserializedJSONDic(dic, @"club_bank_id")];
    [bankInfo setBankSourceName:StringForKeyInUnserializedJSONDic(dic, @"bank_name")];
    
    
    [bankInfo setClubAccountTitle:StringForKeyInUnserializedJSONDic(dic, @"account_title")];
    [bankInfo setClubBankAccounStyle:IntForKeyInUnserializedJSONDic(dic, @"accounts_type")];
    [bankInfo setClubOpeningBankName:StringForKeyInUnserializedJSONDic(dic, @"opening_bank")];
    [bankInfo setClubOpeningUserName:StringForKeyInUnserializedJSONDic(dic, @"account_title")];
    [bankInfo setClubBankCardCode:StringForKeyInUnserializedJSONDic(dic, @"bank_card_code")];
    
//    NSNumber
    NSLog(@"bankInfo.clubBankAccounStyle is %@",bankInfo.clubBankCardCode);
    
    return bankInfo;
}
@end
