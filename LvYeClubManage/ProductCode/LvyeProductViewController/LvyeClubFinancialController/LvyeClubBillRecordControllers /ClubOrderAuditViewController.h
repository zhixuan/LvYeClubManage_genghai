//
//  ClubOrderAuditViewController.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/3/13.
//  Copyright © 2019年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseViewController.h"
#import "ClubOrderInfo.h"

@protocol AuditOperationDelegate
- (void)userAuditOperationFinish;
@end
/**
 订单审核操作
 */
@interface ClubOrderAuditViewController : LvyeBaseViewController

- (instancetype)initWithClubOrderDetailInfo:(ClubOrderInfo *)orderDetail deletage:(id<AuditOperationDelegate>) dDelegate;
@end
