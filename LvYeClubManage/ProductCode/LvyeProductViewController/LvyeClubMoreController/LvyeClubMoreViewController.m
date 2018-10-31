//
//  LvyeClubMoreViewController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/6.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeClubMoreViewController.h"
#import "LvyeClubSettingController.h"
#import "UIButton+Bootstrap.h"
#import "FontAwesome.h"
#import "UIFont+FontAwesome.h"

@interface LvyeClubMoreViewController ()

@end

@implementation LvyeClubMoreViewController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE ;
        self.clubModuleId = [[NSString alloc]initWithFormat:@"%ld", NSIntegerMax];
        self.clubModuleName = [[NSString alloc]initWithFormat:@"%@",@"更多"];
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
    
    [self setleftAndRightButtonFrame];
    
    [self setMoreFunctionFrame];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setleftAndRightButtonFrame{
    
    
    
    [self setRightNavButtonFA:FMIconFontF013 withFrame:CGRectMake(0.0f, 0.0f, 30.0f, 44.0f)
                 actionTarget:self action:@selector(setRightButtonEvent)];
}

- (void)setRightButtonEvent{
    
    LvyeClubSettingController *settingController = [[LvyeClubSettingController alloc]init];
    [settingController setTitle:@"设置"];
    [settingController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:settingController animated:YES];
}


- (void)setMoreFunctionFrame{
    
   
    ////将所有的模块全部加入进去
    NSMutableArray *userPersonalArray = [[NSMutableArray alloc]init];
    
    CGFloat  bottomFloat = 10.0f;
    if([KLvyeProductClubSettings.clubLoginUserModelInfoArray count] >0){
        for (NSDictionary *moduleDic in KLvyeProductClubSettings.clubLoginUserModelInfoArray ) {

            if([moduleDic count] >3){
                NSString *moduleClassName = StringForKeyInUnserializedJSONDic(moduleDic, @"iosClassName");
                if(!IsStringEmptyOrNull(moduleClassName)){
                    ///根据Controller 名字，动态加载信息
                    [userPersonalArray addObject:moduleClassName];
                    if([userPersonalArray count] >4){
                        NSString *moduleName = StringForKeyInUnserializedJSONDic(moduleDic, @"module_name");
                        NSString *moduleIconImage = StringForKeyInUnserializedJSONDic(moduleDic, @"iconImage");
                        
                        FMIconFont iconFont=FMIconFontF001;
                        if(!IsStringEmptyOrNull(moduleIconImage)){
                            iconFont = (FMIconFont)[moduleIconImage integerValue];
                        }
                        UIButtonCell *button = [UIButtonCell buttonCellWithType:UIButtonTypeCustom icon:iconFont];
                        [button setBtnControTitleName:moduleName];
                        [button setBtnClassName:moduleClassName]; [button setFrame:CGRectMake(0.0f, bottomFloat, KProjectScreenWidth, KBtnForRegisterOrLoginButtonHeight)];
                         [button setTitle:[NSString stringWithFormat:@"%@",moduleName]
                                 forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(moduleButtonCellEventOperation:)
                         forControlEvents:UIControlEventTouchUpInside];
                        [self.bgScrollView addSubview:button];
                        bottomFloat = button.bottom+10.0f;
                    }
                }
            }
        }
    }
}



- (void)moduleButtonCellEventOperation:(UIButtonCell *)btn{
    
    ///根据Controller 名字，动态加载信息
    Class moduleController = NSClassFromString(btn.btnClassName);
    LvyeBaseViewController *baseController = (LvyeBaseViewController*)[[moduleController alloc]init];
    [baseController setTitle:btn.btnControTitleName];
    [baseController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:baseController animated:YES];
}

@end
