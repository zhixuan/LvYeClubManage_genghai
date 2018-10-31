//
//  LvyeThemeColor.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/18.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#ifndef LvyeThemeColor_h
#define LvyeThemeColor_h


///自行处理颜色信息
#define HUIRGBColor(r, g, b, a)             [UIColor colorWithRed:(r)/255.00 green:(g)/255.00 blue:(b)/255.00 alpha:(a)]

////TODO: 项目整体背景色
#define KDefaultViewBackGroundColor         [UIColor colorWithRed:230.0f/255.0 green:230.0/255.0 blue:236.0/255.0 alpha:1.0]

//内容文本颜色
#define KContentTextColor                   [UIColor colorWithRed:51.0f/255.0f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f]

//内容文本颜色
#define KContentGreyTextColor               [UIColor colorWithRed:105.0f/255.0f green:106.0f/255.0f blue:107.0f/255.0f alpha:1.0f]

//按键的高亮颜色内容
#define KButtonStateHighlightedColor        [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f]
#define KButtonStateNormalColor             HUIRGBColor(88.0f, 0.0f, 115.0f, 1.0f)
#define KButtonTextHighlightedColor  HUIRGBColor(88.0f, 0.0f, 115.0f, 0.6f)

///边框颜色设置
#define KBorderColorSetup                   [UIColor colorWithRed:214.0f/255.0f green:215.0f/255.0f blue:217.0f/255.0f alpha:1.0f]
///分割线颜色内容
#define KSeparateColorSetup                 KBorderColorSetup

///设置图片默认背景样式
#define KImageNormalColor                   KBorderColorSetup

///TableViewCell 选中的颜色
#define KTableViewCellSelectedColor     KButtonStateHighlightedColor





//文字颜色 --  用于显示列表的下拉刷新，上拉加载操作
#define kColorTextColorClay                 [UIColor colorWithRed:127.0/255.0 green:125.0/255.0 blue:127.0/255.0 alpha:1.0]
#define kColorTextColorDarkClay             [UIColor colorWithRed:74.00/255.00 green:54.00/255.00 blue:33.00/255.00 alpha:1.0]
#endif /* LvyeThemeColor_h */
