//
//  ClubAddAdministratorController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//


#define KBtnOneBackGroudViewHeight      (KBtnForBtnCellNormalHeight*7.0 + 6.0f)

#define KContentTitleWidth              (80.0f)
#import "ClubAddAdministratorController.h"
#import "NSString+TransformCategory.h"
#import "ClubDepartmentViewController.h"


@interface ClubAddAdministratorController ()<ClubDepartmentSelectDelegate,UITextFieldDelegate>

/*!
 * @property
 * @brief 用户信息对象
 */
@property (nonatomic , strong)      ClubUserInfo    *clubUserAddAdministrator;

/*!
 * @property
 * @brief 用户名
 */
@property (nonatomic , weak)      UITextField       *clubAdminNameField;

/*!
 * @property
 * @brief 用户名拼音
 */
@property (nonatomic , weak)      UITextField       *clubAdminNameLetterField;

/*!
 * @property
 * @brief 用户密码
 */
@property (nonatomic , weak)      UITextField       *clubAdminPasswordField;

/*!
 * @property
 * @brief 用户手机号
 */
@property (nonatomic , weak)      UITextField       *clubAdminMobileField;

/*!
 * @property
 * @brief 用户电子邮箱
 */
@property (nonatomic , weak)      UITextField       *clubAdminEmailField;

/*!
 * @property
 * @brief 部门信息
 */
@property (nonatomic ,  weak)      UILabel          *userDepartmentNameLabel;

@end

@implementation ClubAddAdministratorController


