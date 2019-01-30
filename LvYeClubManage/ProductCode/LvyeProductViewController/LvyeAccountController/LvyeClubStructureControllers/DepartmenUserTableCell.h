//
//  DepartmenUserTableCell.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/22.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "TableViewBasicCell.h"

#define KDepartmenUserTableCellHeight           (KLVYEUIControlSizeWidth(70.0f))


typedef NS_ENUM(NSUInteger,DataSourceStyle) {
    
    DataSourceForUserInfoStyle = 1 << 1,        /**< 10 员工信息*/
    DataSourceForDepartmenStyle,                /**< 10 部门信息*/
};

@interface DepartmenUserTableCell : TableViewBasicCell

/*!
 * @property
 * @brief 数据信息类别
 */
@property (nonatomic , assign)      DataSourceStyle dataSourceStyle;

/**
 初始化部门里的用户信息

 @param dataSource 各部门的用户数据
 */
- (void)fillDataInforForCellWithUserDataSource:(NSDictionary *)dataSource;

/**
 初始化各部门信息

 @param dataSource 部门信息（部门 ID 及部门名）
 */
- (void)fillDataInfoForCellWithClubDepartmenDataSource:(NSDictionary *)dataSource;
@end
