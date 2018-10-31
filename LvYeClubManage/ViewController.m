//
//  ViewController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/8.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ViewController.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+CLubInfo.h"
//#import <CoreTelephony/CTCarrier.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    
    UILabel     *displayLabel = [[UILabel alloc]initWithFrame:CGRectMake(50.0f, 100.0f, 100.0f, 30.0f)];
    [displayLabel setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:displayLabel];

    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
