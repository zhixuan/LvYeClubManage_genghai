//
//  LoginViewController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/17.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LoginViewController.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+CLubInfo.h"
#import "LvYeHTTPClient+ClubUser.h"
//#import "BankInfo.h"
#import "ClubBankInfo.h"
#import "VerificationCodeImageView.h"


#define KInputContentCellHeight         (55.0)
#define KInputContentHeight             (KInputContentCellHeight*3+2.0f)


#define KLoginMobileFieldTag            (130031)
#define KLoginPasswordFieldTag          (130032)
#define KLoginVerCodeFieldTag           (130033)

@interface LoginViewController ()<UITextFieldDelegate>

/*!
 * @property
 * @brief 验证码数据界面
 */
@property (nonatomic , weak)      VerificationCodeImageView *codeImageView;

/*!
 * @property
 * @brief 验证码内容
 */
@property (nonatomic ,  strong)      NSString               *verCodeStr;


/*!
 * @property
 * @brief 手机号输入框
 */
@property (nonatomic , weak)      UITextField               *userMobileField;

/*!
 * @property
 * @brief 用户密码输入框
 */
@property (nonatomic , weak)      UITextField               *userPasswrdField;

/*!
 * @property
 * @brief 用户验证码输入框
 */
@property (nonatomic , weak)      UITextField               *userVerCodeField;
@end

