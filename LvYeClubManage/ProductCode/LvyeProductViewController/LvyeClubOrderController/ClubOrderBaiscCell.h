//
//  ClubOrderBaiscCell.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/3/11.
//  Copyright © 2019年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "TableViewBasicCell.h"
#import "ClubOrderInfo.h"

#define KClubOrderBaiscCellHeight  (KLVYEUIControlSizeHeight(227.5))


@interface ClubOrderBaiscCell : TableViewBasicCell


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


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setupCellDataInfo:(ClubOrderInfo *)itemOrder;
@end
