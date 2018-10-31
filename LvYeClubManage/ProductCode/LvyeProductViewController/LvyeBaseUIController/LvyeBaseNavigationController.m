//
//  LvyeBaseNavigationViewController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/17.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

//#define  KDefaultNavigationWhiteBackGroundColor  [UIColor whiteColor]


////导航栏背景色
//#define  KDefaultNavigationWhiteBackGroundColor     KButtonStateNormalColor
//#define  KDefaultNavigationWhiteTitleColor          [UIColor whiteColor]

#define  KDefaultNavigationWhiteBackGroundColor     [UIColor whiteColor]
#define  KDefaultNavigationWhiteTitleColor          KButtonStateNormalColor

#import "LvyeBaseNavigationController.h"

@interface LvyeBaseNavigationController ()

@end

@implementation LvyeBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    //去掉底部阴影条
    if ([UINavigationBar instancesRespondToSelector:@selector(setShadowImage:)]) {// > iOS 6.0
        [self.navigationBar setShadowImage:[UIImage imageNamed:@"TabItem_SelectionIndicatorImage"]];
    }
    //设置背景
    UIImage* img = createImageWithColor(KDefaultNavigationWhiteBackGroundColor);
    if(img){
        [self.navigationBar setBackgroundImage:img
                                forBarPosition:UIBarPositionTopAttached
                                    barMetrics:UIBarMetricsDefault];
    }else{
        UIColor* color = KDefaultNavigationWhiteBackGroundColor;
        if (color) {
            self.navigationBar.barTintColor = color;
        }
    }
    [self.navigationBar setTintColor:KDefaultNavigationWhiteBackGroundColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
    ///设置导航栏标题为同意的白色
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:KDefaultNavigationWhiteTitleColor,
                                               NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                               };
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

@end
