//
//  VerificationCodeImageView.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/20.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^verCodeImageViewBlock)(NSString *code);

@interface VerificationCodeImageView : UIView

/*!
 * @property
 * @brief 验证码内容（n位）
 */
@property (nonatomic , strong)      NSString           *imageCode;

/*!
 * @property
 * @brief 是否需要内容旋转复杂化
 */
@property (nonatomic ,  assign)      BOOL               isRotation;

/*!
 * @property
 * @brief 验证码 Block
 */
@property (nonatomic , copy)      verCodeImageViewBlock block;

/*!
 * @property
 * @brief 验证码位数 默认4位
 */
@property (nonatomic ,  assign)      NSInteger          codeLength;


/**
 刷新验证码
 */
- (void)freshCodeContent;
@end
