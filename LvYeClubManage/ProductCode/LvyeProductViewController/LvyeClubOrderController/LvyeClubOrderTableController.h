//
//  LvyeClubOrderTableController.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/9.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//




#import "LvyeBaseViewController.h"


extern NSString    *const LvyeClubOrderForAllStyle;
extern NSString    *const LvyeClubOrderForHasPayStyle;
extern NSString    *const LvyeClubOrderForUnPayStyle;
extern NSString    *const LvyeClubOrderForRefundStyle;
extern NSString    *const LvyeClubOrderForAfterServiceStyle;


/**
 俱乐部订单列表内容
 */
@interface LvyeClubOrderTableController : LvyeBaseViewController


- (id)initWithTitle:(NSString *)title;
@end
