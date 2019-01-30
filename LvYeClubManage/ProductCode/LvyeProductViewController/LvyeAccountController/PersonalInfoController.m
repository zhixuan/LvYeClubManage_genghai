//
//  PersonalInfoController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/9.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//







#define KBtnBackGroudViewHeight                 (KBtnForBtnCellNormalHeight*6.5+4.0f)
#define KPhotoImageViewHeight                   (KBtnForBtnCellNormalHeight*2.5-KBtnContentLeftWidth*2)

#define KButtonForUserNameTag                   (157311)
#define KButtonForUserMobileTag                 (157312)
#define KButtonForUserEmailTag                  (157313)
#define KButtonForUserPasswordTag               (157314)

#import "PersonalInfoController.h"
#import "PersonalInfoEditController.h"

@interface PersonalInfoController ()


/*!
 * @property
 * @brief 用户头像
 */
@property (nonatomic , weak)      UIImageView           *userPhotoImageView;

/*!
 * @property
 * @brief 用户名
 */
@property (nonatomic , weak)      UILabel               *userNameLabel;

/*!
 * @property
 * @brief 用户手机号
 */
@property (nonatomic , weak)      UILabel               *userMobileLabel;

/*!
 * @property
 * @brief 用户密码
 */
@property (nonatomic , weak)      UILabel               *userPasswordLabel;

/*!
 * @property
 * @brief 用户邮箱
 */
@property (nonatomic , weak)      UILabel               *userEmailLabel;

@end

@implementation PersonalInfoController

