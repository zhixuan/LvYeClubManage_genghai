//
//  LvyeClubOrderTableController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/9.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeClubOrderTableController.h"

@interface LvyeClubOrderTableController ()

@end

@implementation LvyeClubOrderTableController



#pragma mark -
#pragma mark -  系统方法
- (id)init{
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
- (id)initWithOrderStyle:(NSInteger)orderStyle{
    self = [super init];
    if (self) {
        
        
    }
    return self;
    
}

- (id)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        
        
    }
    return self;
    
}
- (void)viewDidLoad {
    
    NSLog(@"根据订单标题，查询订单类别信息，%@",self.title);
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
