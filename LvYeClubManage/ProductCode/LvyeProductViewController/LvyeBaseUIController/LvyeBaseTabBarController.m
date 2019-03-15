//
//  LvyeBaseTabBarController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/17.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseTabBarController.h"
#import "LvyeBaseNavigationController.h"
#import "LvyeClubManageController.h"
#import "LvyeClubDataController.h"
#import "LvyeClubFinancialController.h"
#import "LvyeClubOrderController.h"
#import "LvyeClubAccountController.h"
#import "LvyeClubMoreViewController.h"

///默认选中的蓝色颜色
//#define KLVYESelectedButtonHighlightedColor HUIRGBColor(32.0f, 170.0f, 238.0f, 1.0f)
#define KLVYESelectedButtonHighlightedColor KButtonStateNormalColor


#define kFontThinName                           @"STHeitiSC-Light"              //细字体
#define kTableBarFontSize                       [UIFont fontWithName:kFontThinName size:10.0]

#define KRedUnReadMsgImageWidth                 (KLVYEUIControlSizeWidth(10.0f))


//#define KTabBarBackGroundColor                  HUIRGBColor(255.0f, 255.0f, 255.0f, 1.0f)
#define KTabBarBackGroundColor                  HUIRGBColor(255.0f, 255.0f, 255.0f, 1.0f)
#define KTabBarItemTitleNormalColor             HUIRGBColor(117.0f, 119.0f, 128.0f, 1.0f)
#define KTabBarItemTitleSelectedColor           KLVYESelectedButtonHighlightedColor

@interface LvyeBaseTabBarController ()<UITabBarControllerDelegate>

@end

@implementation LvyeBaseTabBarController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //去掉当前选择button上的阴影
    if ([self.tabBar respondsToSelector:@selector(setSelectionIndicatorImage:)]) {
        self.tabBar.selectionIndicatorImage = createImageWithColor(KTabBarBackGroundColor);//设置选中时图片
    }
    
//    //去掉顶部阴影条
//    if ([UITabBar instancesRespondToSelector:@selector(setShadowImage:)]) {// > iOS 6.0
//        [self.tabBar setShadowImage: createImageWithColor(KTabBarBackGroundColor)];
//    }
    
    //设置背景
    UIImage* img = createImageWithColor(KTabBarBackGroundColor);
    if(img){
        [self.tabBar setBackgroundImage:img];
        
    }else{
        UIColor* color = KTabBarBackGroundColor;
        if (color) {
            self.tabBar.barTintColor = color;
        }
    }
    
    //title颜色
    [[UITabBarItem appearance] setTitleTextAttributes:
     @{ NSFontAttributeName: kTableBarFontSize,
        NSForegroundColorAttributeName: KTabBarItemTitleNormalColor}
                                             forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:
     @{ NSFontAttributeName: kTableBarFontSize,
        NSForegroundColorAttributeName: KTabBarItemTitleSelectedColor}
                                             forState:UIControlStateSelected];
    
    [self setupAPBaseTabBarController];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupAPBaseTabBarController{

    NSMutableArray *userPersonalArray = [[NSMutableArray alloc]init];
     /////将所有的模块全部加入进去
    if([KLvyeProductClubSettings.clubLoginUserModelInfoArray count] >0){
        for (NSDictionary *moduleDic in KLvyeProductClubSettings.clubLoginUserModelInfoArray) {
            
            if([userPersonalArray count] ==4){
                break;
            }
            if([moduleDic count] >3){
                NSString *moduleClassName = StringForKeyInUnserializedJSONDic(moduleDic, @"iosClassName");
                if(!IsStringEmptyOrNull(moduleClassName)){
                    NSString *moduleNameStr = StringForKeyInUnserializedJSONDic(moduleDic, @"module_name");
                    NSString *moduleIconImage = StringForKeyInUnserializedJSONDic(moduleDic, @"iconImage");
                    NSString *moduleIdStr = StringForKeyInUnserializedJSONDic(moduleDic, @"module_id");
                    
                    
                    /*
                    ///根据Controller 名字，动态加载信息
                    Class moduleController = NSClassFromString(moduleClassName);
                    LvyeBaseViewController *baseController = (LvyeBaseViewController*)[[moduleController alloc]initWithEnableDisplayOnTabBar];
                     
                     */
                    
                     LvyeClubManageController *baseController = [[LvyeClubManageController alloc]initWithEnableDisplayOnTabBar];

                    [baseController setTitle:moduleNameStr];
                    [baseController setClubModuleName:moduleNameStr];
                    [baseController setClubModuleId:moduleIdStr];
                    if(!IsStringEmptyOrNull(moduleIconImage)){
                        FMIconFont iconFont = (FMIconFont)[moduleIconImage integerValue];
                        [baseController setClubModuleImage:iconFont];
                    }
                    
                    LvyeBaseNavigationController *accountNavi = [[LvyeBaseNavigationController alloc]initWithRootViewController:baseController];
                    [accountNavi setTitle:moduleNameStr];
                    [userPersonalArray addObject:accountNavi];
                }
            }
        }
    }
     

    
//
//    if([KLvyeProductClubSettings.clubLoginUserModelInfoArray count] >0){
//        for (NSUInteger index = 0 ; index< 4; index++) {
//            NSDictionary *moduleDic = (NSDictionary *)[KLvyeProductClubSettings.clubLoginUserModelInfoArray  objectAtIndex:index];
//            if([moduleDic count] >3){
//                NSString *moduleClassName = StringForKeyInUnserializedJSONDic(moduleDic, @"iosClassName");
//                if(!IsStringEmptyOrNull(moduleClassName)){
//                    ///根据Controller 名字，动态加载信息
//                    Class moduleController = NSClassFromString(moduleClassName);
//                    LvyeBaseViewController *baseController = (LvyeBaseViewController*)[[moduleController alloc]init];
//
//                    NSString *moduleNameStr = StringForKeyInUnserializedJSONDic(moduleDic, @"module_name");
//                    [baseController setTitle:moduleNameStr];
//                    LvyeBaseNavigationController *accountNavi = [[LvyeBaseNavigationController alloc]initWithRootViewController:baseController];
//                    [accountNavi setTitle:moduleNameStr];
//                    [userPersonalArray addObject:accountNavi];
//                }
//            }
//        }
//    }
    
    
    
    
    
    ////设置一个更多操作
    LvyeClubMoreViewController *baseController = [[LvyeClubMoreViewController alloc]init];
    [baseController setTitle:baseController.clubModuleName];
    LvyeBaseNavigationController *accountNavi = [[LvyeBaseNavigationController alloc]initWithRootViewController:baseController];
    [accountNavi setTitle:baseController.clubModuleName];
    [userPersonalArray addObject:accountNavi];
    
    //设置tabbar，并默认选中首页
    self.viewControllers = [NSArray arrayWithArray:userPersonalArray];
    [self setTabRootControlItem];
}

