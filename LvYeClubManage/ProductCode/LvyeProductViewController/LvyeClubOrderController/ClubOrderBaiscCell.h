//
//  ClubOrderBaiscCell.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/3/11.
//  Copyright © 2019年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "TableViewBasicCell.h"
#import "ClubOrderInfo.h"


#define KClubOrderBaiscCellHeight  (KLVYEUIControlSizeHeight(257.5-44.176000))


@interface ClubOrderBaiscCell : TableViewBasicCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setupCellDataInfo:(ClubOrderInfo *)itemOrder;
@end
