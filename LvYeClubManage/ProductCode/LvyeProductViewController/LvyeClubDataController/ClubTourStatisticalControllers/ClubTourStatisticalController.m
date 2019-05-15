//
//  ClubTourStatisticalController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/20.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubTourStatisticalController.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+ClubTourStatistics.h"

@interface ClubTourStatisticalController ()


/*!
 * @property
 * @brief 显示统计结果的label
 */
@property (nonatomic , weak)      UILabel               *tourStatisticsReslutLabel;
@end

@implementation ClubTourStatisticalController

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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UILabel * reslutLabel = [[UILabel alloc]init];
    [reslutLabel setBackgroundColor:[UIColor clearColor]];
    [reslutLabel setNumberOfLines:10];
    [reslutLabel setTextAlignment:NSTextAlignmentLeft];
    [reslutLabel setContentMode:UIViewContentModeTop];
    [reslutLabel setLineBreakMode:NSLineBreakByClipping];
    [reslutLabel setTextColor:KContentTextColor];
    [reslutLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [reslutLabel setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth, (KProjectScreenWidth - KInforLeftIntervalWidth*2), 200.0f)];
    self.tourStatisticsReslutLabel = reslutLabel;
    [self.bgScrollView addSubview:self.tourStatisticsReslutLabel];
    
    
    
     CGSize textSize = [@"中国" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
     __weak __typeof(&*self)weakSelf = self;
    [KShareHTTPLvyeHTTPClient clubDataManageClubTourStatisticsInfoWithClubId:KLvyeClubCurrentUser.clubId completion:^(WebAPIResponse *response) {
 
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (response.code == WebAPIResponseCodeSuccess) {
                NSLog(@"%@",response.responseObject);
                
                
                NSMutableString *contentStr = [NSMutableString stringWithFormat:@"%@",@""];
                if([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSArray class]]){
                    
                    NSArray  *dataArray = (NSArray *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    
                    
                    CGFloat reslutHeightFloat =textSize.height *[dataArray count];
                    for (NSDictionary * item in dataArray) {
                        NSString *tourStateTypeName= StringForKeyInUnserializedJSONDic(item, @"tour_status");
                        NSString *toursCount= StringForKeyInUnserializedJSONDic(item, @"tour_count");
                        
                        tourStateTypeName = StringForKeyInUnserializedJSONDic(KLvyeProductClubSettings.clubTourInfoStyleContentDictionary, tourStateTypeName);
                         NSLog(@"%@ 的活动,有 %@ 条活动",tourStateTypeName,toursCount);
                        
                        [contentStr appendString:[NSString stringWithFormat:@"%@ 的活动,有 %@ 条活动 \n",tourStateTypeName,toursCount]];
                    }
                    
                    [weakSelf.tourStatisticsReslutLabel setText:contentStr];
                    [weakSelf.tourStatisticsReslutLabel setHeight:reslutHeightFloat+20.0f];
                }
            }
        });
    }];
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
