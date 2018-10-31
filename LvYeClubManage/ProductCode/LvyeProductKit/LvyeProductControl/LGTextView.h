//
//  LGTextView.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/24.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LGTextView : UITextView

/*!
 * @property
 * @brief 占位符文本内容
 */
@property (nonatomic , strong)      NSString            *placeholder;

/*!
 * @property
 * @brief 占位符颜色
 */
@property (nonatomic , strong)      UIColor             *placeholderTextColor;

@end
