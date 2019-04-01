//
//  LvyeClubProxyParam.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/9.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#ifndef LvyeClubProxyParam_h
#define LvyeClubProxyParam_h





#ifndef __OPTIMIZE__
#define KKeyUmengAppId              @"5b42c87df43e481dab00002d"
#else
#define KKeyUmengAppId              @"5b42cfa0f43e4846cb00007e"
#endif


//#ifndef __OPTIMIZE__
//#define NSLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
//#else
//#define NSLog(...) {}
//#endif


//#ifndef __OPTIMIZE__
//#define NSLog(fmt, ...) NSLog((@"%s " fmt), __PRETTY_FUNCTION__, ##__VA_ARGS__);
//#else
//#define NSLog(...) {}
//#endif
//
//#define NSLog(...) {}



#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s\t%s\n",__PRETTY_FUNCTION__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

#define KClueDefaultImage_ClubLeaderPhotoName               @"clubLeaderPhotoDefaultImage.png"
#define KClueDefaultImage_ClubLeaderPhotoImage              [UIImage imageNamed:KClueDefaultImage_ClubLeaderPhotoName]


#define KClueDefaultImage_ClubCurrentUserPhotoName          @"clubCurrentUserPhotoImage.png"
#define KClueDefaultImage_ClubCurrentUserPhotoImage         [UIImage imageNamed:KClueDefaultImage_ClubCurrentUserPhotoName]


#define KClueDefaultImage_ClubUserPhotoDefaultName          @"clubUserPhotoDefaultImage.png"
#define KClueDefaultImage_ClubUserPhotoDefaultImage         [UIImage imageNamed:KClueDefaultImage_ClubUserPhotoDefaultName]

#endif /* LvyeClubProxyParam_h */
