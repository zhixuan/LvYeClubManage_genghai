//
//  TourCommentDetailController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/5/10.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "TourCommentDetailController.h"

@interface TourCommentDetailController ()
/*!
 * @property
 * @brief 线路评论信息内容
 */
@property (nonatomic , strong)      NSDictionary            *clubTourCommentInfo;
@end

@implementation TourCommentDetailController



- (instancetype)initWithTourCommentInfo:(NSDictionary *)info{
    self = [super init];
    if (self) {
        self.clubTourCommentInfo = [[NSDictionary alloc]initWithDictionary:info];
    }
    return self;
}

#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
        self.clubTourCommentInfo = [[NSDictionary alloc]init];
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

    [self setTitle:@"详情信息"];
    
    NSLog(@" 星级 is %@",StringForKeyInUnserializedJSONDic(self.clubTourCommentInfo, @"scale"));
    
    
    
    CGFloat leftFloat  = KBtnContentLeftWidth ;
    for (int index = 1; index<6; index++) {
        
        UIColor *color =[UIColor redColor];
        if (index>3) {
            color = [UIColor yellowColor];
        }
        UIImage *rightImage = [FontAwesome imageWithIcon:FMIconFontF005 iconColor:color iconSize:25.0f imageSize:CGSizeMake(25.0f, 25.0f)];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setFrame:CGRectMake(leftFloat+index*(25+10), 130.0f, 25.0f, 25.0f)];
        [imageView setBackgroundColor:[UIColor clearColor]];
        [imageView setImage:rightImage];
        [self.view addSubview:imageView];
    }
    
    leftFloat  = KBtnContentLeftWidth ;
    for (int index = 1; index<6; index++) {
        
        
        FMIconFont defalut = FMIconFontF005;
        
        if (index>3) {
            defalut =FMIconFontF006;
        }
        
//        #f77911
//        UIImage *rightImage = [FontAwesome imageWithIcon:defalut iconColor:[UIColor yellowColor] iconSize:25.0f imageSize:CGSizeMake(25.0f, 25.0f)];
        
        
        
//         UIImage *rightImage = [FontAwesome imageWithIcon:defalut iconColor:HUIRGBHexColor(0xF77911,1.0) iconSize:25.0f imageSize:CGSizeMake(25.0f, 25.0f)];
         UIImage *rightImage = [FontAwesome imageWithIcon:defalut iconColor:HUIRGBColor(229.0f,83.0f,21.0f,1.0f) iconSize:25.0f imageSize:CGSizeMake(25.0f, 25.0f)];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setFrame:CGRectMake(leftFloat+index*(25+10), 170.0f, 25.0f, 25.0f)];
        [imageView setBackgroundColor:[UIColor clearColor]];
        [imageView setImage:rightImage];
        [self.view addSubview:imageView];
    }
    
    
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
