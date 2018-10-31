//
//  ClubLeaderAddController.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/15.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseViewController.h"
#import "ClubLeaderInfo.h"

typedef NS_ENUM(NSUInteger,LeaderOperationStyle) {
    LeaderOperationAddStyle= 10,
    LeaderOperationEditStyle,
    LLeaderOperationShowStyle,
};

@interface ClubLeaderAddController : LvyeBaseViewController


- (instancetype)initWithUserOperaionStyle:(LeaderOperationStyle)style leader:(ClubLeaderInfo*)leader;
@end
