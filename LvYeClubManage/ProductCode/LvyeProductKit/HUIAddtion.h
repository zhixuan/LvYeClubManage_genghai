//
//  HUIAddtion.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/17.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#ifndef HUIAddtion_h
#define HUIAddtion_h

#define HUIIsIPAD()                     (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

//System version
#define HUISystemVersionIs(v)           ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] \
== NSOrderedSame)
#define HUISystemVersionAbove(v)        ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] \
== NSOrderedDescending)
#define HUISystemVersionAboveOrIs(v)    ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] \
!= NSOrderedAscending)
#define HUISystemVersionBelow(v)        ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] \
== NSOrderedAscending)
#define HUISystemVersionBelowOrIs(v)    ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] \
!= NSOrderedDescending)


#define kHUISystemVersion_8_0           @"8.0"
#define kHUISystemVersion_8_1           @"8.1"
#define kHUISystemVersion_9_0           @"9.0"
#define kHUISystemVersion_10_0           @"10.0"
#define kHUISystemVersion_11_0           @"11.0"

#endif /* HUIAddtion_h */
