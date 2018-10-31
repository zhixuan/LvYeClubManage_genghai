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
@end
