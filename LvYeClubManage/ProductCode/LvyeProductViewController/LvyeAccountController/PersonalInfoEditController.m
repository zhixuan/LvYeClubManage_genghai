//
//  PersonalInfoEditController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/9.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "PersonalInfoEditController.h"

#define KBtnOneBackGroudViewHeight                 (KBtnForBtnCellNormalHeight*1.0)


@interface PersonalInfoEditController ()<UITextFieldDelegate>
/*!
 * @property
 * @brief 编辑用户类别 Style Type
 */
@property (nonatomic , assign)      EditUserStyle    userStyle;

/*!
 * @property
 * @brief 用户信息编辑框
 */
@property (nonatomic ,  weak)      UITextField      *userInfTextField;
@end

@implementation PersonalInfoEditController
#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithEditUserStyle:(EditUserStyle)style{
    self = [super init];
    if (self) {
        self.userStyle = style;
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
    // Do any additional setup after loading the view.
    
    [self setRightNavButtonTitleStr:@"完成" withFrame:kNavBarButtonRect
                       actionTarget:self action:@selector(userSaveEditInfoClicked)];
    [self setViewControlFrame];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setViewControlFrame{
    
    UIView *contentBGView = [[UIView alloc]init];
    [contentBGView setBackgroundColor:[UIColor whiteColor]];
    [contentBGView setFrame:CGRectMake(0.0f, KBtnBackGroundTop, KProjectScreenWidth, KBtnOneBackGroudViewHeight)];
    [self.bgScrollView addSubview:contentBGView];
    
    UILabel  * userIconLabel = [FontAwesome labelWithFAIcon:FMIconFontF007 size:20.0f color:KButtonStateNormalColor];
    [userIconLabel setBackgroundColor:[UIColor clearColor]];
    [userIconLabel setFrame:CGRectMake(KBtnContentLeftWidth, (KBtnOneBackGroudViewHeight - 20.0f)/2, 20.0f, 20.0f)];
    [contentBGView addSubview:userIconLabel];
    
    UITextField *userPhoneText = [[UITextField alloc]init];
    [userPhoneText setFrame:CGRectMake((userIconLabel.right + 10.0f), 0.0f,
                                       (KProjectScreenWidth - (KBtnContentLeftWidth + 23.0f) - 25.0f),
                                       KBtnOneBackGroudViewHeight)];
    [userPhoneText setTextColor:KContentTextColor];
    [userPhoneText setBackgroundColor:[UIColor clearColor]];
    [userPhoneText setTextAlignment:NSTextAlignmentLeft];
    [userPhoneText setPlaceholder:@"请输入手机号"];
    [userPhoneText setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [userPhoneText setKeyboardType:UIKeyboardTypePhonePad];
    [userPhoneText setReturnKeyType:UIReturnKeyNext];
    [userPhoneText setFont:KLVYEUIContentFontSize(18.0f)];
    [userPhoneText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [userPhoneText setDelegate:self];
    self.userInfTextField = userPhoneText;
    [contentBGView addSubview:self.userInfTextField];

    if (self.userStyle == EditUserNameStyle) {
        [userPhoneText setPlaceholder:@"请输入用户名"];
        [userPhoneText setKeyboardType:UIKeyboardTypeDefault];
        [userPhoneText setText:KLvyeClubCurrentUser.userName];
    } else if (self.userStyle == EditUserMoblieStyle){
        [userPhoneText setPlaceholder:@"请输入手机号"];
        [userPhoneText setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        [userPhoneText setKeyboardType:UIKeyboardTypePhonePad];
        [userPhoneText setText:KLvyeClubCurrentUser.userMobile];
    } else if (self.userStyle == EditUserPasswordStyle){
        [userPhoneText setPlaceholder:@"请输入密码"];
        [userPhoneText setKeyboardType:UIKeyboardTypeDefault];
        [userPhoneText setText:KLvyeProductClubSettings.clubLoginUserPassword];
        [userPhoneText setSecureTextEntry:YES];
    }else if (self.userStyle == EditUserEmailStyle){
        [userPhoneText setPlaceholder:@"请输入邮箱"];
        [userPhoneText setText:KLvyeClubCurrentUser.userEmail];
        [userPhoneText setKeyboardType:UIKeyboardTypeEmailAddress];
    }
}


- (void)userSaveEditInfoClicked{
    
    
    
}

@end
