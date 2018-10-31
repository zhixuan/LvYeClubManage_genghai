//
//  LvyeBaseViewController.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/17.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LvyeBaseViewController : UIViewController

///TODO: PROPERTY

/*!
* @property
* @brief 默认YES，显示自定义的导航栏返回按钮
*/
@property (nonatomic, assign) BOOL enableCustomNavbarBackButton;


/*!
 * @property
 * @brief 滑动视图
 */
@property (nonatomic , assign)      UIScrollView    *bgScrollView;

/*!
 * @property
 * @brief 功能模块 ID
 */
@property (nonatomic , strong)      NSString        *clubModuleId;

/*!
 * @property
 * @brief 功能模块 ID
 */
@property (nonatomic , strong)      NSString        *clubModuleName;

/*!
 * @property
 * @brief 功能模块 FMICON
 */
@property (nonatomic , assign)      FMIconFont      clubModuleImage;

/*!
 * @property
 * @brief 字体的大小，即ICON图片的大小
 */
@property (nonatomic, assign) CGFloat navButtonSize;

/*!
 * @property
 * @brief Nothing
 */
@property (nonatomic, copy) void(^navBackButtonRespondBlock)(void);

///TODO: METHOD

- (void) settingNavTitle:(NSString *)title;

- (void) settingNavTitle:(NSString *)title color:(UIColor *)color;

- (instancetype)initWithEnableDisplayOnTabBar;

/**
 设置导航栏左侧按钮（普通按键）

 @param btImage 按键图片
 @param frame 按键大小
 @param target 所属基类
 @param action 事件
 */
- (void) setLeftNavButton:(UIImage* )btImage
                withFrame:(CGRect) frame
             actionTarget:(id)target action:(SEL) action;
/**
 使用字体设置左侧按钮图片
 
 @param buttonType 字符编号
 @param frame 按键大小
 @param target 所属基类
 @param action 事件
 */
- (void) setLeftNavButtonFA:(NSInteger)buttonType
                  withFrame:(CGRect) frame
               actionTarget:(id)target
                     action:(SEL) action;
/**
 设置导航栏右侧按钮（普通按键）
 
 @param btImage 背景图片
 @param frame 按键大小
 @param target 所属基类
 @param action 事件
 */
- (void) setRightNavButton:(UIImage* )btImage
                 withFrame:(CGRect) frame
              actionTarget:(id)target
                    action:(SEL) action;
/**
 使用字体设置右侧按钮图片
 
 @param buttonType 字符编号
 @param frame 按键大小
 @param target 所属基类
 @param action 事件
 */
- (void)setRightNavButtonFA:(NSInteger)buttonType
                  withFrame:(CGRect) frame
               actionTarget:(id)target
                     action:(SEL) action;

///使用字符设置右侧按键
- (void)setRightNavButtonTitleStr:(NSString *)titleStr
                        withFrame:(CGRect) frame
                     actionTarget:(id)target
                           action:(SEL) action;


- (void)setLeftNavButtonTitleStr:(NSString *)titleStr
                       withFrame:(CGRect)frame
                    actionTarget:(id)target
                          action:(SEL)action;

- (void)setRightNavButtonFA:(NSArray <NSNumber *> *)buttonTypeArray
                  buttonTag:(NSArray <NSNumber *> *)tagArray
        buttonSelectedColor:(NSArray <UIColor *> *)colorArray
          buttonDefautColor:(NSArray <UIColor *> *)colorDefaultArray
               actionTarget:(id)target
                     action:(SEL)action;
@end
