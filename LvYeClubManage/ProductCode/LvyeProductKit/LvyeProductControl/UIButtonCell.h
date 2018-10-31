//
//  UIButtonCell.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/7.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KButtonCellRect(top)                     CGRectMake(0.0f, top, KProjectScreenWidth, 55.0f)


@interface UIButtonCell : UIButton
/*!
 * @property
 * @brief 当前按键对应下的控制器名字
 */
@property (nonatomic , strong)      NSString            *btnClassName;
/*!
 * @property
 * @brief 控制器模块名字
 */
@property (nonatomic ,  strong)      NSString           *btnControTitleName;

/*!
 * @property
 * @brief 信息 ID
 */
@property (nonatomic , strong)      NSString            *btnItemInfoId;


/*!
 * @property
 * @brief 信息内容
 */
@property (nonatomic ,  strong)      NSString           *btnItemInfoContent;


+ (instancetype)buttonNormalWithType:(UIButtonType)buttonType;
+ (instancetype)buttonCellWithType:(UIButtonType)buttonType;
+ (instancetype)buttonCellWithType:(UIButtonType)buttonType icon:(FMIconFont)imageIcon;

@end
