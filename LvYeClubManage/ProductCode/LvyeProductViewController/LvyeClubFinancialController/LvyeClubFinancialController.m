//
//  LvyeClubFinancialController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/23.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeClubFinancialController.h"
#import "LvYeHTTPClient+ClubManage.h"
@interface LvyeClubFinancialController ()

@end

@implementation LvyeClubFinancialController


#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = TRUE ;
        self.clubModuleId = [[NSString alloc]initWithFormat:@"%@", @"5"];
        self.clubModuleName = [[NSString alloc]initWithFormat:@"%@",@"财务管理"];
        self.clubModuleImage = FMIconFontF1EC;
    }
    return self;
}

- (instancetype)initWithEnableDisplayOnTabBar{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE ;
        self.clubModuleId = [[NSString alloc]initWithFormat:@"%@", @"5"];
        self.clubModuleName = [[NSString alloc]initWithFormat:@"%@",@"财务管理"];
        self.clubModuleImage = FMIconFontF1EC;
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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)viewWillAppear:(BOOL)animated{
    
    
    __weak __typeof(&*self)weakSelf = self;
    __block CGFloat  bottomFloat = 10.0f;
    [KShareHTTPLvyeHTTPClient userClubOperationFunctionWithClubId:KLvyeProductClubSettings.clubLoginUserAtClubId userId:KLvyeProductClubSettings.clubloginUserPerId moduleId:self.clubModuleId completion:^(WebAPIResponse *response) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if (response.code == WebAPIResponseCodeSuccess) {
                if([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSArray class]]){
                    NSArray *dataArray =(NSArray *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    for (NSDictionary *moduleDic in dataArray) {
                        
                        NSString *moduleClassName = StringForKeyInUnserializedJSONDic(moduleDic, @"iosClassName");
                        NSString *moduleName = StringForKeyInUnserializedJSONDic(moduleDic, @"os_function_name");
                        
                        FMIconFont iconImage = FMIconNULL;
                        if(!IsStringEmptyOrNull(StringForKeyInUnserializedJSONDic(moduleDic, @"iconImage"))){
                            NSString *iconImageStr = StringForKeyInUnserializedJSONDic(moduleDic, @"iconImage");
                            iconImage = (FMIconFont)[iconImageStr integerValue];
                        }
                        
                        UIButtonCell *button = [UIButtonCell buttonCellWithType:UIButtonTypeCustom icon:iconImage];
                        [button setBtnControTitleName:moduleName];
                        [button setBtnClassName:moduleClassName];
                        [button setFrame:CGRectMake(0.0f, bottomFloat, KProjectScreenWidth, KBtnForRegisterOrLoginButtonHeight)];
                        [button setTitle:[NSString stringWithFormat:@"%@%@",@"",moduleName]
                                forState:UIControlStateNormal];
                        [button addTarget:self action:@selector(moduleButtonCellEventOperation:)
                         forControlEvents:UIControlEventTouchUpInside];
                        [weakSelf.bgScrollView addSubview:button];
                        bottomFloat = button.bottom+10.0f;
                    }
                }
            }
        });
    }];
    
    [super viewWillAppear:animated];
}

- (void)moduleButtonCellEventOperation:(UIButtonCell *)btn{
    if (!IsStringEmptyOrNull(btn.btnClassName)) {
        NSString *moduleClassName = btn.btnClassName;
        NSString *moduleNameStr = btn.btnControTitleName;
        Class moduleController = NSClassFromString(moduleClassName);
        LvyeBaseViewController *baseController = (LvyeBaseViewController*)[[moduleController alloc]init];
        [baseController setTitle:moduleNameStr];
        [baseController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:baseController animated:YES];
    }
}

@end
