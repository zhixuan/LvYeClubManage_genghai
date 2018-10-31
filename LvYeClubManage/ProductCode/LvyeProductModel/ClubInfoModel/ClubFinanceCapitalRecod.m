//
//  ClubFinanceCapitalRecod.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/27.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubFinanceCapitalRecod.h"

@implementation ClubFinanceCapitalRecod


- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
    
}

#pragma mark -
#pragma mark -  初始化资金管理中列表数据（包括入账数据，出账数据（手续费、提现信息）等）
+ (ClubFinanceCapitalRecod *)initClubFinanceCapitalRecodWithUnserializedJSONDic:(NSDictionary *)dic{
    
    ClubFinanceCapitalRecod *itemRecod = [[ClubFinanceCapitalRecod alloc]init];
    [itemRecod setCapitalUserName:StringForKeyInUnserializedJSONDic(dic, @"user_name")];
    [itemRecod setCapitalDepositId:StringForKeyInUnserializedJSONDic(dic, @"club_deposit_id")];
    [itemRecod setCapitalRecodNumber:StringForKeyInUnserializedJSONDic(dic, @"bill_check_number")];
    [itemRecod setCapitalMoneyCotnent:StringForKeyInUnserializedJSONDic(dic, @"price")];
    [itemRecod setCapitalRecodStatusType:IntForKeyInUnserializedJSONDic(dic, @"capital_status")];
    [itemRecod setCapitalAddTimeStr:StringForKeyInUnserializedJSONDic(dic, @"add_time")];
    ///格式化时间字符串
    [itemRecod setCapitalAddTimeStr:formatDateWithFormat(@"yyyy-MM-dd HH:mm:ss",@"yyyy-MM-dd", itemRecod.capitalAddTimeStr)];
    
    if([itemRecod.capitalMoneyCotnent rangeOfString:@"."].location ==NSNotFound){
        [itemRecod setCapitalMoneyCotnent:[NSString stringWithFormat:@"%.2f",[itemRecod.capitalMoneyCotnent doubleValue]]];
    }else{
        [itemRecod setCapitalMoneyCotnent:[NSString stringWithFormat:@"%.2f",[itemRecod.capitalMoneyCotnent doubleValue]]];
    }
    
    
    return itemRecod;
}

#pragma mark -
#pragma mark -  初始化结算记录列表数据（包括每次申请结算的人数，订单数，结算额等信息）
+ (ClubFinanceCapitalRecod *)initClubFinanceCapitalRecodForSettleUpListWithUnserializedJSONDic:(NSDictionary *)dic{
    ClubFinanceCapitalRecod *itemRecod = [[ClubFinanceCapitalRecod alloc]init];
    [itemRecod setCapitalAddTimeStr:StringForKeyInUnserializedJSONDic(dic, @"add_time")];
    ///格式化时间字符串
    [itemRecod setCapitalAddTimeStr:formatDateWithFormat(@"yyyy-MM-dd HH:mm:ss",@"yyyy-MM-dd HH:mm", itemRecod.capitalAddTimeStr)];
    [itemRecod setCapitalRecodNumber:StringForKeyInUnserializedJSONDic(dic, @"bill_check_number")];
    [itemRecod setCapitalBillCheckStateType:IntForKeyInUnserializedJSONDic(dic, @"bill_state")];
    [itemRecod setCapitalOrderPeopleCount:IntForKeyInUnserializedJSONDic(dic, @"pop_num")];
    [itemRecod setCapitalOrderCount:IntForKeyInUnserializedJSONDic(dic, @"procurement_count")];
    [itemRecod setCapitalMoneyCotnent:StringForKeyInUnserializedJSONDic(dic, @"reslut")];
    
    if([itemRecod.capitalMoneyCotnent rangeOfString:@"."].location ==NSNotFound){
        [itemRecod setCapitalMoneyCotnent:[NSString stringWithFormat:@"%.2f",[itemRecod.capitalMoneyCotnent doubleValue]]];
    }else{
        [itemRecod setCapitalMoneyCotnent:[NSString stringWithFormat:@"%.2f",[itemRecod.capitalMoneyCotnent doubleValue]]];
    }

    return itemRecod;
}


#pragma mark -
#pragma mark -  初始化财务结算中关于订单的数据内容
+(ClubFinanceCapitalRecod *)initClubFinanceUserOrderInfoWithWithUnserializedJSONDic:(NSDictionary *)dic{
    ClubFinanceCapitalRecod *itemOrder= [[ClubFinanceCapitalRecod alloc]init];
    
    [itemOrder setOrderNumber:StringForKeyInUnserializedJSONDic(dic, @"order_basic_info_str")];
    [itemOrder setOrderManPeopleCount:IntForKeyInUnserializedJSONDic(dic, @"man_num")];
    [itemOrder setOrderOutDateTime:StringForKeyInUnserializedJSONDic(dic, @"intention_date")];
    [itemOrder setOrderConsultRoad:IntForKeyInUnserializedJSONDic(dic, @"consult_road")];
    [itemOrder setOrderPayStyle:IntForKeyInUnserializedJSONDic(dic, @"pay_type")];
    [itemOrder setOrderTransactionId:StringForKeyInUnserializedJSONDic(dic, @"transaction_id")];
    [itemOrder setOrderRealityPayTotalMoney:StringForKeyInUnserializedJSONDic(dic, @"count_price")];
    [itemOrder setOrderTotalAmountMoney:StringForKeyInUnserializedJSONDic(dic, @"count_price")];
    [itemOrder setOrderRefundPrice:StringForKeyInUnserializedJSONDic(dic, @"refund")];
    
    [itemOrder setTourBasicId:StringForKeyInUnserializedJSONDic(dic, @"tour_id")];
    [itemOrder setTourName:StringForKeyInUnserializedJSONDic(dic, @"tour_name")];
    [itemOrder setTourPriceTheme:StringForKeyInUnserializedJSONDic(dic, @"tour_price_theme")];
    [itemOrder setTourPriceLeaveDate:StringForKeyInUnserializedJSONDic(dic, @"intention_date")];
    
    [itemOrder setCapitalBillCheckStateType:IntForKeyInUnserializedJSONDic(dic, @"bill_state")];
    [itemOrder setCapitalRecodStatusType:IntForKeyInUnserializedJSONDic(dic, @"bill_state")];
    [itemOrder setCapitalDepositId:StringForKeyInUnserializedJSONDic(dic, @"bill_check_id")];
    [itemOrder setCapitalMoneyCotnent:StringForKeyInUnserializedJSONDic(dic, @"reslut")];
//
//    NSLog(@"%ld--- %ld",[itemOrder.capitalMoneyCotnent rangeOfString:@"."].location,NSNotFound);
    if([itemOrder.capitalMoneyCotnent rangeOfString:@"."].location ==NSNotFound){
        [itemOrder setCapitalMoneyCotnent:[NSString stringWithFormat:@"%.2f",[itemOrder.capitalMoneyCotnent doubleValue]]];
    }else{
        [itemOrder setCapitalMoneyCotnent:[NSString stringWithFormat:@"%.2f",[itemOrder.capitalMoneyCotnent doubleValue]]];
    }
    
    return itemOrder;
}
@end

