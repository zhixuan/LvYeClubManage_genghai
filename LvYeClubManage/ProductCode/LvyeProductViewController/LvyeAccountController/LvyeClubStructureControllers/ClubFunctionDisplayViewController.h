//
//  ClubFunctionDisplayViewController.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/4/18.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN


typedef void (^ClubOperationBlock) (NSDictionary *info);

@interface ClubFunctionDisplayViewController : LvyeBaseViewController


/*!
 * @property
 * @brief 用户操作Block
 */
@property (nonatomic , copy)      ClubOperationBlock    block;

- (instancetype)init;
@end

NS_ASSUME_NONNULL_END
