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
    
    
    UIImage *setImage = [FontAwesome imageWithIcon:FMIconFontF001 iconColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"graduallyImg.png"]] iconSize:120.0f imageSize:CGSizeMake(120.0f, 120.0f)];
    UIImageView * imageView = [[UIImageView alloc]init];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [imageView setImage:setImage];
    [imageView setFrame:CGRectMake(200.0f, 300, 60.0f, 60.0f)];
    [self.view addSubview:imageView];
    
    UIImage *setFlagImage = [FontAwesome imageWithIcon:FMIconFontF001 iconColor:[UIColor redColor] iconSize:80.0f imageSize:CGSizeMake(80.0f, 80.0f)];
    UIImageView * secondImageView = [[UIImageView alloc]init];
    [secondImageView setBackgroundColor:[UIColor clearColor]];
    [secondImageView setImage:setFlagImage];
    [secondImageView setFrame:CGRectMake(200.0f, imageView.bottom+60.0f, 40.0f, 40.0f)];
    [self.view addSubview:secondImageView];
    
    
    
    
 
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setleftAndRightButtonFrame{
    
    
    
    [self setRightNavButtonFA:FMIconFontF013 withFrame:CGRectMake(0.0f, 0.0f, 30.0f, 44.0f)
                 actionTarget:self action:@selector(setRightButtonEvent)];
    
    
    UIImage *setImage = [FontAwesome imageWithIcon:FMIconFontF001 iconColor:[UIImage colorWithGradientColorImageWithDirection:GradientColorVerticalStyle size:CGSizeMake(1.0f, 40.0f) startColor:[UIColor yellowColor] endColor:[UIColor redColor] ] iconSize:40.0f imageSize:CGSizeMake(40.0f, 40.0f)];
    UIImageView * imageView = [[UIImageView alloc]init];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [imageView setImage:setImage];
    [imageView setFrame:CGRectMake(100.0f, 300, 20.0f, 20.0f)];
    [self.view addSubview:imageView];
    
    UIImage *setFlagImage = [FontAwesome imageWithIcon:FMIconFontF001 iconColor:[UIColor redColor] iconSize:80.0f imageSize:CGSizeMake(80.0f, 80.0f)];
    UIImageView * secondImageView = [[UIImageView alloc]init];
    [secondImageView setBackgroundColor:[UIColor clearColor]];
    [secondImageView setImage:setFlagImage];
    [secondImageView setFrame:CGRectMake(100.0f, imageView.bottom+60.0f, 40.0f, 40.0f)];
    [self.view addSubview:secondImageView];
    
    
    
    
     UIImage *setImage3 = [FontAwesome imageWithIcon:FMIconFontF1D7 iconColor:[UIImage colorWithGradientColorImageWithDirection:GradientColorDownwardDiagonalStyle size:CGSizeMake(1.0f, 80.0f) startColor:[UIColor yellowColor] endColor:[UIColor redColor] ] iconSize:60.0f imageSize:CGSizeMake(80.0f, 80.0f)];
     UIImageView * imageView3 = [[UIImageView alloc]init];
     [imageView3 setBackgroundColor:[UIColor clearColor]];
     [imageView3 setImage:setImage3];
     [imageView3 setFrame:CGRectMake(140.0f, 360, 40.0f, 40.0f)];
     [self.view addSubview:imageView3];
    
    UIImage *setImage4 = [FontAwesome imageWithIcon:FMIconFontF1D7 iconColor:HUIRGBColor(85, 183,55, 1.0f) iconSize:60.0f imageSize:CGSizeMake(80.0f, 80.0f)];
        UIImageView * imageView4 = [[UIImageView alloc]init];
        [imageView4 setBackgroundColor:[UIColor clearColor]];
        [imageView4 setImage:setImage4];
        [imageView4 setFrame:CGRectMake(140.0f, 420, 40.0f, 40.0f)];
        [self.view addSubview:imageView4];
     
     UIImage *setFlagImage1 = [FontAwesome imageWithIcon:FMIconFontF0FA iconColor:[UIColor redColor] iconSize:80.0f imageSize:CGSizeMake(80.0f, 80.0f)];
     UIImageView * secondImageView2 = [[UIImageView alloc]init];
     [secondImageView2 setBackgroundColor:[UIColor clearColor]];
     [secondImageView2 setImage:setFlagImage1];
     [secondImageView2 setFrame:CGRectMake(100.0f, secondImageView.bottom+60.0f, 40.0f, 40.0f)];
     [self.view addSubview:secondImageView2];
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
