//
//  ClubUpdateAdministratorController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/4/19.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubUpdateAdministratorController.h"

@implementation ClubUpdateAdministratorController


#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
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

- (instancetype)initWithUserInfo:(ClubUserInfo *)userInfo{
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setRightNavButtonTitleStr:@"保存" withFrame:kNavBarButtonRect
                       actionTarget:self action:@selector(userSaveEditInfoClicked)];
    [self setViewControlFrame];

    
}

- (void)setViewControlFrame{
    
}

- (void)userSaveEditInfoClicked{
    
    
}
@end
