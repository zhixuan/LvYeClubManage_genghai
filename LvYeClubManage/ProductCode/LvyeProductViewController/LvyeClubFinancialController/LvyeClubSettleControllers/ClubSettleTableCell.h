//
//  ClubSettleTableCell.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/9/3.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "TableViewBasicCell.h"
#import "ClubFinanceCapitalRecod.h"

#define KClubSettleTableCellHeight  (KLVYEUIControlSizeHeight(145.0f))

@interface ClubSettleTableCell : TableViewBasicCell

/*!
 * @property
 * @brief 结算状态
 */
@property (nonatomic , weak)      UILabel           *recordStatusLable;

/*!
 * @property
 * @brief 界面数据内容背景视图
 */
@property (nonatomic ,  weak)      UIView           *contentBackGroudView;

/*!
 * @property
 * @brief  添加时间
 */
@property (nonatomic , weak)      UILabel           *recordAddDateLabel;

/*!
 * @property
 * @brief 订单个数
 */
@property (nonatomic , weak)      UILabel           *recordOrderCountLabel;

/*!
 * @property
 * @brief 订单总人数
 */
@property (nonatomic , weak)      UILabel           *recordOrderPeopleCountLabel;

/*!
 * @property
 * @brief 结算额度
 */
@property (nonatomic , weak)      UILabel           *recordResultLabel;


- (void)fillClubSettleTableCellDataSourceWithClubFinanceCapitalRecod:(ClubFinanceCapitalRecod*)recod;
@end
