//
//  ClubBankAddController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/10.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubBankAddController.h"
#import "BankInfo.h"
#import "BankDataSourceController.h"


#define KButtonTextColor                        KButtonStateNormalColor


#define KbtnBankInfoHeight                      (KLVYEUIControlSizeWidth(55.0f))
#define KBtnBackGroudViewHeight                 (KbtnBankInfoHeight*5+4.0f)

@interface ClubBankAddController ()<UserSelectedBankSourceDelegate>


/*!
 * @property
 * @brief 银行信息
 */
@property (nonatomic , strong)      BankInfo            *addBankInfo;

/*!
 * @property
 * @brief 银行名字
 */
@property (nonatomic ,  strong)      UILabel            *clubBankNameLabel;

@end

@implementation ClubBankAddController
#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}

- (instancetype)initWithDelegate:(id<ClubUserAddBandDelegate>)delegate{
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
    
    [self viewControlFrame];
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
    
    ///选择银行卡信息
    UIButtonCell *bankNameButton = [UIButtonCell buttonNormalWithType:UIButtonTypeCustom];
    [bankNameButton setTitle:@"银行" forState:UIControlStateNormal];
    [bankNameButton addTarget:self action:@selector(userOperationEventClicked:) forControlEvents:UIControlEventTouchUpInside];
    [bankNameButton setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KbtnBankInfoHeight)];
    [contentBGView addSubview:bankNameButton];
    
    UILabel *bankLabel = [[UILabel alloc]init];
    [bankLabel setBackgroundColor:[UIColor clearColor]];
    [bankLabel setFrame:CGRectMake((KProjectScreenWidth - 260.0f - KBtnContentLeftWidth/2), 0.0f, 240.0f, bankNameButton.height)];
    [bankLabel setText:@"请选择银行"];
    [bankLabel setTextAlignment:NSTextAlignmentRight];
    [bankLabel setFont:KContentLeftTitleFontOfSize];
    [bankLabel setTextColor:KContentGreyTextColor];
    self.clubBankNameLabel = bankLabel;
    [bankNameButton addSubview:self.clubBankNameLabel];
    
    UIView *bankNameBottomSeparate = [[UIView alloc]init];
    [bankNameBottomSeparate setBackgroundColor:KSeparateColorSetup];
    [bankNameBottomSeparate setFrame:CGRectMake(KBtnContentLeftWidth, bankNameButton.bottom,
                                             (KProjectScreenWidth - KBtnContentLeftWidth),
                                             1.0f)];
    [contentBGView addSubview:bankNameBottomSeparate];
    
    
    ///卡号
    UILabel * cardCodeLabel = [[UILabel alloc]init];
    [cardCodeLabel setBackgroundColor:[UIColor clearColor]];
    [cardCodeLabel setFrame:CGRectMake(KBtnContentLeftWidth, bankNameButton.bottom, 80.0f, KbtnBankInfoHeight)];
    [cardCodeLabel setText:@"卡号"];
    [cardCodeLabel setTextAlignment:NSTextAlignmentLeft];
    [cardCodeLabel setFont:KContentLeftTitleFontOfSize];
    [cardCodeLabel setTextColor:KContentTextColor];
    [contentBGView addSubview:cardCodeLabel];
    
    UIView *cardBottomSeparate = [[UIView alloc]init];
    [cardBottomSeparate setBackgroundColor:KSeparateColorSetup];
    [cardBottomSeparate setFrame:CGRectMake(KBtnContentLeftWidth, cardCodeLabel.bottom,
                                                (KProjectScreenWidth - KBtnContentLeftWidth),
                                                1.0f)];
    [contentBGView addSubview:cardBottomSeparate];
    
    /// 开户行
    UILabel * cardAddressLabel = [[UILabel alloc]init];
    [cardAddressLabel setBackgroundColor:[UIColor clearColor]];
    [cardAddressLabel setFrame:CGRectMake(KBtnContentLeftWidth, cardBottomSeparate.bottom, 80.0f, KbtnBankInfoHeight)];
    [cardAddressLabel setText:@"开户行"];
    [cardAddressLabel setTextAlignment:NSTextAlignmentLeft];
    [cardAddressLabel setFont:KContentLeftTitleFontOfSize];
    [cardAddressLabel setTextColor:KContentTextColor];
    [contentBGView addSubview:cardAddressLabel];
    
    UIView *addressBottomSeparate = [[UIView alloc]init];
    [addressBottomSeparate setBackgroundColor:KSeparateColorSetup];
    [addressBottomSeparate setFrame:CGRectMake(KBtnContentLeftWidth, cardAddressLabel.bottom,
                                            (KProjectScreenWidth - KBtnContentLeftWidth),
                                            1.0f)];
    [contentBGView addSubview:addressBottomSeparate];
    
    /// 开户行
    UILabel * userNameLabel = [[UILabel alloc]init];
    [userNameLabel setBackgroundColor:[UIColor clearColor]];
    [userNameLabel setFrame:CGRectMake(KBtnContentLeftWidth, addressBottomSeparate.bottom, 80.0f, KbtnBankInfoHeight)];
    [userNameLabel setText:@"开户人"];
    [userNameLabel setTextAlignment:NSTextAlignmentLeft];
    [userNameLabel setFont:KContentLeftTitleFontOfSize];
    [userNameLabel setTextColor:KContentTextColor];
    [contentBGView addSubview:userNameLabel];
    
    UIView *userBottomSeparate = [[UIView alloc]init];
    [userBottomSeparate setBackgroundColor:KSeparateColorSetup];
    [userBottomSeparate setFrame:CGRectMake(KBtnContentLeftWidth, userNameLabel.bottom,
                                               (KProjectScreenWidth - KBtnContentLeftWidth),
                                               1.0f)];
    [contentBGView addSubview:userBottomSeparate];
    
    UILabel * styleLabel = [[UILabel alloc]init];
    [styleLabel setBackgroundColor:[UIColor clearColor]];
    [styleLabel setFrame:CGRectMake(KBtnContentLeftWidth, userBottomSeparate.bottom, 80.0f, KbtnBankInfoHeight)];
    [styleLabel setText:@"账户类型"];
    [styleLabel setTextAlignment:NSTextAlignmentLeft];
    [styleLabel setFont:KContentLeftTitleFontOfSize];
    [styleLabel setTextColor:KContentTextColor];
    [contentBGView addSubview:styleLabel];
    
    
    UIButtonCell * publicButton = [UIButtonCell buttonWithType:UIButtonTypeCustom];
    [publicButton setBackgroundImage:createImageWithColor([UIColor clearColor]) forState:UIControlStateNormal];
    [publicButton setBackgroundImage:createImageWithColor([UIColor clearColor]) forState:UIControlStateHighlighted];
    [publicButton.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [publicButton setTitle:@"对公账户" forState:UIControlStateNormal];
    [publicButton setTitleColor:KButtonTextColor forState:UIControlStateNormal];
    [publicButton setTitleColor:KButtonTextHighlightedColor forState:UIControlStateHighlighted];
    [publicButton simpleButtonWithImageColor:KButtonTextColor withHighlightedColor:KButtonTextHighlightedColor];
    [publicButton addAwesomeIcon:FMIconFontF192 beforeTitle:YES];
    [publicButton setFrame:CGRectMake(styleLabel.right+10.0f, userBottomSeparate.bottom, 140.0f, KbtnBankInfoHeight)];
    [contentBGView addSubview:publicButton];

    
}

- (void)userOperationEventClicked:(UIButtonCell *)button{
    BankDataSourceController *viewController = [[BankDataSourceController alloc]initWithDelegate:self];
    [viewController setTitle:@"银行"];
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)userPersonalSelectedOperation:(BankInfo *)bank{
    
    
    if (bank) {
        self.addBankInfo = bank;
        [self.clubBankNameLabel setText:bank.bankSourceName];
    }
}

@end