#pragma mark -选项卡栏
- (void)setTabRootControlItem{

    
    
    /*
    
    ////方式一，直接初始化基类 Controller，根据 ControllerName 转成不同的 控制器 在不同的界面中操作
    NSUInteger viewConCount = self.viewControllers.count;
    for (NSUInteger index = 0; index<viewConCount; index++) {
        LvyeBaseNavigationController *navigationController = (LvyeBaseNavigationController *)[self.viewControllers objectAtIndex:index];
        LvyeBaseViewController *viewController = (LvyeBaseViewController*)navigationController.topViewController;
        navigationController.tabBarItem = [self addButtonWithNormalImage:[FontAwesome imageWithIcon:viewController.clubModuleImage iconColor:KTabBarItemTitleNormalColor iconSize:KTabBarItemBtnSize]
                                                 selectedImage:[FontAwesome imageWithIcon:viewController.clubModuleImage iconColor:KTabBarItemTitleSelectedColor iconSize:KTabBarItemBtnSize]
                                                         title:viewController.clubModuleName];
    }
     */
    
    ////方式二，直接初始化基类 Controller，根据 ControllerName 转成同一个 控制器 根据参数内容不同，转换成不同的界面UI 效果效果
    NSUInteger viewConCount = self.viewControllers.count;
    for (NSUInteger index = 0; index<viewConCount; index++) {
        LvyeBaseNavigationController *navigationController = (LvyeBaseNavigationController *)[self.viewControllers objectAtIndex:index];
        LvyeClubManageController *viewController = (LvyeClubManageController*)navigationController.topViewController;
        navigationController.tabBarItem = [self addButtonWithNormalImage:[FontAwesome imageWithIcon:viewController.clubModuleImage iconColor:KTabBarItemTitleNormalColor iconSize:KTabBarItemBtnSize]
                                                           selectedImage:[FontAwesome imageWithIcon:viewController.clubModuleImage iconColor:KTabBarItemTitleSelectedColor iconSize:KTabBarItemBtnSize]
                                                                   title:viewController.clubModuleName];
    }

}

- (UITabBarItem* )addButtonWithNormalImage:(UIImage *)normalImage
                             selectedImage:(UIImage*)selectedImage
                                     title:(NSString* )title
{
    UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:normalImage selectedImage:selectedImage];
     [tabBarItem setFinishedSelectedImage:selectedImage withFinishedUnselectedImage:normalImage];
    [tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    return tabBarItem;
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{

    
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
//    NSLog(@"zhende");
}
@end
