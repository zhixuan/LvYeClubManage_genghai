//
//  ClubLeaderDetailController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubLeaderDetailController.h"
#import "ClubLeaderAddController.h"

@interface ClubLeaderDetailController ()

/*!
 * @property
 * @brief 用户需要查看的领队信息
 */
@property (nonatomic ,  strong)      ClubLeaderInfo             *selectedLeaderInfo;

/*!
 * @property
 * @brief 请求到的当前领队的信息
 */
@property (nonatomic ,  strong)      ClubLeaderInfo             *requestLeaderInfo;
@end

@implementation ClubLeaderDetailController


#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithLeaderIdInfo:(ClubLeaderInfo *)leaderInfo{
    self = [super init];
    if (self) {
        self.selectedLeaderInfo = leaderInfo;
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
    
    [self setRightNavButtonTitleStr:@"编辑" withFrame:kNavBarButtonRect actionTarget:self action:@selector(userEditLeaderOperationButtonEvent)];
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

- (void)userEditLeaderOperationButtonEvent{
    
    ClubLeaderAddController *viewController = [[ClubLeaderAddController alloc]initWithUserOperaionStyle:LeaderOperationEditStyle leader: self.requestLeaderInfo];
    [viewController setTitle:@"编辑"];
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
