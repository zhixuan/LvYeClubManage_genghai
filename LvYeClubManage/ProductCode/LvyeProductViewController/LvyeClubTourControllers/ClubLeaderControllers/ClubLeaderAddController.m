//
//  ClubLeaderAddController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/15.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubLeaderAddController.h"
#import "ClubLeaderInfo.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+CLubInfo.h"

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
    
    
    ClubLeaderInfo *leaderInfo = [[ClubLeaderInfo alloc]init];
    [leaderInfo setUserName:@"雷国强——TEST"];
    [leaderInfo setClubId:KLvyeClubCurrentUser.clubId];
    [leaderInfo setUserMobile:@"15711478892"];
    [leaderInfo setUserQQCode:@"132201198902176414"];
    [leaderInfo setUserWeChatCode:@"132201198902176414"];
    [leaderInfo setLeaderLocationCityName:@"乌鲁木齐"];
    [leaderInfo setLeaderEvaluation:@"没啥自我评无用--"];
    [leaderInfo setLeaderImportantLinkMobile:@"220182199107261967"];
    [leaderInfo setUserGenderStyle:ClubUserGenderFemaleStyle];
    [leaderInfo setLeaderCardCode:@"622623199202200023"];
    [leaderInfo setLeaderState:0];
    [leaderInfo setLeaderEvaluation:@"领队的自我评价"];
    [leaderInfo setLeaderIntroduction:@"个人介绍"];
    [leaderInfo setUserPhotoImageURL:@"/upload/1165254078.jpg"];

    [leaderInfo setLeaderNationName:@"苗族"];
    [leaderInfo setLeaderPositionStation:@"C++ 高级工程师"];
    [leaderInfo setLeaderNativePlaceStr:@"北京海淀区c苏州街长远天地大厦"];
    [leaderInfo setLeaderStarStr:@"七星级高级领队"];
    [leaderInfo setLeaderEnglishCompetence:@"英语六级"];
    [leaderInfo setLeaderStandardChinese:@"普通话五级"];
    [leaderInfo setLeaderNativeDialect:@"维吾尔族方言，蒙古方言、朝鲜语"];
    [leaderInfo setLeaderOtherLanguageCompetence:@"法语四级"];


    [leaderInfo setLeaderSpecialtyContent:@"国内青少年户外教育最早的践行者，青少年户外探索教育师资培训计划发起人。12年户外活动经验，从事青少年户外教育工作近10年，设计并组织带领青少年户外项目400余次。"];
    [leaderInfo setLeaderWorkExperience:@"国内青少年户外教育最早的践行者，青少年户外探索教育师资培训计划发起人。12年户外活动经验，从事青少年户外教育工作近10年，设计并组织带领青少年户外项目400余次。"];
    
    
    
//    NSString *nullStr = nil;
//    [NSArray arrayWithObject:nullStr];
//    
//   
    

    [KShareHTTPLvyeHTTPClient clubInsertLeaderInfoWithClubId:KLvyeClubCurrentUser.clubId leader:leaderInfo completion:^(WebAPIResponse *response) {


        dispatch_async(dispatch_get_main_queue(), ^(void){

            NSLog(@"  response.responseObject is  %@",response.responseObject);

            NSLog(@"KDataKeyMsg is %@",StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg));
            
        });
    }];
//
//
//    [leaderInfo setUserId:@"394"];
//    [KShareHTTPLvyeHTTPClient clubUpdateLeaderInfoWithClubId:KLvyeClubCurrentUser.clubId leader:leaderInfo completion:^(WebAPIResponse *response) {
//
//
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//
//            NSLog(@"  response.responseObject is  %@",response.responseObject);
//
//            NSLog(@"KDataKeyMsg is %@",StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg));
//        });
//    }];
    
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