@implementation LoginViewController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE ;
        
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
    [self setViewFrame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setViewFrame{
    

    UIView *bgInputView = [[UIView alloc]initWithFrame:CGRectMake(-1, 20.0f,
                                                                  KProjectScreenWidth+2.0f,
                                                                  KInputContentHeight)];
    [bgInputView setBackgroundColor:[UIColor whiteColor]];
    [bgInputView.layer setCornerRadius:2.0f];
    [bgInputView.layer setBorderColor:KBorderColorSetup.CGColor ];
    [bgInputView.layer setBorderWidth:1.0f];
    [bgInputView.layer setMasksToBounds:YES];
    [self.bgScrollView addSubview:bgInputView];
    
    
    UILabel   *mobileLable = [[UILabel alloc]init];
    [mobileLable setBackgroundColor:[UIColor clearColor]];
    [mobileLable setFont:[UIFont systemFontOfSize:18.0f]];
    [mobileLable setTextColor:KContentTextColor];
    [mobileLable setText:@"手机号:"];
    [mobileLable setTextAlignment:NSTextAlignmentLeft];
    [mobileLable setFrame:CGRectMake(10.0f, 0.0f, 60.0f,KInputContentCellHeight)];
    [bgInputView addSubview:mobileLable];
    
    UITextField *userPhoneText = [[UITextField alloc]init];
    [userPhoneText setFrame:CGRectMake((mobileLable.right + 10.0f), 0.0f, (bgInputView.width -
                                                                                 (mobileLable.right + 4.0f) - 15.0f),
                                       mobileLable.height)];
    [userPhoneText setTextColor:KContentTextColor];
    [userPhoneText setBackgroundColor:[UIColor clearColor]];
    [userPhoneText setTextAlignment:NSTextAlignmentLeft];
    [userPhoneText setPlaceholder:@"请输入手机号"];
    [userPhoneText setTag:KLoginMobileFieldTag];
    [userPhoneText setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [userPhoneText setKeyboardType:UIKeyboardTypePhonePad];
    [userPhoneText setReturnKeyType:UIReturnKeyNext];
    [userPhoneText setFont:KLVYEUIContentFontSize(18.0f)];
    [userPhoneText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [userPhoneText setDelegate:self];
    self.userMobileField = userPhoneText;
    [bgInputView addSubview:self.userMobileField];
    
    
    ///分割线
    UIView *sepView = [[UIView alloc]init];
    [sepView setBackgroundColor:KSeparateColorSetup];
    [sepView setFrame:CGRectMake(0.0f, mobileLable.bottom, bgInputView.width, 1.0f)];
    [bgInputView addSubview:sepView];
    
    UILabel   *passwordLable = [[UILabel alloc]init];
    [passwordLable setBackgroundColor:[UIColor clearColor]];
    [passwordLable setFont:[UIFont systemFontOfSize:18.0f]];
    [passwordLable setTextColor:KContentTextColor];
    [passwordLable setText:@"密  码:"];
    [passwordLable setTextAlignment:NSTextAlignmentLeft];
    [passwordLable setFrame:CGRectMake(10.0f, sepView.bottom, 60.0f, KInputContentCellHeight)];
    [bgInputView addSubview:passwordLable];
    
    
    UITextField *passwordText = [[UITextField alloc]init];
    [passwordText setFrame:CGRectMake((passwordLable.right + 10.0f), sepView.bottom, (bgInputView.width -
                                                                           (passwordLable.right + 4.0f) - 15.0f),
                                       passwordLable.height)];
    [passwordText setTextColor:KContentTextColor];
    [passwordText setBackgroundColor:[UIColor clearColor]];
    [passwordText setTextAlignment:NSTextAlignmentLeft];
    [passwordText setPlaceholder:@"密码"];
    [passwordText setTag:KLoginPasswordFieldTag];
    [passwordText setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [passwordText setKeyboardType:UIKeyboardTypeAlphabet];
    [passwordText setSecureTextEntry:YES];
    [passwordText setReturnKeyType:UIReturnKeyNext];
    [passwordText setFont:KLVYEUIContentFontSize(18.0f)];
    [passwordText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [passwordText setDelegate:self];
    self.userPasswrdField = passwordText;
    [bgInputView addSubview:self.userPasswrdField];
    
    ///分割线
    UIView *separateView = [[UIView alloc]init];
    [separateView setBackgroundColor:KSeparateColorSetup];
    [separateView setFrame:CGRectMake(0.0f, passwordLable.bottom, bgInputView.width, 1.0f)];
    [bgInputView addSubview:separateView];
    
    UILabel   *verCodeLable = [[UILabel alloc]init];
    [verCodeLable setBackgroundColor:[UIColor clearColor]];
    [verCodeLable setFont:[UIFont systemFontOfSize:18.0f]];
    [verCodeLable setTextColor:KContentTextColor];
    [verCodeLable setText:@"验证码:"];
    [verCodeLable setTextAlignment:NSTextAlignmentLeft];
    [verCodeLable setFrame:CGRectMake(15.0f, passwordLable.bottom, 60.0f, KInputContentCellHeight)];
    [bgInputView addSubview:verCodeLable];
    
    UITextField *verCodeText = [[UITextField alloc]init];
    [verCodeText setFrame:CGRectMake((verCodeLable.right + 10.0f), separateView.bottom, 90.0f,
                                      verCodeLable.height)];
    [verCodeText setTextColor:KContentTextColor];
    [verCodeText setBackgroundColor:[UIColor clearColor]];
    [verCodeText setTextAlignment:NSTextAlignmentLeft];
    [verCodeText setPlaceholder:@"验证码"];
    [verCodeText setTag:KLoginPasswordFieldTag];
    [verCodeText setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [verCodeText setKeyboardType:UIKeyboardTypeDefault];
    [verCodeText setReturnKeyType:UIReturnKeyNext];
    [verCodeText setFont:KLVYEUIContentFontSize(18.0f)];
    [verCodeText setClearButtonMode:UITextFieldViewModeUnlessEditing];
    [verCodeText setDelegate:self];
    self.userVerCodeField = verCodeText;
    [bgInputView addSubview:self.userVerCodeField];
    
    
    
    UIButton *freshCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [freshCodeBtn setBackgroundColor:[UIColor clearColor] ];
    [freshCodeBtn setFrame:CGRectMake((bgInputView.width - 55.0f-10.0f),
                                      separateView.bottom, 55.0f, KInputContentCellHeight)];
    [freshCodeBtn setTitle:@"看不清" forState:UIControlStateNormal];
    [freshCodeBtn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    [freshCodeBtn setTitleColor:[UIColor colorWithRed:133.0f/255.0f green:144.0/255.0f blue:155.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [freshCodeBtn setTitleColor:[UIColor colorWithRed:173.0f/255.0f green:204.0/255.0f blue:215.0f/255.0f alpha:1.0f] forState:UIControlStateHighlighted];
    [freshCodeBtn addTarget:self action:@selector(freshCodeBtnOperation)
           forControlEvents:UIControlEventTouchUpInside];
    [bgInputView addSubview:freshCodeBtn];
    
    
    
    VerificationCodeImageView *codeImageView = [[VerificationCodeImageView alloc]initWithFrame:CGRectMake((freshCodeBtn.left - 100.0f),
                                                                                                          (separateView.bottom + (KInputContentCellHeight -30.0f)/2),
                                                                                                          95.0f,
                                                                                                          30.0f)];
    self.codeImageView = codeImageView;
    [self.codeImageView setCodeLength:4];
    [self.codeImageView setIsRotation:YES];
    [self.codeImageView freshCodeContent];
    [bgInputView addSubview:self.codeImageView];
    
    
    __weak __typeof(&*self)weakSelf = self;
    self.codeImageView.block=^(NSString *code){//看情况是否需要
        NSLog(@"imageCodeStr = %@",code);
        weakSelf.verCodeStr =code;
    };
    
    UIButton *LoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [LoginBtn setBackgroundColor:[UIColor clearColor] ];
    [LoginBtn.layer setCornerRadius:2.0f];
    [LoginBtn.layer setMasksToBounds:YES];
    [LoginBtn setFrame:CGRectMake(10.0f,bgInputView.bottom + 20.0f,
                                  (KProjectScreenWidth -20.0f), KInputContentCellHeight)];
    [LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [LoginBtn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [LoginBtn setBackgroundImage:createImageWithColor(HUIRGBColor(32.0f, 170.0f, 238.0f, 1.0f))
                        forState:UIControlStateNormal];
    [LoginBtn setBackgroundImage:createImageWithColor(HUIRGBColor(42.0f, 180.0f, 248.0f, 1.0f))
                        forState:UIControlStateHighlighted];
    [LoginBtn addTarget:self action:@selector(userLoginBtnOperationEvent)
           forControlEvents:UIControlEventTouchUpInside];
    [self.bgScrollView addSubview:LoginBtn];
    
    
    ////设置已存在的数据内容。
    [self.userMobileField setText:KLvyeProductClubSettings.clubLoginUserMobile];
    ///处置验证码内容
    [self.codeImageView freshCodeContent];
}

- (void)setRightButtonEventOperation{
 
    [KShareHTTPLvyeHTTPClient clubBasicInfoWithClubId:KLvyeClubCurrentUser.clubId completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                NSDictionary * datainfo =(NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                
                NSLog(@"datainfo is %@",datainfo);
            }
        });
    }];
}

- (void)freshCodeBtnOperation{
    [self.codeImageView freshCodeContent];
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    if(textField.tag == KLoginPasswordFieldTag){
        [self.userPasswrdField becomeFirstResponder];
    }else if (textField.tag == KLoginVerCodeFieldTag){
        
    }
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (1 == range.length) {//按下回格键
        return YES;
    }
    if (textField.tag == KLoginMobileFieldTag) {
        NSCharacterSet *cs= [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@"\\"];
        BOOL txtlength = NO;
        if ([textField.text length] <= 10) {
            txtlength = YES;
        }
        BOOL canChange = [string isEqualToString:filtered] ? txtlength : NO;
        return canChange;
    }else if(textField.tag == KLoginPasswordFieldTag){
        NSCharacterSet *cs= [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"] invertedSet];
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@"\\"];
        BOOL txtlength = NO;
        if ([textField.text length] <= 20) {
            txtlength = YES;
        }
        BOOL canChange = [string isEqualToString:filtered] ? txtlength : NO;
        return canChange;
    }
    else if (textField.tag == KLoginVerCodeFieldTag){
        BOOL txtlength = NO;
        if ([textField.text length] <= 5) {
            txtlength = YES;
        }
        return txtlength;
    }
    return YES;
}


- (void)userLoginBtnOperationEvent{
    
    
    if(IsStringEmptyOrNull(self.userMobileField.text)){
        ShowImportErrorAlertView(@"请输入手机号！");
        return;
    }
    
    if(IsStringEmptyOrNull(self.userPasswrdField.text)){
        ShowImportErrorAlertView(@"请输密码！");
        return;
    }
    
    if(IsStringEmptyOrNull(self.userVerCodeField.text)){
        ShowImportErrorAlertView(@"请输入验证码");
        return;
    }
    
    if(!IsNormalMobileNum(self.userMobileField.text)){
        ShowImportErrorAlertView(@"请输入正确手机号！");
        return;
    }
    
    if (![self.userVerCodeField.text isEqualToString:self.verCodeStr]) {
        ShowImportErrorAlertView(@"验证码错误，请重新输入！");
        [self.codeImageView freshCodeContent];
        return;
    }

    
    
    
    NSString *beforeStr = generateRandStringWithBity(32);
    NSString *afterStr = [beforeStr substringFromIndex:16];
    beforeStr =[beforeStr substringToIndex:16];
    NSString *md5Password = EncryptPassword(self.userPasswrdField.text);
    beforeStr =[beforeStr substringToIndex:16];
    __block NSMutableString *userPasswordString =[[NSMutableString alloc]initWithString:beforeStr];
    [userPasswordString appendString:md5Password];
    [userPasswordString appendString:afterStr];
    
     __weak __typeof(&*self)weakSelf = self;

    NSLog(@"md5Password is %@",md5Password);
    [KShareHTTPLvyeHTTPClient userLoginWithUsrMobile:self.userMobileField.text password:userPasswordString completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if (response.code == WebAPIResponseCodeSuccess) {
                
                [KLvyeProductClubSettings setClubLoginUserPassword:userPasswordString];
                NSLog(@"response.code is %ld",response.code);
                NSLog(@"description is %@",response.description);
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    NSDictionary * datainfo =(NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    [KLvyeClubCurrentUser initClubCurrentUserInfoWithUnserializedJSONDic:datainfo];
                    
                    if (weakSelf.block) {
                        weakSelf.block(WebAPIResponseCodeSuccess);
                    }
                    
                }
            }else{
                ShowImportErrorAlertView(@"请稍后重试！");
            }
            
        });
    }];
    
}
@end
