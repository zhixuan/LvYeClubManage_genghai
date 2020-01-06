//
//  ClubWithdrawController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/10.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubWithdrawController.h"
#import "ClubBankInfo.h"
#import "ClubBankManageController.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+ClubFinance.h"


#define KBtnBackGroudViewHeight                 (KBtnForBtnCellNormalHeight*2+1.0f)


@interface ClubWithdrawController ()<ClubSelectedBankDelegate,UITextFieldDelegate>

/*!
 * @property
 * @brief 提现金额
 */
@property (nonatomic , weak)      UITextField               *clubWithdrawMoneyField;

/*!
 * @property
 * @brief 选中的银行卡信息
 */
@property (nonatomic , strong)      ClubBankInfo            *clubBankInfo;

/*!
 * @property
 * @brief 展示银行卡的名字
 */
@property (nonatomic , weak)      UILabel                   *clubBankNameLabel;


/*!
 * @property
 * @brief 用户可以提现的资金金额
 */
@property (nonatomic , strong)      NSString                *clubCanMaxCapitalStr;
@end

@implementation ClubWithdrawController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.clubBankInfo = [[ClubBankInfo alloc]init];
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

    self.clubCanMaxCapitalStr = [[NSString alloc]initWithFormat:@"%@",@"0.00"];
    [self viewControlFrame];
    /////
    [self requestValidCanDepositFundsInfo];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewControlFrame{
    
    
    UIView *contentBGView = [[UIView alloc]init];
    [contentBGView setBackgroundColor:[UIColor whiteColor]];
    [contentBGView setFrame:CGRectMake(0.0f, KBtnBackGroundTop, KProjectScreenWidth, KBtnBackGroudViewHeight)];
    [self.bgScrollView addSubview:contentBGView];
    
    
    
    ///提现金额输入
    UILabel *photoLabel = [[UILabel alloc]init];
    [photoLabel setBackgroundColor:[UIColor clearColor]];
    [photoLabel setFrame:CGRectMake(KBtnContentLeftWidth, 0.0f, 120.0f, KBtnForBtnCellNormalHeight)];
    [photoLabel setText:@"金额(¥)"];
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
    
    UITextField *withdrawMoneyText = [[UITextField alloc]init];
    [withdrawMoneyText setFrame:CGRectMake((photoLabel.right + 20.0f),0.0f,
                                            (KProjectScreenWidth - (KBtnContentLeftWidth + (photoLabel.right + 20.0f)) - 15.0f),
                                            KBtnForBtnCellNormalHeight)];
    [withdrawMoneyText setTextColor:KContentTextColor];
    [withdrawMoneyText setBackgroundColor:[UIColor clearColor]];
    [withdrawMoneyText setTextAlignment:NSTextAlignmentRight];
    [withdrawMoneyText setPlaceholder:@"输入提现金额"];
    [withdrawMoneyText setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [withdrawMoneyText setKeyboardType:UIKeyboardTypeNumbersAndPunctuation];
    [withdrawMoneyText setReturnKeyType:UIReturnKeyNext];
    [withdrawMoneyText setFont:KLVYEUIContentFontSize(22.0f)];
    [withdrawMoneyText setClearButtonMode:UITextFieldViewModeWhileEditing];
    [withdrawMoneyText setDelegate:self];
    self.clubWithdrawMoneyField = withdrawMoneyText;
    [contentBGView addSubview:self.clubWithdrawMoneyField];
    
    
    ///选择银行卡信息
    UIButtonCell *nameButton = [UIButtonCell buttonNormalWithType:UIButtonTypeCustom];
    [nameButton setTitle:@"银行卡" forState:UIControlStateNormal];
    [nameButton addTarget:self action:@selector(selectBankEventClicked) forControlEvents:UIControlEventTouchUpInside];
    [nameButton setFrame:CGRectMake(0.0f, photoBottomSeparate.bottom, KProjectScreenWidth, KBtnForBtnCellNormalHeight)];
    [contentBGView addSubview:nameButton];
    
    UILabel *bankLabel = [[UILabel alloc]init];
    [bankLabel setBackgroundColor:[UIColor clearColor]];
    [bankLabel setFrame:CGRectMake((KProjectScreenWidth - 260.0f - KBtnContentLeftWidth/2), 0.0f, 240.0f, nameButton.height)];
    [bankLabel setText:@"请选择银行卡"];
    [bankLabel setTextAlignment:NSTextAlignmentRight];
    [bankLabel setFont:KContentLeftTitleFontOfSize];
    [bankLabel setTextColor:KContentGreyTextColor];
    self.clubBankNameLabel = bankLabel;
    [nameButton addSubview:self.clubBankNameLabel];
    
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setBackgroundColor:[UIColor clearColor] ];
    [submitBtn.layer setCornerRadius:2.0f];
    [submitBtn.layer setMasksToBounds:YES];
    [submitBtn setFrame:CGRectMake(10.0f,contentBGView.bottom + 20.0f,
                                  (KProjectScreenWidth -20.0f), KBtnCellHeight)];
    [submitBtn setTitle:@"提  现" forState:UIControlStateNormal];
    [submitBtn.titleLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:createImageWithColor(KButtonStateNormalColor)
                        forState:UIControlStateNormal];
    [submitBtn setBackgroundImage:createImageWithColor(KButtonTextHighlightedColor)
                        forState:UIControlStateHighlighted];
    [submitBtn addTarget:self action:@selector(userPersonalSubmitInfoOperation)
       forControlEvents:UIControlEventTouchUpInside];
    [self.bgScrollView addSubview:submitBtn];

}