#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {

    }
    return self;
}
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:HUIApplicationFrame()];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor =  KDefaultViewBackGroundColor;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"更改个人信息内容");
    // Do any additional setup after loading the view.
    
    NSLog(@"userName is %@",KLvyeClubCurrentUser.userName);
    
    [self setContorViewFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setContorViewFrame{
    
    NSUUID *Cuuid = [UIDevice currentDevice].identifierForVendor;
    NSLog(@"uuid 1 [%@]",Cuuid.UUIDString);
    
    UIView *contentBGView = [[UIView alloc]init];
    [contentBGView setBackgroundColor:[UIColor whiteColor]];
    [contentBGView setFrame:CGRectMake(0.0f, KBtnBackGroundTop, KProjectScreenWidth, KBtnBackGroudViewHeight)];
    [self.bgScrollView addSubview:contentBGView];
    
//    NSDate *dateNow = [NSDate new];
//    NSArray *newArray = [[NSArray alloc]initWithObjects:@"12", nil];
//    NSLog(@"%@",[newArray objectAtIndex:2]);
    UILabel *photoLabel = [[UILabel alloc]init];
    [photoLabel setBackgroundColor:[UIColor clearColor]];
    [photoLabel setFrame:CGRectMake(KBtnContentLeftWidth, 0.0f, 40.0f, KBtnForBtnCellNormalHeight*2.5f)];
    [photoLabel setText:@"头像"];
    [photoLabel setTextAlignment:NSTextAlignmentLeft];
    [photoLabel setFont:KContentLeftTitleFontOfSize];
    [photoLabel setTextColor:KContentTextColor];
    [contentBGView addSubview:photoLabel];
    UIView *photoBottomSeparate = [[UIView alloc]init];
    [photoBottomSeparate setBackgroundColor:KSeparateColorSetup];
    [photoBottomSeparate setFrame:CGRectMake(KBtnContentLeftWidth, photoLabel.bottom,
                                             (KProjectScreenWidth - KBtnContentLeftWidth),
                                             1.0f)];
    [contentBGView addSubview:photoBottomSeparate];
    
    

    
    
    UIImageView *photoImageView = [[UIImageView alloc]init];
    [photoImageView setBackgroundColor:[UIColor clearColor]];
    [photoImageView.layer setMasksToBounds:YES];
//    [photoImageView.layer setBorderWidth:1.0f];
    [photoImageView setImage:KClueDefaultImage_ClubCurrentUserPhotoImage];
//    [photoImageView.layer setCornerRadius:KPhotoImageViewHeight/2];
//    [photoImageView.layer setBorderColor:KSeparateColorSetup.CGColor];
    [photoImageView setFrame:CGRectMake((KProjectScreenWidth - KPhotoImageViewHeight - KBtnContentLeftWidth), KBtnContentLeftWidth, KPhotoImageViewHeight, KPhotoImageViewHeight)];
    self.userPhotoImageView =photoImageView;
    [contentBGView addSubview:photoImageView];

    NSString *photoImageURLStr = [NSString stringWithFormat:@"%@%@",KEY_RESPONSE_LVYE_CLUB_IMAGE_URL,KLvyeClubCurrentUser.userPhotoImageURL];

//    [self.userPhotoImageView setImageWithURL:[NSURL URLWithString:photoImageURLStr] placeholderImage:KClueDefaultImage_ClubCurrentUserPhotoImage];
//    [self.userPhotoImageView setImageWithURL:[NSURL URLWithString:photoImageURLStr] placeholderImage:KClueDefaultImage_ClubCurrentUserPhotoImage];
    
    [self.userPhotoImageView setImageWithURL:[NSURL URLWithString:photoImageURLStr] placeholderImage:KClueDefaultImage_ClubCurrentUserPhotoImage options:SDWebImageCacheMemoryOnly];
    
    ///用户名
    UIButtonCell *nameButton = [UIButtonCell buttonNormalWithType:UIButtonTypeCustom];
    [nameButton setTitle:@"名字" forState:UIControlStateNormal];
    [nameButton setTag:KButtonForUserNameTag];
    [nameButton addTarget:self action:@selector(userPersonalButtonEventOperation:)
             forControlEvents:UIControlEventTouchUpInside];
    [nameButton setFrame:CGRectMake(0.0f, photoBottomSeparate.bottom, KProjectScreenWidth, KBtnForBtnCellNormalHeight)];
    [contentBGView addSubview:nameButton];
    
    UILabel *nameLabel = [[UILabel alloc]init];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setFrame:CGRectMake((KProjectScreenWidth - 260.0f - KBtnContentLeftWidth/2), 0.0f, 240.0f, nameButton.height)];
    [nameLabel setText:KLvyeClubCurrentUser.userName];
    [nameLabel setTextAlignment:NSTextAlignmentRight];
    [nameLabel setFont:KContentLeftTitleFontOfSize];
    [nameLabel setTextColor:KContentGreyTextColor];
    self.userNameLabel = nameLabel;
    [nameButton addSubview:self.userNameLabel];
    
    UIView *nameBottomSeparate = [[UIView alloc]init];
    [nameBottomSeparate setBackgroundColor:KSeparateColorSetup];
    [nameBottomSeparate setFrame:CGRectMake(KBtnContentLeftWidth, nameButton.bottom,
                                             (KProjectScreenWidth - KBtnContentLeftWidth),
                                             1.0)];
    [contentBGView addSubview:nameBottomSeparate];
    
    ///手机号
    UIButtonCell *mobileButton = [UIButtonCell buttonNormalWithType:UIButtonTypeCustom];
    [mobileButton setTitle:@"手机号" forState:UIControlStateNormal];
    [mobileButton setTag:KButtonForUserMobileTag];
    [mobileButton addTarget:self action:@selector(userPersonalButtonEventOperation:)
             forControlEvents:UIControlEventTouchUpInside];
    [mobileButton setFrame:CGRectMake(0.0f, nameBottomSeparate.bottom, KProjectScreenWidth, KBtnForBtnCellNormalHeight)];
    [contentBGView addSubview:mobileButton];
    
    UILabel *mobileLabel = [[UILabel alloc]init];
    [mobileLabel setBackgroundColor:[UIColor clearColor]];
    [mobileLabel setFrame:CGRectMake((KProjectScreenWidth - 260.0f - KBtnContentLeftWidth/2), 0.0f, 240.0f, mobileButton.height)];
    [mobileLabel setText:KLvyeClubCurrentUser.userMobile];
    [mobileLabel setTextAlignment:NSTextAlignmentRight];
    [mobileLabel setFont:KContentLeftTitleFontOfSize];
    [mobileLabel setTextColor:KContentGreyTextColor];
    self.userMobileLabel = mobileLabel;
    [mobileButton addSubview:self.userMobileLabel];
    
    UIView *mobileBottomSeparate = [[UIView alloc]init];
    [mobileBottomSeparate setBackgroundColor:KSeparateColorSetup];
    [mobileBottomSeparate setFrame:CGRectMake(KBtnContentLeftWidth, mobileButton.bottom,
                                            (KProjectScreenWidth - KBtnContentLeftWidth),
                                            1.0)];
    [contentBGView addSubview:mobileBottomSeparate];

    ///密码
    UIButtonCell * passwordButton = [UIButtonCell buttonNormalWithType:UIButtonTypeCustom];
    [passwordButton setTitle:@"密码" forState:UIControlStateNormal];
    [passwordButton setTag:KButtonForUserPasswordTag];
    [passwordButton setFrame:CGRectMake(0.0f, mobileBottomSeparate.bottom, KProjectScreenWidth,
                                        KBtnForBtnCellNormalHeight)];
    [passwordButton addTarget:self action:@selector(userPersonalButtonEventOperation:)
             forControlEvents:UIControlEventTouchUpInside];
    [contentBGView addSubview:passwordButton];
    UILabel *passwordLabel = [[UILabel alloc]init];
    [passwordLabel setBackgroundColor:[UIColor clearColor]];
    [passwordLabel setFrame:CGRectMake((KProjectScreenWidth - 120.0f - KBtnContentLeftWidth/2), 0.0f, 100.0f, passwordButton.height)];
    [passwordLabel setText:@"✨✨✨✨"];
    [passwordLabel.layer setMasksToBounds:YES];
    [passwordLabel setTextAlignment:NSTextAlignmentRight];
    [passwordLabel setFont:KContentLeftTitleFontOfSize];
    [passwordLabel setTextColor:KContentGreyTextColor];
    [passwordButton addSubview:passwordLabel];
    UIView *passwordBottomSeparate = [[UIView alloc]init];
    [passwordBottomSeparate setBackgroundColor:KSeparateColorSetup];
    [passwordBottomSeparate setFrame:CGRectMake(KBtnContentLeftWidth, passwordButton.bottom,
                                              (KProjectScreenWidth - KBtnContentLeftWidth),
                                              1.0)];
    [contentBGView addSubview:passwordBottomSeparate];
    
    ///邮箱
    UIButtonCell * emailButton = [UIButtonCell buttonNormalWithType:UIButtonTypeCustom];
    [emailButton setTitle:@"邮箱" forState:UIControlStateNormal];
    [emailButton setTag:KButtonForUserEmailTag];
    [emailButton addTarget:self action:@selector(userPersonalButtonEventOperation:)
             forControlEvents:UIControlEventTouchUpInside];
    [emailButton setFrame:CGRectMake(0.0f, passwordBottomSeparate.bottom, KProjectScreenWidth, KBtnForBtnCellNormalHeight)];
    [contentBGView addSubview:emailButton];
    
    UILabel *emailLabel = [[UILabel alloc]init];
    [emailLabel setBackgroundColor:[UIColor clearColor]];
    [emailLabel setFrame:CGRectMake((KProjectScreenWidth - 260.0f - KBtnContentLeftWidth/2), 0.0f, 240.0f, emailButton.height)];
    [emailLabel setText:KLvyeClubCurrentUser.userEmail];
    [emailLabel setTextAlignment:NSTextAlignmentRight];
    [emailLabel setFont:KContentLeftTitleFontOfSize];
    [emailLabel setTextColor:KContentGreyTextColor];
    self.userEmailLabel= emailLabel;
    [emailButton addSubview:self.userEmailLabel];
}


- (void)userPersonalButtonEventOperation:(UIButtonCell *)button{
    
    
    EditUserStyle style = EditUserNameStyle;
    if (button.tag == KButtonForUserNameTag) {
        style = EditUserNameStyle;
    }else if (button.tag == KButtonForUserMobileTag){
        style = EditUserMoblieStyle;
    }else if (button.tag == KButtonForUserEmailTag){
        style = EditUserEmailStyle;
    }
    else if (button.tag == KButtonForUserPasswordTag){
        style = EditUserPasswordStyle;
    }
    
    
    PersonalInfoEditController  *viewController = [[PersonalInfoEditController alloc]initWithEditUserStyle:style];
    [viewController setTitle:@"编辑信息"];
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
