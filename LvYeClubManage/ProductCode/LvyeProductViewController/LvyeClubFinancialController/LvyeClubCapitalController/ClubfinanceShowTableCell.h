//
//  ClubfinanceShowTableCell.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/27.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "TableViewBasicCell.h"
#import "ClubFinanceCapitalRecod.h"

#define KClubfinanceShowTableCellHeight  (KLVYEUIControlSizeHeight(145.0f))

@interface ClubfinanceShowTableCell : TableViewBasicCell

- (void)fillClubfinanceShowTableCellDataSourceWithClubFinanceCapitalRecod:(ClubFinanceCapitalRecod*)recod;
@end
