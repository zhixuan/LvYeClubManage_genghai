//
//  CatalogueEenuButton.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/15.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef  void (^CatalogueEenuButtonBlock)(NSInteger orderPaymentStat);

@interface CatalogueEenuButton : UIView

/*!
 * @property
 * @brief 操作控制 Block
 */
@property (nonatomic , copy)      CatalogueEenuButtonBlock block;


- (instancetype)initWithFrame:(CGRect)frame contentArray:(NSArray*)array;

@end
