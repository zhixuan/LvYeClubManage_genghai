//
//  UIImage+ImageGradientColorCategory.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/21.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
渐变方向

 - GradientColorHorizontalStyle: 水平方向
 - GradientColorVerticalStyle: 垂直方向
 - GradientColorUpwardStyle: 向上对角方向
 - GradientColorDownwardDiagonalStyle: 向下对角方向
 */
typedef NS_ENUM(NSUInteger,GradientColorStyle) {
    GradientColorHorizontalStyle = 1<<0,        /**< 水平方向*/
    GradientColorVerticalStyle,                 /**< 垂直方向*/
    GradientColorUpwardStyle,                   /**< 向上对角方向*/
    GradientColorDownwardDiagonalStyle,         /**< 向下对角方向*/
    
};
@interface UIImage (ImageGradientColorCategory)
+ (instancetype)initWithGradientColorWithDirection:(GradientColorStyle)style
                                              size:(CGSize)size
                                        startColor:(UIColor *)start
                                          endColor:(UIColor *)end;

- (UIImage *)thumbScaleImageWithPoint:(CGPoint)point size:(CGSize)size;

@end
