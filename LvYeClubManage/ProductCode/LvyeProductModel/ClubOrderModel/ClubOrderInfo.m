//
//  ClubOrderInfo.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/28.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubOrderInfo.h"

@implementation ClubOrderInfo

- (instancetype)init{
    self =[super init];
    if(self){
        self.orderLinkUserInfo = [[ClubUserInfo alloc]init];
    }
    return self;
}

+ (instancetype)initWithClubOrderInfoWithUnserializedJSONDic:(NSDictionary *)dic{
    ClubOrderInfo *itemOrder = [[ClubOrderInfo alloc]init];
    
    [itemOrder setClubId:StringForKeyInUnserializedJSONDic(dic, @"")];
    [itemOrder setTourName:StringForKeyInUnserializedJSONDic(dic, @"")];
    [itemOrder setTourPriceInfoId:StringForKeyInUnserializedJSONDic(dic, @"")];
    
    return itemOrder;
}

#pragma mark -
#pragma mark -  初始化活动管理中订单列表数据内容
+ (instancetype)initWithClubItemOrderInfoCellAtOrderManagerWithUnserializedJSONDic:(NSDictionary *)dic{
    ClubOrderInfo *itemOrder = [[ClubOrderInfo alloc]init];

    [itemOrder setTourBasicId:StringForKeyInUnserializedJSONDic(dic, @"product_id")];
    [itemOrder setTourName:StringForKeyInUnserializedJSONDic(dic, @"team_name")];
    [itemOrder setTourTeamDays:StringForKeyInUnserializedJSONDic(dic, @"intention_day")];
    [itemOrder setTourPriceTeamDays:StringForKeyInUnserializedJSONDic(dic, @"intention_day")];
  

    [itemOrder setOrderNumber:StringForKeyInUnserializedJSONDic(dic, @"order_num")];
    [itemOrder setOrderAddDateTime:StringForKeyInUnserializedJSONDic(dic, @"create_date")];
    [itemOrder setOrderOutDateTime:StringForKeyInUnserializedJSONDic(dic, @"intention_date")];
    [itemOrder setOrderLinkUserName:StringForKeyInUnserializedJSONDic(dic, @"user_name")];
    [itemOrder setOrderLinkUserMobile:StringForKeyInUnserializedJSONDic(dic, @"user_mobile")];
    [itemOrder setOrderPaymentStatus:StringForKeyInUnserializedJSONDic(dic, @"payment_status")];
    [itemOrder setOrderTotalAmountMoney:StringForKeyInUnserializedJSONDic(dic, @"intention_price")];
    [itemOrder setOrderManPeopleCount:IntForKeyInUnserializedJSONDic(dic, @"man_num")];
    

    return itemOrder;
    
}

+ (instancetype)initWithOrderDetailInfoWithUnserializedJSONDic:(NSDictionary *)dic{
    
    ClubOrderInfo *itemOrder = [[ClubOrderInfo alloc]init];
    itemOrder.orderLinkUserInfo = [ClubUserInfo initClubUserInfoForOrderLinkUserInfoWithUnserializedJSONDic:ObjForKeyInUnserializedJSONDic(dic, @"contact")];
    [itemOrder setOrderNumber:StringForKeyInUnserializedJSONDic(dic, @"order_num")];
    
    [itemOrder setTourName:StringForKeyInUnserializedJSONDic(dic, @"team_name")];
    [itemOrder setTourBasicId:StringForKeyInUnserializedJSONDic(dic, @"Product_id")];
    [itemOrder setTourTeamDays:StringForKeyInUnserializedJSONDic(dic, @"intention_day")];
    
    [itemOrder setTourPriceInfoId:StringForKeyInUnserializedJSONDic(dic, @"")];
    [itemOrder setTourPriceLeaveDate:StringForKeyInUnserializedJSONDic(dic, @"leave_date")];
    
    [itemOrder setOrderManPeopleCount:IntForKeyInUnserializedJSONDic(dic, @"man_num")];
    [itemOrder setOrderPayStyle:IntForKeyInUnserializedJSONDic(dic, @"pay_type")];
    [itemOrder setOrderPaymentStatus:StringForKeyInUnserializedJSONDic(dic, @"payment_status")];
    
    return itemOrder;
}
@end