-(void)selectBankEventClicked{
    ClubBankManageController *viewController = [[ClubBankManageController alloc]initWithDelegate:self];
    [viewController setTitle:@"银行卡"];
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)userPersonalSelectedBank:(ClubBankInfo *)bank{
    
    if (bank.clubBankAccounStyle == ClubBankPublicStyle) {
        self.clubBankInfo = bank;
        [self.clubBankNameLabel setText:bank.bankSourceName];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (1 == range.length) {//按下回格键
        return YES;
    }
    
    NSCharacterSet *cs= [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]componentsJoinedByString:@"\\"];
    BOOL txtlength = NO;
    if ([textField.text length] <= 8) {
        txtlength = YES;
    }
    BOOL canChange = [string isEqualToString:filtered] ? txtlength : NO;
    NSString *checkStr = [textField.text stringByReplacingCharactersInRange:range withString:string];
    canChange =  isValidateMoney(checkStr) ? canChange:NO;
    return canChange;
    
    return YES;
}


- (void)userPersonalSubmitInfoOperation{
    
    if(IsStringEmptyOrNull(self.clubWithdrawMoneyField.text)){
        ShowImportErrorAlertControl(@"提现金额不能为空!", self);
        return;
    }
    
    CGFloat monedFload = [self.clubWithdrawMoneyField.text floatValue];
    if (monedFload <=0.01) {
        ShowImportErrorAlertControl(@"请输入有效提现金额！", self);
        return;
    }
    
    
    CGFloat oldMonedFload = [self.clubCanMaxCapitalStr floatValue];
    if (monedFload > oldMonedFload) {
        ShowImportErrorAlertControl(@"本次输入金额大于可提现金额，请输入有效金额！", self);
        return;
    }
    
    
    if([self.clubBankNameLabel.text isEqualToString:@"请选择银行卡"]){
        ShowImportErrorAlertControl(@"请选择银行卡！", self);
        return;
    }
    
    NSLog(@"\n userID %@  \nclubId is %@  \n money is %@ \n bankID is %@",KLvyeClubCurrentUser.userId,KLvyeClubCurrentUser.clubId,self.clubWithdrawMoneyField.text,self.clubBankInfo.bankInfoId);
    
    __weak __typeof(&*self)weakSelf = self;

    [KShareHTTPLvyeHTTPClient clubUserWithdrawOperaWithClubId:KLvyeClubCurrentUser.clubId userId:KLvyeClubCurrentUser.userId amount:self.clubWithdrawMoneyField.text cardId:self.clubBankInfo.bankInfoId completion:^(WebAPIResponse *response) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            NSLog(@"response.responseObject is %@",response.responseObject);
            if (response.code == WebAPIResponseCodeSuccess) {
                
                [weakSelf requestValidCanDepositFundsInfo];
                ShowImportErrorAlertControl(@"本次提现请求已完成，请注意查看账户资金变动！", self);
            }else if (response.code == WebAPIResponseCodeFailed) {
                ShowImportErrorAlertControl(StringForKeyInUnserializedJSONDic(response.responseObject,KDataKeyMsg), self);

                
            }else{
                ShowImportErrorAlertControl(@"网络错误，请稍后重试！", self);
            }
        });
    }];
}


- (void)requestValidCanDepositFundsInfo{
    
    __weak __typeof(&*self)weakSelf = self;
    [KShareHTTPLvyeHTTPClient clubCanDepositFundsInfowWithClubId:KLvyeClubCurrentUser.clubId userId:KLvyeClubCurrentUser.userId completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            NSLog(@"response.responseObject is %@",response.responseObject);
            if (response.code == WebAPIResponseCodeSuccess) {
                NSString *moneyStr = StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                weakSelf.clubCanMaxCapitalStr = [NSString stringWithFormat:@"%@",moneyStr];
                [weakSelf.clubWithdrawMoneyField setText:@""];
                [weakSelf.clubWithdrawMoneyField setPlaceholder:moneyStr];
            }
        });
    }];
}
@end
