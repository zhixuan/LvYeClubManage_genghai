//
//  LGRightMenuView.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/4/2.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^OperationBlock)(BOOL showMore,NSDictionary *operation) ;

@interface LGRightMenuView : UIButton


/*!
 * @property
 * @brief 用户操作结束有得到的数据 Block
 */
@property (nonatomic , copy)      OperationBlock            block;
- (instancetype)initWithFrame:(CGRect)frame content:(NSDictionary *)content menuContent:(NSArray *)menuContent ;

@end

NS_ASSUME_NONNULL_END
