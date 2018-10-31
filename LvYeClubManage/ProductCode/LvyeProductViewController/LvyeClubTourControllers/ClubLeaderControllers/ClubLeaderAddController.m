//
//  ClubLeaderAddController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/15.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubLeaderAddController.h"

@interface ClubLeaderAddController ()

/*!
 * @property
 * @brief 操作控制样式
 */
@property (nonatomic ,  assign)      LeaderOperationStyle           operationStyle;
@end

@implementation ClubLeaderAddController
#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
    }
    return self;
}
- (instancetype)initWithUserOperaionStyle:(LeaderOperationStyle)style leader:(ClubLeaderInfo *)leader{
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

@end
