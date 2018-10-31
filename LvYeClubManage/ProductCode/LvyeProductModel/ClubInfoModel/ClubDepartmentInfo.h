//
//  ClubDepartmentInfo.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/30.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubInfo.h"

@interface ClubDepartmentInfo : ClubInfo
/*!
 * @property
 * @brief 俱乐部的部门 ID
 */
@property (nonatomic , copy)      NSString              *clubDepartmentId;

/*!
 * @property
 * @brief 俱乐部的部门名字
 */
@property (nonatomic , copy)      NSString              *clubDepartmentName;
@end
