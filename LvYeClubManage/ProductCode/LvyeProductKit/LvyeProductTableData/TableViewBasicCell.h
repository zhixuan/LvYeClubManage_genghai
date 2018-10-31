//
//  TableViewBasicCell.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/13.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewBasicCell : UITableViewCell

/*!
 * @property
 * @brief 信息 ID
 */
@property (nonatomic , copy)      NSString      *cellDataInfoId;

/*!
 * @property
 * @brief 信息  标题
 */
@property (nonatomic , copy)      NSString      *cellDataInfoTitle;
/*!
 * @property
 * @brief 内容
 */
@property (nonatomic , copy)      NSString      *cellDataInfoContent;

/*!
 * @property
 * @brief 信息头部 ICON ImageView
 */
@property (nonatomic , weak)      UIImageView   *cellLeftImageView;

/*!
 * @property
 * @brief 内容信息视图
 */
@property (nonatomic , weak)      UILabel       *cellTitleLabel;

/*!
 * @property
 * @brief 内容信息视图
 */
@property (nonatomic , weak)      UILabel       *cellContentLabel;

/*!
 * @property
 * @brief 信息 指引 ImageView
 */
@property (nonatomic , weak)      UIImageView   *cellRightImageView;

/*!
 * @property
 * @brief 信息 分割线
 */
@property (nonatomic , weak)     UIView         *cellSeparatorView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end
