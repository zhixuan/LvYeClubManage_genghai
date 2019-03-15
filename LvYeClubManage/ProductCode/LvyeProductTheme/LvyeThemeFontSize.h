//
//  LvyeThemeFontSize.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/17.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#ifndef LvyeThemeFontSize_h
#define LvyeThemeFontSize_h

/////字体包名称
//#define kFontAwesomeFamilyName                  @"LvyeFontAwesome"
///字体包名称
#define kFontAwesomeFamilyName                  @"FontAwesome"

#define KNavSize                                20.0f
#define KTabBarItemBtnSize                      24.0f


#define kFontSTHeitiSCLightName                 @"STHeitiSC-Light"              //细字体
#define kFontHelveticaNeueLightName             @"HelveticaNeue-Light"
#define kFontHelveticaNeueName                  @"HelveticaNeue"

#define KLVYEContentFontSize                    [UIFont systemFontOfSize:(14*KLVYEAdapterSizeWidth)]
#define KLVYEUIContentFontSize(f)               [UIFont fontWithName:kFontHelveticaNeueLightName size:((f)*KLVYEAdapterSizeWidth)]


#define kNavBarButtonRect                       CGRectMake(0, 0.0f, 55, 44.0f)    //左右侧导航栏按钮大小

#define KContentLeftTitleFontOfSize             [UIFont systemFontOfSize:18.0f]     //标题文本的字体大小

#define KDefaultOperationButtonTitleFontOfSize  [UIFont systemFontOfSize:15.0f]


#define KBtnContentTextFont                     KLVYEUIContentFontSize(15)

#define KSalonAuthorHeaderPhotoImageWidth       KLVYEUIControlSizeWidth(25.0f)


#define KCellContentThemeTitleContentFontSize   [UIFont fontWithName:@"HelveticaNeue" size:((23)*KLVYEAdapterSizeWidth)]
#define KCellContentThemeSubtitleContentFontSize [UIFont fontWithName:@"HelveticaNeue-Thin" size:((14)*KLVYEAdapterSizeWidth)]
#define KCellContentCommentContentFontSize      (KLVYEUIContentFontSize(12.0f))
#define KCellContentLocationContentFontSize     (KLVYEUIContentFontSize(16.0f))
#define KCellContentAuthorNameContentFontSize   KCellContentCommentContentFontSize

#define KUserPersonalRightButtonArrowFontSize   (16.0f)

#define KInforLeftIntervalWidth             (15.0f)

#define KLVYEUIControlSizeHeight(f)         (f*KLVYEAdapterSizeHeight)

#define KLVYEUIControlSizeWidth(f)          (f*KLVYEAdapterSizeWidth)

#define KBtnColorPurpleButtonWidth          (140.0f)

#define KBtnColorPurpleButtonHeight         (38.0f)


///列表界面加载更多 CellHeight
#define kSizeLoadMoreCellHeight             30.0



#define KASBaseViewFrame            CGRectMake(0.0, 64.0f, KProjectScreenWidth, self.view.frame.size.height- 44.0f)












//适配宽高
#define KLVYEAdapterSizeWidth    (KProjectScreenWidth/375.0)
//#define KLVYEAdapterSizeHeight    (KProjectScreenHeight/667.0)
#define KLVYEAdapterSizeHeight    (1.0)

///列表界面Cell中用户头像高度
#define KUserPhotoImageHeight               (45.0f*KLVYEAdapterSizeWidth)

///列表界面Cell中用户头像距头部高度
#define KUserPhotoForCellTopInterval        (20.0f)

///列表界面Cell中用户头像距左侧边界距离
#define KUserPhotoForCellLeftInterval       KInforLeftIntervalWidth


///注册/登录界面内容

#define KBtnForRegisterOrLoginButtonsIntervalHeight     (KLVYEUIControlSizeWidth(10.0f))
#define KBtnForRegisterOrLoginButtonLeftInterval        (KLVYEUIControlSizeWidth(38))

#define KBtnForRegisterOrLoginButtonHeight              (KLVYEUIControlSizeWidth(50.0f))
#define KBtnForBtnCellNormalHeight                      KBtnForRegisterOrLoginButtonHeight

#define KBtnCellHeight                      KBtnForBtnCellNormalHeight
#define KBtnBackGroundTop                   (20.0f)
#define KBtnContentLeftWidth                KInforLeftIntervalWidth

#endif /* LvyeThemeFontSize_h */
