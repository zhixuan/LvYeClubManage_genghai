//
//  ClubOrderAuditViewController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/3/13.
//  Copyright © 2019年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubOrderAuditViewController.h"

@interface ClubOrderAuditViewController ()

/*!
 * @property
 * @brief 操作控制协议
 */
@property (nonatomic , assign)      id<AuditOperationDelegate> delegate;
/*!
 * @property
 * @brief 订单信息
 */
@property (nonatomic , strong)      ClubOrderInfo           *orderDetailInfo;

@end

@implementation ClubOrderAuditViewController

#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (instancetype)initWithClubOrderDetailInfo:(ClubOrderInfo *)orderDetail deletage:(id<AuditOperationDelegate>)dDelegate{
    self = [super init];
    if (self) {
        self.orderDetailInfo = orderDetail;
        self.delegate = dDelegate;
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


- (void)setupControllerFrame{
    
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
