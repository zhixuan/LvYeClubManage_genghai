//
//  LvyeClubManageController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/23.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeClubManageController.h"
#import "LvYeHTTPClient+ClubManage.h"

@interface LvyeClubManageController ()

@end

@implementation LvyeClubManageController

#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = TRUE ;
        self.clubModuleId = [[NSString alloc]initWithFormat:@"%@", @"12"];
        self.clubModuleName = [[NSString alloc]initWithFormat:@"%@",@"club管理"];
        self.clubModuleImage = FMIconFontF013;
    }
    return self;
}

- (instancetype)initWithEnableDisplayOnTabBar{
    self = [super init];
    if (self) {
       self.enableCustomNavbarBackButton = FALSE ;
        self.clubModuleId = [[NSString alloc]initWithFormat:@"%@", @"12"];
        self.clubModuleName = [[NSString alloc]initWithFormat:@"%@",@"club管理"];
        self.clubModuleImage = FMIconFontF013;
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
    
    self.clubModuleImage = FMIconFontF085;
//    NSLog(@"self.clubModuleName is %@    self.clubModuleImage is %ld  (FMIconFontF1FE )",self.clubModuleName,FMIconFontF1FE);
//    NSLog(@"self.clubModuleName is %@    self.clubModuleImage is %ld  (FMIconFontF200 )",self.clubModuleName,FMIconFontF200);
//    NSLog(@"self.clubModuleName is %@    self.clubModuleImage is %ld  (FMIconFontF201 )",self.clubModuleName,FMIconFontF201);
//    NSLog(@"self.clubModuleName is %@    self.clubModuleImage is %ld  (FMIconFontF012 )",self.clubModuleName,FMIconFontF012);

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
    
    for (id itemView in self.bgScrollView.subviews) {
        if([itemView isKindOfClass: [UIButtonCell class]]){
            [(UIButtonCell*)itemView removeFromSuperview];
        }
    }
    
    
    WaittingMBProgressHUD(self.view, @"加载中...");
    __weak __typeof(&*self)weakSelf = self;
    __block CGFloat  bottomFloat = 10.0f;
    [KShareHTTPLvyeHTTPClient userClubOperationFunctionWithClubId:KLvyeProductClubSettings.clubLoginUserAtClubId userId:KLvyeProductClubSettings.clubloginUserPerId moduleId:self.clubModuleId completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (response.code == WebAPIResponseCodeSuccess) {
                FinishMBProgressHUD(self.view);
                NSLog(@"moduleDic is %@",response.responseObject);
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
            }else{
                FailedMBProgressHUD(self.view,@"加载失败，请稍后重试！");
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
         NSLog(@"moduleClassName is %@ \n moduleController is %@",moduleClassName,moduleController);
        LvyeBaseViewController *baseController = (LvyeBaseViewController*)[[moduleController alloc]init];
        [baseController setTitle:moduleNameStr];
        [baseController setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:baseController animated:YES];
    }
}




@end
