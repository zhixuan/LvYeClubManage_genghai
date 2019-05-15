//
//  ClubTourCommentCell.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/5/10.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "TableViewBasicCell.h"


#define KClubTourCommentLeftImageHeight     (90.0f)
#define KClubTourCommentCellHeight          (KClubTourCommentLeftImageHeight+KInforLeftIntervalWidth*2)

NS_ASSUME_NONNULL_BEGIN

@interface ClubTourCommentCell : TableViewBasicCell

/*!
 * @property
 * @brief 线路 ID
 */
@property (nonatomic , weak)      UILabel           *tourIdLabel;
/*!
 * @property
 * @brief 活动评价等级
 */
@property (nonatomic ,  weak)      UILabel          *tourCommentScale;

/*!
 * @property
 * @brief 活动评论者
 */
@property (nonatomic , weak)      UILabel           *tourCommentUserName;


/*!
 * @property
 * @brief 出发时间
 */
@property (nonatomic , weak)      UILabel           *tourGroupDateLable;


- (void)fillClubTourCommentTableCellDataSourceWithTourBasicInfo:(NSDictionary *)info;

@end

NS_ASSUME_NONNULL_END
