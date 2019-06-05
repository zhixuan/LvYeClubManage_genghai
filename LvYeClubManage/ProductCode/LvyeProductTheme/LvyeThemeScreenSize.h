//
//  LvyeThemeScreenSize.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/17.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#ifndef LvyeThemeScreenSize_h
#define LvyeThemeScreenSize_h


#define KProjectScreenWidth          [UIScreen mainScreen].bounds.size.width
#define KProjectScreenHeight         [UIScreen mainScreen].bounds.size.height


#define HUIKeyWindow                ([UIApplication sharedApplication].keyWindow)
#define HUITopWindow                ([[[UIApplication sharedApplication] windows] lastObject])
//#define HUIApplicationFrame()        ([[UIScreen mainScreen] applicationFrame])
#define HUIApplicationFrame()        ([[UIScreen mainScreen] bounds])
//#define HUIIsRetinaScreen()         ([[UIScreen mainScreen] isRetinaDisplay])
//#define HUIIsIPhone5()              ([[UIScreen mainScreen] isIPhone5])

#endif /* LvyeThemeScreenSize_h */
