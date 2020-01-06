//
//  LvyeClubSettingController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/6.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeClubSettingController.h"
#import "LoginViewController.h"
#import "LvyeBaseNavigationController.h"
#import "LvyeBaseTabBarController.h"

#define KButtonForClearMemoryTag                (1510211)
#define KButtonForLogoutTag                     (1510212)

#define KAlertForLogoutTag                      (1419211)

@interface LvyeClubSettingController ()

@end

@implementation LvyeClubSettingController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.clubModuleName = @"设置";
        self.clubModuleImage = FMIconFontF141;
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
    
    [self setLeftNavButtonFA:FMIconFontF053 withFrame:CGRectMake(0.0f, 0.0f, 55.0f, 44.0f)
                actionTarget:self action:@selector(setLeftBarButtonEvent)];

    CGFloat  bottomFloat = 10.0f;
    UIButtonCell *button = [UIButtonCell buttonCellWithType:UIButtonTypeCustom icon:FMIconNULL];
    [button setFrame:CGRectMake(0.0f, bottomFloat, KProjectScreenWidth, KBtnForBtnCellNormalHeight)];
    [button setTitle:@"清空缓存"
            forState:UIControlStateNormal];
    [button setTag:KButtonForClearMemoryTag];
    [button addTarget:self action:@selector(moduleButtonCellEventOperation:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.bgScrollView addSubview:button];
    bottomFloat = button.bottom+10.0f;
    
    
    
    UIButtonCell *logoutButton = [UIButtonCell buttonWithType:UIButtonTypeCustom];
    [logoutButton setFrame:CGRectMake(KBtnForRegisterOrLoginButtonLeftInterval, bottomFloat+KBtnForBtnCellNormalHeight*5.0f, (KProjectScreenWidth - KBtnForRegisterOrLoginButtonLeftInterval*2), KBtnForBtnCellNormalHeight)];
    [logoutButton setTitle:@"退 出"
            forState:UIControlStateNormal];
    [logoutButton.layer setMasksToBounds:YES];
    [logoutButton setBackgroundImage:createImageWithColor([UIColor whiteColor]) forState:UIControlStateNormal];
    [logoutButton setBackgroundImage:createImageWithColor(KButtonStateHighlightedColor) forState:UIControlStateHighlighted];
    [logoutButton.layer setBorderColor:KSeparateColorSetup.CGColor];
    [logoutButton.layer setBorderWidth:1.0f];
    [logoutButton setTitleColor:KContentTextColor forState:UIControlStateNormal];
    [logoutButton setTag:KButtonForLogoutTag];
    [logoutButton addTarget:self action:@selector(moduleButtonCellEventOperation:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.bgScrollView addSubview:logoutButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setLeftBarButtonEvent{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)moduleButtonCellEventOperation:(UIButtonCell*)btnCell{
    UIButton *btn = (UIButton*)btnCell;
    if(btn.tag == KButtonForClearMemoryTag){
        ShowImportErrorAlertControl(@"清空缓存！", self);
    }else if (btn.tag == KButtonForLogoutTag){

//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"是否退出本账户？"
//                                                      delegate:self cancelButtonTitle:@"取消"
//                                             otherButtonTitles:@"确定", nil];
//        [alert setTag:KAlertForLogoutTag];
//        [alert show];
        
        UIAlertController *control = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否退出本账户？" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [KLvyeClubCurrentUser clubUserLogoutAndClearCurrentUserInfo];
            
            LoginViewController * viewController = [[LoginViewController alloc] init];
            [viewController settingNavTitle:@"登录" color:[UIColor redColor]];
            LvyeBaseNavigationController *navController = [[LvyeBaseNavigationController alloc]initWithRootViewController:viewController];
            [KShareAppDelegate.window setRootViewController:navController];
            
            viewController.block = ^(WebAPIResponseCode code) {
                LvyeBaseTabBarController *tabBarController = [[LvyeBaseTabBarController alloc]init];
                tabBarController.selectedIndex = 0;
                [KShareAppDelegate.window setRootViewController:tabBarController];
            };
            
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [control addAction:doneAction];
        [control addAction:cancelAction];
        [ self presentViewController:control animated:YES completion:^{
        }];
    }
}
/*
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSLog(@"buttonIndex is %ld",buttonIndex);
    
    if(buttonIndex == 1){
        [KLvyeClubCurrentUser clubUserLogoutAndClearCurrentUserInfo];
        
        
        LoginViewController * viewController = [[LoginViewController alloc] init];
        [viewController settingNavTitle:@"登录" color:[UIColor redColor]];
        LvyeBaseNavigationController *navController = [[LvyeBaseNavigationController alloc]initWithRootViewController:viewController];
        [KShareAppDelegate.window setRootViewController:navController];
        
        viewController.block = ^(WebAPIResponseCode code) {
            LvyeBaseTabBarController *tabBarController = [[LvyeBaseTabBarController alloc]init];
            tabBarController.selectedIndex = 0;
            [KShareAppDelegate.window setRootViewController:tabBarController];
        };
    }
}
 */

@end
