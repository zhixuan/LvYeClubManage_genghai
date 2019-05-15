//
//  ClubToursMoreChooseViewController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/4/2.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubToursMoreChooseViewController.h"

@interface ClubToursMoreChooseViewController ()


/*!
 * @property
 * @brief 线路编号
 */
@property (nonatomic , weak)      UITextField               *clubTourId;

/*!
 * @property
 * @brief 线路名字
 */
@property (nonatomic , weak)      UITextField               *clubTourName;

/*!
 * @property
 * @brief 线路提交时间-搜索开始
 */
@property (nonatomic , strong)      NSString                *clubTourAddBeginDate;


/*!
 * @property
 * @brief 线路提交时间 - 搜索结束时间
 */
@property (nonatomic , strong)      NSString                *clubTourAddEndDate;



/*!
 * @property
 * @brief 操作结果协议传递信息
 */
@property (nonatomic , assign)      id<ClubToursMoreChooseDelegate>     delegate;
@end

@implementation ClubToursMoreChooseViewController


#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
      
    }
    return self;
}

- (instancetype) initWithDelegate:(id<ClubToursMoreChooseDelegate>)aDelegate{
    
    
    self = [super init];
    if (self) {
        self.delegate = aDelegate;
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
    
    
    [self setupFrameControl];
    
    
    [self setRightNavButtonFA:FMIconFontF08D withFrame:kNavBarButtonRect actionTarget:self action:@selector(userPersonalDoneChooseOperation)];
    // Do any additional setup after loading the view.
}

- (void)setupFrameControl{
    
    
    
}


- (void)userPersonalDoneChooseOperation{
    
    
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(userPersonalChooseMoreOperation:)]) {
            [self.delegate userPersonalChooseMoreOperation:[NSDictionary dictionary]];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)userInfo{
    
    
}

@end
