//
//  ClubBillRecordCell.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/9/3.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "TableViewBasicCell.h"

#import "ClubFinanceCapitalRecod.h"

#define KClubBillRecordCellHeight  (KLVYEUIControlSizeHeight(227.5-44.176000))

@interface ClubBillRecordCell : TableViewBasicCell

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
 * @brief 出发时间
 */
@property (nonatomic , weak)      UILabel           *recordOutDateLabel;

/*!
 * @property
 * @brief 团期名
 */
@property (nonatomic , weak)      UILabel           *recordPriceThemeName;

/*!
 * @property
 * @brief 入账内容
 */
@property (nonatomic , weak)      UILabel           *recordIncreaseLabel;

/*!
 * @property
 * @brief 出账内容
 */
@property (nonatomic , weak)      UILabel           *recordSubtractLabel;

/*!
 * @property
 * @brief 结算额度
 */
@property (nonatomic , weak)      UILabel           *recordResultLabel;


/*!
 * @property
 * @brief 下单渠道
 */
@property (nonatomic , weak)      UILabel           *recordOrderChannelLabel;

/*!
 * @property
 * @brief 支付渠道
 */
@property (nonatomic , weak)      UILabel           *recordOrderPayStyleLabel;

- (void)fillClubBillRecordShowTableCellDataSourceWithClubFinanceCapitalRecod:(ClubFinanceCapitalRecod*)recod;
@end