#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithUserInfo:(ClubUserInfo *)userInfo{
    self = [super init];
    if (self) {
        self.clubUserAddAdministrator =userInfo;
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
    
//    NSString *chineseStr = @"进入到这里操作了";
//    NSString *charStr = [chineseStr transformLetterWithChinese];
//    NSLog(@"charStr is %@",charStr);
    
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
    
    ///用户名
    UILabel *userNameLabel = [[UILabel alloc]init];
    [userNameLabel setBackgroundColor:[UIColor clearColor]];
    [userNameLabel setFrame:CGRectMake(KBtnContentLeftWidth, 0.0f, KContentTitleWidth,
                                       KBtnForBtnCellNormalHeight)];
    [userNameLabel setText:@"用户姓名"];
    [userNameLabel setTextAlignment:NSTextAlignmentLeft];
    [userNameLabel setFont:KContentLeftTitleFontOfSize];
    [userNameLabel setTextColor:KContentTextColor];
    [contentBGView addSubview:userNameLabel];
    UIView *nameBottomSeparate = [[UIView alloc]init];
    [nameBottomSeparate setBackgroundColor:KSeparateColorSetup];
    [nameBottomSeparate setFrame:CGRectMake(KBtnContentLeftWidth, userNameLabel.bottom,
                                            (KProjectScreenWidth - KBtnContentLeftWidth),
                                            1.0)];
    [contentBGView addSubview:nameBottomSeparate];
    
    UITextField *userNameText = [[UITextField alloc]init];
    [userNameText setFrame:CGRectMake((userNameLabel.right + 20.0f), 0.0f,
                                       (KProjectScreenWidth - (KBtnContentLeftWidth + KContentTitleWidth) - 55.0f),
                                       KBtnForBtnCellNormalHeight)];
    [userNameText setTextColor:KContentTextColor];
    [userNameText setBackgroundColor:[UIColor clearColor]];
    [userNameText setTextAlignment:NSTextAlignmentLeft];
    [userNameText setPlaceholder:@"请输入用户姓名"];
    [userNameText setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [userNameText setKeyboardType:UIKeyboardTypeDefault];
    [userNameText setReturnKeyType:UIReturnKeyNext];
    [userNameText setFont:KLVYEUIContentFontSize(18.0f)];
    [userNameText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [userNameText setDelegate:self];
    self.clubAdminNameField = userNameText;
    [contentBGView addSubview:self.clubAdminNameField];
    
    
    ///用户名
    UILabel *userLetterNameLabel = [[UILabel alloc]init];
    [userLetterNameLabel setBackgroundColor:[UIColor clearColor]];
    [userLetterNameLabel setFrame:CGRectMake(KBtnContentLeftWidth, nameBottomSeparate.bottom,
                                             KContentTitleWidth, KBtnForBtnCellNormalHeight)];
    [userLetterNameLabel setText:@"用户名"];
    [userLetterNameLabel setTextAlignment:NSTextAlignmentLeft];
    [userLetterNameLabel setFont:KContentLeftTitleFontOfSize];
    [userLetterNameLabel setTextColor:KContentTextColor];
    [contentBGView addSubview:userLetterNameLabel];
    
    UIView *letterBottomSeparate = [[UIView alloc]init];
    [letterBottomSeparate setBackgroundColor:KSeparateColorSetup];
    [letterBottomSeparate setFrame:CGRectMake(KBtnContentLeftWidth, userLetterNameLabel.bottom,
                                            (KProjectScreenWidth - KBtnContentLeftWidth),
                                            1.0)];
    [contentBGView addSubview:letterBottomSeparate];
    
    UITextField *userLetterNameText = [[UITextField alloc]init];
    [userLetterNameText setFrame:CGRectMake((userNameLabel.right + 20.0f), nameBottomSeparate.bottom,
                                      (KProjectScreenWidth - (KBtnContentLeftWidth + KContentTitleWidth) - 55.0f),
                                      KBtnForBtnCellNormalHeight)];
    [userLetterNameText setTextColor:KContentTextColor];
    [userLetterNameText setBackgroundColor:[UIColor clearColor]];
    [userLetterNameText setTextAlignment:NSTextAlignmentLeft];
    [userLetterNameText setPlaceholder:@"请输入用户姓名"];
    [userLetterNameText setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [userLetterNameText setKeyboardType:UIKeyboardTypeDefault];
    [userLetterNameText setReturnKeyType:UIReturnKeyNext];
    [userLetterNameText setFont:KLVYEUIContentFontSize(18.0f)];
    [userLetterNameText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [userLetterNameText setDelegate:self];
    self.clubAdminNameLetterField = userLetterNameText;
    [contentBGView addSubview:self.clubAdminNameLetterField];
    
    
    
    ///用户密码
    UILabel *userPasswordLabel = [[UILabel alloc]init];
    [userPasswordLabel setBackgroundColor:[UIColor clearColor]];
    [userPasswordLabel setFrame:CGRectMake(KBtnContentLeftWidth, letterBottomSeparate.bottom,
                                           KContentTitleWidth, KBtnForBtnCellNormalHeight)];
    [userPasswordLabel setText:@"用户密码"];
    [userPasswordLabel setTextAlignment:NSTextAlignmentLeft];
    [userPasswordLabel setFont:KContentLeftTitleFontOfSize];
    [userPasswordLabel setTextColor:KContentTextColor];
    [contentBGView addSubview:userPasswordLabel];
    UIView *passwordBottomSeparate = [[UIView alloc]init];
    [passwordBottomSeparate setBackgroundColor:KSeparateColorSetup];
    [passwordBottomSeparate setFrame:CGRectMake(KBtnContentLeftWidth, userPasswordLabel.bottom,
                                              (KProjectScreenWidth - KBtnContentLeftWidth),
                                              1.0)];
    [contentBGView addSubview:passwordBottomSeparate];
    
    UITextField *userPasswordText = [[UITextField alloc]init];
    [userPasswordText setFrame:CGRectMake((userNameLabel.right + 20.0f), letterBottomSeparate.bottom,
                                            (KProjectScreenWidth - (KBtnContentLeftWidth + KContentTitleWidth) - 55.0f),
                                            KBtnForBtnCellNormalHeight)];
    [userPasswordText setTextColor:KContentTextColor];
    [userPasswordText setBackgroundColor:[UIColor clearColor]];
    [userPasswordText setTextAlignment:NSTextAlignmentLeft];
    [userPasswordText setPlaceholder:@"请输入用户姓名"];
    [userPasswordText setText:@"000000"];
    [userPasswordText setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [userPasswordText setKeyboardType:UIKeyboardTypeDefault];
    [userPasswordText setReturnKeyType:UIReturnKeyNext];
    [userPasswordText setFont:KLVYEUIContentFontSize(18.0f)];
    [userPasswordText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [userPasswordText setDelegate:self];
    self.clubAdminPasswordField = userPasswordText;
    [contentBGView addSubview:self.clubAdminPasswordField];
    
    ///用户手机
    UILabel *userMobileLabel = [[UILabel alloc]init];
    [userMobileLabel setBackgroundColor:[UIColor clearColor]];
    [userMobileLabel setFrame:CGRectMake(KBtnContentLeftWidth, passwordBottomSeparate.bottom,
                                         KContentTitleWidth, KBtnForBtnCellNormalHeight)];
    [userMobileLabel setText:@"用户手机"];
    [userMobileLabel setTextAlignment:NSTextAlignmentLeft];
    [userMobileLabel setFont:KContentLeftTitleFontOfSize];
    [userMobileLabel setTextColor:KContentTextColor];
    [contentBGView addSubview:userMobileLabel];
    
    UIView *mobileBottomSeparate = [[UIView alloc]init];
    [mobileBottomSeparate setBackgroundColor:KSeparateColorSetup];
    [mobileBottomSeparate setFrame:CGRectMake(KBtnContentLeftWidth, userMobileLabel.bottom,
                                                (KProjectScreenWidth - KBtnContentLeftWidth),
                                                1.0)];
    [contentBGView addSubview:mobileBottomSeparate];
    UITextField *userPhoneText = [[UITextField alloc]init];
    [userPhoneText setFrame:CGRectMake((userMobileLabel.right + 20.0f), passwordBottomSeparate.bottom,
                                       (KProjectScreenWidth - (KBtnContentLeftWidth + KContentTitleWidth) - 55.0f),
                                       KBtnForBtnCellNormalHeight)];
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
    self.clubAdminMobileField = userPhoneText;
    [contentBGView addSubview:self.clubAdminMobileField];
    
    ///用户邮箱
    UILabel *userEmailLabel = [[UILabel alloc]init];
    [userEmailLabel setBackgroundColor:[UIColor clearColor]];
    [userEmailLabel setFrame:CGRectMake(KBtnContentLeftWidth, mobileBottomSeparate.bottom,
                                         KContentTitleWidth, KBtnForBtnCellNormalHeight)];
    [userEmailLabel setText:@"用户邮箱"];
    [userEmailLabel setTextAlignment:NSTextAlignmentLeft];
    [userEmailLabel setFont:KContentLeftTitleFontOfSize];
    [userEmailLabel setTextColor:KContentTextColor];
    [contentBGView addSubview:userEmailLabel];
    UIView *emailBottomSeparate = [[UIView alloc]init];
    [emailBottomSeparate setBackgroundColor:KSeparateColorSetup];
    [emailBottomSeparate setFrame:CGRectMake(KBtnContentLeftWidth, userEmailLabel.bottom,
                                              (KProjectScreenWidth - KBtnContentLeftWidth),
                                              1.0)];
    [contentBGView addSubview:emailBottomSeparate];
    
    UITextField *userEmailText = [[UITextField alloc]init];
    [userEmailText setFrame:CGRectMake((userNameLabel.right + 20.0f), mobileBottomSeparate.bottom,
                                          (KProjectScreenWidth - (KBtnContentLeftWidth + KContentTitleWidth) - 55.0f),
                                          KBtnForBtnCellNormalHeight)];
    [userEmailText setTextColor:KContentTextColor];
    [userEmailText setBackgroundColor:[UIColor clearColor]];
    [userEmailText setTextAlignment:NSTextAlignmentLeft];
    [userEmailText setPlaceholder:@"请输入邮箱"];
    [userEmailText setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [userEmailText setKeyboardType:UIKeyboardTypeDefault];
    [userEmailText setReturnKeyType:UIReturnKeyNext];
    [userEmailText setFont:KLVYEUIContentFontSize(18.0f)];
    [userEmailText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [userEmailText setDelegate:self];
    self.clubAdminEmailField = userEmailText;
    [contentBGView addSubview:self.clubAdminEmailField];
    
    
    ///手机号
    UIButtonCell *departmentButton = [UIButtonCell buttonNormalWithType:UIButtonTypeCustom];
    [departmentButton setTitle:@"所属部门" forState:UIControlStateNormal];
    [departmentButton addTarget:self action:@selector(userPersonalButtonEventOperation:)
           forControlEvents:UIControlEventTouchUpInside];
    [departmentButton setFrame:CGRectMake(0.0f, emailBottomSeparate.bottom, KProjectScreenWidth, KBtnForBtnCellNormalHeight)];
    [contentBGView addSubview:departmentButton];
    
    UILabel *departmentLabel = [[UILabel alloc]init];
    [departmentLabel setBackgroundColor:[UIColor clearColor]];
    [departmentLabel setFrame:CGRectMake((KProjectScreenWidth - 260.0f - KBtnContentLeftWidth/2), 0.0f, 240.0f, departmentButton.height)];
    [departmentLabel setText:@"选择部门"];
    [departmentLabel setTextAlignment:NSTextAlignmentRight];
    [departmentLabel setFont:KContentLeftTitleFontOfSize];
    [departmentLabel setTextColor:KContentGreyTextColor];
    self.userDepartmentNameLabel = departmentLabel;
    [departmentButton addSubview:self.userDepartmentNameLabel];
    
}

- (void)userSaveEditInfoClicked{
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)userPersonalButtonEventOperation:(UIButtonCell *)button{
    
    ClubDepartmentViewController*viewController = [[ClubDepartmentViewController alloc]initWithDelegate:self];
    [viewController setTitle:@"部门列表"];
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)userSelectedClubDepartmentFinishOperation:(NSDictionary *)info{

    if(info != NULL && [info count] >0){
        [self.userDepartmentNameLabel setText:StringForKeyInUnserializedJSONDic(info, @"departmentName")];
    }
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}
@end
