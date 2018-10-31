//
//  ClubBankTableViewCell.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "TableViewBasicCell.h"
#import "ClubBankInfo.h"

#define KClubBankTableViewCellHeight  (KLVYEUIControlSizeHeight(145.0f))

@interface ClubBankTableViewCell : TableViewBasicCell

- (void)fillClubBankInfo:(ClubBankInfo *)clubBank;
@end
