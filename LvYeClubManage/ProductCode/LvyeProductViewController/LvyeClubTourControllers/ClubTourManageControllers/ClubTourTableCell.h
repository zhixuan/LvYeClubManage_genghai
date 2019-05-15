//
//  ClubTourTableCell.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/4/8.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "TableViewBasicCell.h"
#import "TourBasicInfo.h"


#define KClubTourLeftImageHeight            (120.0f)
#define KClubTourTableCellHeight            (KClubTourLeftImageHeight+KInforLeftIntervalWidth*2)
NS_ASSUME_NONNULL_BEGIN

@interface ClubTourTableCell : TableViewBasicCell


- (void)fillClubTourTableCellDataSourceWithTourBasicInfo:(TourBasicInfo *)info;
@end

NS_ASSUME_NONNULL_END
