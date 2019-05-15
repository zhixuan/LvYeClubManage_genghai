//
//  ClubToursMoreChooseViewController.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/4/2.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN



typedef void(^MoreChooseOperationBlock)(NSDictionary  *info);



@protocol  ClubToursMoreChooseDelegate <NSObject>

- (void)userPersonalChooseMoreOperation:(NSDictionary *)info;

@end
/**
 俱乐部活动s更多筛选查询条件界面
 */
@interface ClubToursMoreChooseViewController : LvyeBaseViewController


/*!
 * @property
 * @brief 用户操作条件参数
 */
@property (nonatomic , copy)      MoreChooseOperationBlock   operaionBlock;

- (instancetype)initWithDelegate:(id<ClubToursMoreChooseDelegate>) aDelegate;
@end

NS_ASSUME_NONNULL_END
