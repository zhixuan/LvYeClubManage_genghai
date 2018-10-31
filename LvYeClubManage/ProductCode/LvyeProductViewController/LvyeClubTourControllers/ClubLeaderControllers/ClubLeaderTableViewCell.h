//
//  ClubLeaderTableViewCell.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "TableViewBasicCell.h"
#import "ClubLeaderInfo.h"

#define KClubLeaderTableViewCellHeight          (120.0f)
@interface ClubLeaderTableViewCell : TableViewBasicCell


- (void)fillClubLeaderDataSource:(ClubLeaderInfo *)dataSource;
@end
