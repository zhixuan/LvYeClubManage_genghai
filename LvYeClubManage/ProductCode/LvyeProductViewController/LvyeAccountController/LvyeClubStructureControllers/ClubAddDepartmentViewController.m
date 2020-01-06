//
//  ClubAddDepartmentViewController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubAddDepartmentViewController.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+CLubInfo.h"
#import "LGTextView.h"


#define KBtnOneBackGroudViewHeight      (KBtnForBtnCellNormalHeight*5.0 + 6.0f)

#define KContentTitleWidth              (80.0f)

@interface ClubAddDepartmentViewController ()<UITextFieldDelegate,UITextViewDelegate>


/*!
 * @property
 * @brief 操作控制协议
 */
@property (nonatomic ,  assign)      id<ClubAddDepartmentDelegate>      delegate;
/*!
 * @property
 * @brief 部门名字
 */
@property (nonatomic ,  weak)      UITextField              *clubDepartmentNameField;

/*!
 * @property
 * @brief 部门介绍
 */
@property (nonatomic , weak)      LGTextView                *clubDepartmentIntroduceTextView;

@end

@implementation ClubAddDepartmentViewController


#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark -
#pragma mark -  系统方法
- (instancetype)initWithDelegate:(id<ClubAddDepartmentDelegate>)delegate{
    self = [super init];
    if (self) {
        self.delegate = delegate;
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
    
    [self setViewControlFrame];
    // Do any additional setup after loading the view.
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
    
    ///部门名
    UILabel *userNameLabel = [[UILabel alloc]init];
    [userNameLabel setBackgroundColor:[UIColor clearColor]];
    [userNameLabel setFrame:CGRectMake(KBtnContentLeftWidth, 0.0f, KContentTitleWidth,
                                       KBtnForBtnCellNormalHeight)];
    [userNameLabel setText:@"部门名"];
    [userNameLabel setTextAlignment:NSTextAlignmentLeft];
    [userNameLabel setFont:KContentLeftTitleFontOfSize];
    [userNameLabel setTextColor:KContentTextColor];
    [contentBGView addSubview:userNameLabel];
    
    
    
    UITextField *departmentNameText = [[UITextField alloc]init];
    [departmentNameText setFrame:CGRectMake((userNameLabel.right + 10.0f), 0.0f,
                                            (KProjectScreenWidth - (KBtnContentLeftWidth + KContentTitleWidth) - 25.0f),
                                            KBtnForBtnCellNormalHeight)];
    [departmentNameText setTextColor:KContentTextColor];
    [departmentNameText setBackgroundColor:[UIColor clearColor]];
    [departmentNameText setTextAlignment:NSTextAlignmentLeft];
    [departmentNameText setPlaceholder:@"请输入部门名"];
    [departmentNameText setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [departmentNameText setReturnKeyType:UIReturnKeyDone];
    [departmentNameText setFont:KLVYEUIContentFontSize(18.0f)];
    [departmentNameText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [departmentNameText setDelegate:self];
    self.clubDepartmentNameField = departmentNameText;
    [contentBGView addSubview:self.clubDepartmentNameField];
    
    UIView *nameBottomSeparate = [[UIView alloc]init];
    [nameBottomSeparate setBackgroundColor:KSeparateColorSetup];
    [nameBottomSeparate setFrame:CGRectMake(KBtnContentLeftWidth, userNameLabel.bottom,
                                            (KProjectScreenWidth - KBtnContentLeftWidth),
                                            1.0)];
    [contentBGView addSubview:nameBottomSeparate];
    
    
    ///部门介绍
    UILabel *introduceLabel = [[UILabel alloc]init];
    [introduceLabel setBackgroundColor:[UIColor clearColor]];
    [introduceLabel setFrame:CGRectMake(KBtnContentLeftWidth, nameBottomSeparate.bottom,
                                        KContentTitleWidth, KBtnForBtnCellNormalHeight)];
    [introduceLabel setText:@"部门介绍"];
    [introduceLabel setTextAlignment:NSTextAlignmentLeft];
    [introduceLabel setFont:KContentLeftTitleFontOfSize];
    [introduceLabel setTextColor:KContentTextColor];
    [contentBGView addSubview:introduceLabel];
    
    
    LGTextView *departmentIntTextView = [[LGTextView alloc]init];
    [departmentIntTextView setBackgroundColor:[UIColor clearColor]];
    [departmentIntTextView setFont:KContentLeftTitleFontOfSize];
    [departmentIntTextView setDelegate:self];
    [departmentIntTextView.layer setCornerRadius:1.0f];
    [departmentIntTextView.layer setMasksToBounds:YES];
    [departmentIntTextView.layer setBorderWidth:1.0f];
    [departmentIntTextView.layer setBorderColor:KSeparateColorSetup.CGColor];
    [departmentIntTextView setFrame:CGRectMake((introduceLabel.right + 10.0f), nameBottomSeparate.bottom+10.0f,
                                               (KProjectScreenWidth - (introduceLabel.right + 10.0f) - KInforLeftIntervalWidth),
                                               KBtnForBtnCellNormalHeight*3.5)];
    [departmentIntTextView setTextAlignment:NSTextAlignmentLeft];
    [departmentIntTextView setPlaceholder:@"部门介绍不少于10个字" ];
//    [departmentIntTextView setPlaceholderTextColor:HUIRGBColor(164.0, 163.0f, 176.0f, 1.0f)];
    [departmentIntTextView setPlaceholderTextColor:HUIRGBColor(255.0f*0.5, 255.0f*0.5, 255.0f*0.5, 0.7f)];

    [departmentIntTextView setPlaceholderTextColor:[[UIColor grayColor] colorWithAlphaComponent:0.7]];


    self.clubDepartmentIntroduceTextView = departmentIntTextView;
    [contentBGView addSubview:self.clubDepartmentIntroduceTextView ];
    
    
    UIButton *LoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [LoginBtn setBackgroundColor:[UIColor clearColor] ];
    [LoginBtn.layer setCornerRadius:2.0f];
    [LoginBtn.layer setMasksToBounds:YES];
    [LoginBtn setFrame:CGRectMake(10.0f,contentBGView.bottom + 20.0f,
                                  (KProjectScreenWidth -20.0f), KBtnCellHeight)];
    [LoginBtn setTitle:@"提 交" forState:UIControlStateNormal];
    [LoginBtn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [LoginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [LoginBtn setBackgroundImage:createImageWithColor(KButtonStateNormalColor)
                        forState:UIControlStateNormal];
    [LoginBtn setBackgroundImage:createImageWithColor(KButtonTextHighlightedColor)
                        forState:UIControlStateHighlighted];
    [LoginBtn addTarget:self action:@selector(userPersonalSubmitInfoOperation)
       forControlEvents:UIControlEventTouchUpInside];
    [self.bgScrollView addSubview:LoginBtn];
    
//    UIImageView  *imageView = [[UIImageView alloc]init];
//    [imageView setBackgroundColor:[UIColor clearColor]];
//    [imageView setFrame:CGRectMake((KProjectScreenWidth - 28.0f)/2, LoginBtn.bottom +40.0f, 28.0f, 28.0f)];
//    UIImage *imageInfo = [UIImage imageNamed:@"iconlist.png"];
//    imageInfo = [imageInfo thumbScaleImageWithPoint:CGPointMake(294,106) size:CGSizeMake(56, 56)];
//    [imageView setImage:imageInfo];
//    [self.bgScrollView addSubview:imageView];
    
    UIImageView  *imageView = [[UIImageView alloc]init];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [imageView setFrame:CGRectMake((KProjectScreenWidth - 28.0f)/2, LoginBtn.bottom +40.0f, 28.0f, 28.0f)];
    UIImage *imageInfo = [UIImage imageNamed:@"iconlist.png"];
    imageInfo = [imageInfo thumbScaleImageWithPoint:CGPointMake(162,65) size:CGSizeMake(30, 30)];
    [imageView setImage:imageInfo];
    [self.bgScrollView addSubview:imageView];
    
    
}


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{

    [self.clubDepartmentIntroduceTextView becomeFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{

    
    if (1 == range.length) {//按下回格键
        return YES;
    }
    
    BOOL txtlength = NO;
    if ([textField.text length] <= 10) {
        txtlength = YES;
    }
    return txtlength;
    return YES;
}


- (BOOL)textViewShouldEndEditing:(UITextView *)textView{
    
//    NSLog(@"textView is %@",textView.text);
    return YES;
}

- (void)userPersonalSubmitInfoOperation{
 
    
    if (IsStringEmptyOrNull(self.clubDepartmentNameField.text)) {
        ShowImportErrorAlertControl(@"部门名不能为空！",self);
        return;
    }
    
    if (IsStringEmptyOrNull(self.clubDepartmentIntroduceTextView.text)) {
        ShowImportErrorAlertControl(@"部门介绍不能为空！",self);
        return;
    }
    
    if([self.clubDepartmentIntroduceTextView.text length] < 10){
        ShowImportErrorAlertControl(@"部门介绍不能少于10个字！",self);
        return;
    }
    
    NSDictionary *departmentInfo = @{@"departmentName":self.clubDepartmentNameField.text,
                                     @"departmentContent":@"绿野俱乐部 APP，添加机构部门操作"
                                     };
    
    WaittingMBProgressHUD(self.view, @"提交中...");
    __weak __typeof(&*self)weakSelf = self;
    [KShareHTTPLvyeHTTPClient clubbAccountAddDepartmentInfoWithClubId:KLvyeClubCurrentUser.clubId department:departmentInfo completion:^(WebAPIResponse *response) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            
            NSLog(@"response.responseObject is  %@",response.responseObject);
            if (response.code == WebAPIResponseCodeSuccess) {
                FinishMBProgressHUD(self.view);
                [weakSelf responseSuccessful];
            }else if (response.code == WebAPIResponseCodeFailed){
                FailedMBProgressHUD(self.view, StringForKeyInUnserializedJSONDic(response.responseObject, @"message"));
            }else if (response.code == WebAPIResponseCodeNetError){
                FailedMBProgressHUD(self.view, @"网络错误，请稍后重试！");
            }else{
                 FailedMBProgressHUD(self.view, @"网络错误，请稍后重试！");
            }
        });
    }];
}

- (void)responseSuccessful{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(userAddClubAddDepartmentOperationSuccessful)]) {
            [self.delegate userAddClubAddDepartmentOperationSuccessful];
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
