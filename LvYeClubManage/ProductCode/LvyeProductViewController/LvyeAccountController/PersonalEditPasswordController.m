//
//  PersonalEditPasswordController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/3/28.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "PersonalEditPasswordController.h"
#import "UIButton+Bootstrap.h"
#import "LvyeHTTPClient.h"
#import "LvYeHTTPClient+ClubUser.h"

#define KTextFieldForOldPwdTag          (121001)
#define KTextFieldForNewPwdTag          (121002)
#define KTextFieldForSurePwdTag         (121003)

#define KButtonForForShowSecureTag      (122006)


@interface PersonalEditPasswordController()<UITextFieldDelegate>


/*!
 * @property
 * @brief 用户旧密码
 */
@property (nonatomic , weak)      UITextField               *userPerOldPasswordTextFiled;

/*!
 * @property
 * @brief 用户新密码
 */
@property (nonatomic , weak)      UITextField               *userPerNewPasswordTextFiled;

/*!
 * @property
 * @brief 用户确认密码
 */
@property (nonatomic , weak)      UITextField               *userPerConfirmPasswordTextFiled;


@end

@implementation PersonalEditPasswordController


#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
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
    // Do any additional setup after loading the view.
    
    [self setRightNavButtonTitleStr:@"更新" withFrame:kNavBarButtonRect
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
    [contentBGView setFrame:CGRectMake(KBtnContentLeftWidth, KBtnBackGroundTop, (KProjectScreenWidth-2*KBtnContentLeftWidth), KBtnForBtnCellNormalHeight*3+2.0f)];
    [self.bgScrollView addSubview:contentBGView];
    
    
    UILabel  * userIconLabel = [FontAwesome labelWithFAIcon:FMIconFontF0B1 size:20.0f color:KButtonStateNormalColor];
    [userIconLabel setBackgroundColor:[UIColor clearColor]];
    [userIconLabel setFrame:CGRectMake(KBtnContentLeftWidth*1.5, (KBtnForBtnCellNormalHeight - 20.0f)/2, 20.0f, 20.0f)];
    [contentBGView addSubview:userIconLabel];
    
    UITextField *userOldPwdText = [[UITextField alloc]init];
    [userOldPwdText setFrame:CGRectMake((userIconLabel.right + KBtnContentLeftWidth), 0.0f,
                                       (contentBGView.width - (KBtnForBtnCellNormalHeight + 23.0f) - 25.0f),
                                       KBtnForBtnCellNormalHeight)];
    [userOldPwdText setTextColor:KContentTextColor];
    [userOldPwdText setBackgroundColor:[UIColor clearColor]];
    [userOldPwdText setTextAlignment:NSTextAlignmentLeft];
    [userOldPwdText setTag:KTextFieldForOldPwdTag];
    [userOldPwdText setPlaceholder:@"请输旧密码"];
    [userOldPwdText setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [userOldPwdText setReturnKeyType:UIReturnKeyNext];
    [userOldPwdText setSecureTextEntry:YES];
    [userOldPwdText setFont:KLVYEUIContentFontSize(18.0f)];
    [userOldPwdText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [userOldPwdText setDelegate:self];
    self.userPerOldPasswordTextFiled = userOldPwdText;
    [contentBGView addSubview:self.userPerOldPasswordTextFiled];

    UIView *separateColorView = [[UIView alloc]init];
    [separateColorView setBackgroundColor:KSeparateColorSetup];
    [separateColorView setFrame:CGRectMake(0.0f, self.userPerOldPasswordTextFiled.bottom, contentBGView.width, 1.0f)];
    [contentBGView addSubview:separateColorView];
  
    UILabel  * userNewIconLabel = [FontAwesome labelWithFAIcon:FMIconFontF0B1 size:20.0f color:KButtonStateNormalColor];
    [userNewIconLabel setBackgroundColor:[UIColor clearColor]];
    [userNewIconLabel setFrame:CGRectMake(KBtnContentLeftWidth*1.5, (separateColorView.bottom+(KBtnForBtnCellNormalHeight - 20.0f)/2), 20.0f, 20.0f)];
    [contentBGView addSubview:userNewIconLabel];
    
    UITextField *userNewPwdText = [[UITextField alloc]init];
    [userNewPwdText setFrame:CGRectMake((userIconLabel.right + KBtnContentLeftWidth), separateColorView.bottom,
                                        (contentBGView.width - (KBtnForBtnCellNormalHeight + 23.0f) - 25.0f),
                                        KBtnForBtnCellNormalHeight)];
    [userNewPwdText setTextColor:KContentTextColor];
    [userNewPwdText setBackgroundColor:[UIColor clearColor]];
    [userNewPwdText setTextAlignment:NSTextAlignmentLeft];
    [userNewPwdText setPlaceholder:@"请输新密码"];
    [userNewPwdText setTag:KTextFieldForNewPwdTag];
    [userNewPwdText setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [userNewPwdText setReturnKeyType:UIReturnKeyNext];
    [userNewPwdText setSecureTextEntry:YES];
    [userNewPwdText setFont:KLVYEUIContentFontSize(18.0f)];
    [userNewPwdText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [userNewPwdText setDelegate:self];
    self.userPerNewPasswordTextFiled = userNewPwdText;
    [contentBGView addSubview:self.userPerNewPasswordTextFiled];
    
    
    UIButton *pwdShowBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pwdShowBtn setFrame:CGRectMake(userOldPwdText.right + 5.0f,(separateColorView.bottom+(KBtnForBtnCellNormalHeight - 30.0f)/2), 30.0f, 30.0f)];
    pwdShowBtn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [pwdShowBtn addTarget:self action:@selector(userPersonalPasswordDisplaySecure:)
         forControlEvents:UIControlEventTouchUpInside];
    [pwdShowBtn setTag:KButtonForForShowSecureTag];
    pwdShowBtn.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
    [pwdShowBtn simpleButtonWithImageColor:KButtonStateNormalColor];
    [pwdShowBtn addAwesomeIcon:FMIconFontF070 beforeTitle:NO];
    [contentBGView addSubview:pwdShowBtn];
    
    UIView *separateNewColorView = [[UIView alloc]init];
    [separateNewColorView setBackgroundColor:KSeparateColorSetup];
    [separateNewColorView setFrame:CGRectMake(0.0f, self.userPerNewPasswordTextFiled.bottom, contentBGView.width, 1.0f)];
    [contentBGView addSubview:separateNewColorView];
 
    UILabel  * userDoneIconLabel = [FontAwesome labelWithFAIcon:FMIconFontF0B1 size:20.0f color:KButtonStateNormalColor];
    [userDoneIconLabel setBackgroundColor:[UIColor clearColor]];
    [userDoneIconLabel setFrame:CGRectMake(KBtnContentLeftWidth*1.5, (separateNewColorView.bottom+(KBtnForBtnCellNormalHeight - 20.0f)/2), 20.0f, 20.0f)];
    [contentBGView addSubview:userDoneIconLabel];
    
    UITextField *userDonePwdText = [[UITextField alloc]init];
    [userDonePwdText setFrame:CGRectMake((userIconLabel.right + KBtnContentLeftWidth), separateNewColorView.bottom,
                                        (contentBGView.width - (KBtnForBtnCellNormalHeight + 23.0f) - 25.0f),
                                        KBtnForBtnCellNormalHeight)];
    [userDonePwdText setTextColor:KContentTextColor];
    [userDonePwdText setBackgroundColor:[UIColor clearColor]];
    [userDonePwdText setTextAlignment:NSTextAlignmentLeft];
    [userDonePwdText setPlaceholder:@"请再次确认密码"];
    [userDonePwdText setTag:KTextFieldForSurePwdTag];
    [userDonePwdText setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [userDonePwdText setReturnKeyType:UIReturnKeyNext];
    [userDonePwdText setSecureTextEntry:YES];
    [userDonePwdText setFont:KLVYEUIContentFontSize(18.0f)];
    [userDonePwdText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [userDonePwdText setDelegate:self];
    self.userPerConfirmPasswordTextFiled = userDonePwdText;
    [contentBGView addSubview:self.userPerConfirmPasswordTextFiled];
}

- (void)userSaveEditInfoClicked{
 
    
    if(IsStringEmptyOrNull(self.userPerOldPasswordTextFiled.text)){
        ShowImportErrorAlertControl(@"请输入旧密码！", self);
        return;
    }
    
    if(IsStringEmptyOrNull(self.userPerNewPasswordTextFiled.text)){
        ShowImportErrorAlertControl(@"请输入新密码！", self);
        return;
    }
    
    if(IsStringEmptyOrNull(self.userPerConfirmPasswordTextFiled.text)){
        ShowImportErrorAlertControl(@"请再次输入新密码！", self);
        return;
    }
    
    
    if (![self.userPerConfirmPasswordTextFiled.text isEqualToString:self.userPerNewPasswordTextFiled.text] ) {
        ShowImportErrorAlertControl(@"两次密码输入不同，请重新r输入", self);
        return;
    }
    
    
    
    NSString *beforeStr = generateRandStringWithBity(32);
    NSString *afterStr = [beforeStr substringFromIndex:16];
    beforeStr =[beforeStr substringToIndex:16];
    
    
    NSString *md5Password = EncryptPassword(self.userPerOldPasswordTextFiled.text);
    __block NSMutableString *userPasswordString =[[NSMutableString alloc]initWithString:beforeStr];
    [userPasswordString appendString:md5Password];
    [userPasswordString appendString:afterStr];
    
    
    beforeStr = generateRandStringWithBity(32);
    afterStr = [beforeStr substringToIndex:16];
    beforeStr =[beforeStr substringFromIndex:16];
    
    NSString *md5NewPassword =EncryptPassword(self.userPerConfirmPasswordTextFiled.text);
    __block NSMutableString *userNewPasswordString =[[NSMutableString alloc]initWithString:beforeStr];
    [userNewPasswordString appendString:md5NewPassword];
    [userNewPasswordString appendString:afterStr];
    
    __weak __typeof(&*self)weakSelf = self;
    [KShareHTTPLvyeHTTPClient clubUserUpdatePersonalPasswordWithClubId:KLvyeClubCurrentUser.clubId userId:KLvyeClubCurrentUser.userId old:userPasswordString new:userNewPasswordString completion:^(WebAPIResponse *response) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            NSLog(@"response.responseObject is %@",response.responseObject);
            if (response.code == WebAPIResponseCodeSuccess) {
                
                [KLvyeProductClubSettings setClubLoginUserPassword:userNewPasswordString];
                [weakSelf.navigationController popViewControllerAnimated:YES];
                
            }else if(response.code == WebAPIResponseCodeFailed){
                ShowImportErrorAlertControl(StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg), self);
            }
        });
    }];
}

- (void)userPersonalPasswordDisplaySecure:(UIButton *)btn{
    [self.userPerNewPasswordTextFiled setSecureTextEntry:!self.userPerNewPasswordTextFiled.secureTextEntry];
    [btn setAwesomeIcon: self.userPerNewPasswordTextFiled.secureTextEntry?FMIconFontF070: FMIconFontF06E];
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField.tag == KTextFieldForOldPwdTag){
        [self.userPerNewPasswordTextFiled becomeFirstResponder];
    }else if (textField.tag == KTextFieldForNewPwdTag){
        [self.userPerConfirmPasswordTextFiled becomeFirstResponder];
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (1 == range.length) {//按下回格键
        return YES;
    }
        ///密码限制在20位以内的字母、数字（区分大小写）
        NSCharacterSet *cs= [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@"\\"];
        BOOL txtlength = NO;
        if ([textField.text length] <= 20) {
            txtlength = YES;
        }
        BOOL canChange = [string isEqualToString:filtered] ? txtlength : NO;
        return canChange;
}

@end
