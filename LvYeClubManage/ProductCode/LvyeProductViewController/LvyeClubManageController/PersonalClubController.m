//
//  PersonalClubController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/13.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "PersonalClubController.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+CLubInfo.h"
#import "ClubInfo.h"

#define KImageLogoImageViewHeight               KLVYEUIControlSizeWidth(80.0f)
#define KImageBGImageViewHeight               KLVYEUIControlSizeWidth(200.0f)

#define KBtnBackGroudViewHeight                 (KBtnForBtnCellNormalHeight*2.8)

@interface PersonalClubController ()


/*!
 * @property
 * @brief 俱乐部信息
 */
@property (nonatomic , strong)      ClubInfo            *clubInfor;
@end

@implementation PersonalClubController


#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
        self.clubInfor = [[ClubInfo alloc]init];
        
        
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
    
    __weak __typeof(&*self)weakSelf = self;
    [KShareHTTPLvyeHTTPClient clubBasicInfoWithClubId:KLvyeClubCurrentUser.clubId completion:^(WebAPIResponse *response) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (response.code == WebAPIResponseCodeSuccess) {
                NSLog(@"responseObject is \n %@",response.responseObject);
                
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dataDic = (NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) ;
                    [weakSelf.clubInfor initClubInfoWithUnserializedJSONDic:dataDic];
                    [weakSelf updataViewContainerContent];
                }
            }
        });
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updataViewContainerContent{
    
    

    

    UIImageView *clubBgImageView = [[UIImageView alloc]init];
    [clubBgImageView setBackgroundColor:[UIColor whiteColor]];
    [clubBgImageView setFrame:CGRectMake(0.0f, 20.0f + KImageLogoImageViewHeight/2,
                                       KProjectScreenWidth, KImageBGImageViewHeight)];
    [clubBgImageView.layer setMasksToBounds:YES];
    NSString *clubBGImageURL = [NSString stringWithFormat:@"%@%@",KEY_RESPONSE_LVYE_IMAGE_URL,self.clubInfor.clubBgImageURL];
    [clubBgImageView setImageWithURL:[NSURL URLWithString:clubBGImageURL] placeholderImage:createImageWithColor(KButtonStateHighlightedColor)];
    [self.bgScrollView addSubview:clubBgImageView];
    
    ///logo Photo
    UIImageView *logoImageView = [[UIImageView alloc]init];
    [logoImageView setBackgroundColor:[UIColor whiteColor]];
    [logoImageView setFrame:CGRectMake((KProjectScreenWidth - KImageLogoImageViewHeight)/2, 20.0f,
                                       KImageLogoImageViewHeight, KImageLogoImageViewHeight)];
    [logoImageView.layer setCornerRadius:KImageLogoImageViewHeight/2];
    [logoImageView.layer setMasksToBounds:YES];
    [logoImageView.layer setBorderWidth:2.0f];
    [logoImageView.layer setBorderColor:KContentGreyTextColor.CGColor];
    NSString *loginImageURL = [NSString stringWithFormat:@"%@%@",KEY_RESPONSE_LVYE_IMAGE_URL,self.clubInfor.clubLogoImageURL];
    [logoImageView setImageWithURL:[NSURL URLWithString:loginImageURL] placeholderImage:createImageWithColor(KButtonStateHighlightedColor)];
    
     [logoImageView setImageWithURL:[NSURL URLWithString:loginImageURL] placeholderImage:createImageWithColor(KButtonStateHighlightedColor)];
    [self.bgScrollView addSubview:logoImageView];
    
    
    UIView *contentBGView = [[UIView alloc]init];
    [contentBGView setBackgroundColor:[UIColor whiteColor]];
    [contentBGView setFrame:CGRectMake(0.0f, clubBgImageView.bottom + KBtnBackGroundTop, KProjectScreenWidth, KBtnBackGroudViewHeight)];
    [self.bgScrollView addSubview:contentBGView];
    
    
    
    UILabel *nameLabel = [[UILabel alloc]init];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setFrame:CGRectMake(KBtnContentLeftWidth,0.0f,(KProjectScreenWidth - KBtnContentLeftWidth),KBtnForBtnCellNormalHeight*1.2)];
    [nameLabel setText:self.clubInfor.clubName];
    [nameLabel setTextAlignment:NSTextAlignmentLeft];
    [nameLabel setFont:[UIFont boldSystemFontOfSize:22.0f]];
    [nameLabel setTextColor:KContentTextColor];
    [contentBGView addSubview:nameLabel];
    

   
    
    
    CGFloat bottomFloat = nameLabel.bottom;
    if(!IsStringEmptyOrNull(self.clubInfor.clubAddress)){
        UILabel *addressLabel = [[UILabel alloc]init];
        [addressLabel setBackgroundColor:[UIColor clearColor]];
        [addressLabel setFrame:CGRectMake(KBtnContentLeftWidth,nameLabel.bottom,(KProjectScreenWidth - KBtnContentLeftWidth),KBtnForBtnCellNormalHeight*0.8)];
        [addressLabel setText:self.clubInfor.clubAddress];
        [addressLabel setTextAlignment:NSTextAlignmentLeft];
        
        ///设置宽高限制。
        CGSize boundingSize = CGSizeMake((KProjectScreenWidth - KBtnContentLeftWidth*2), MAXFLOAT);
        ///设置属性
        NSDictionary *attDic =@{NSFontAttributeName: KDefaultOperationButtonTitleFontOfSize};
        CGRect contentRect =  [self.clubInfor.clubAddress boundingRectWithSize:boundingSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
        NSLog(@"height is %.2lf,width is %.2lf",contentRect.size.height,contentRect.size.width);
        [addressLabel setFont:KDefaultOperationButtonTitleFontOfSize];
        [addressLabel setNumberOfLines:0];
        [addressLabel setLineBreakMode:NSLineBreakByTruncatingHead];
        [addressLabel setHeight:contentRect.size.height];
        [addressLabel setTextColor:KContentTextColor];
        [contentBGView addSubview:addressLabel];
        
        UIDottedView *viewDotted = [[UIDottedView alloc]init];
        [viewDotted setFrame:CGRectMake(KBtnContentLeftWidth, addressLabel.bottom+KBtnContentLeftWidth,
                                        (KProjectScreenWidth -2*KBtnContentLeftWidth) ,
                                        1.0f)];
        [viewDotted setBackgroundColor:[UIColor clearColor]];
        [contentBGView addSubview:viewDotted];
        
        bottomFloat =addressLabel.bottom;
    }
    
    
    UILabel *dateTimeLabel = [[UILabel alloc]init];
    [dateTimeLabel setBackgroundColor:[UIColor clearColor]];
    [dateTimeLabel setFrame:CGRectMake(KBtnContentLeftWidth,bottomFloat+KBtnContentLeftWidth,(KProjectScreenWidth - KBtnContentLeftWidth),KBtnForBtnCellNormalHeight*0.8)];
    NSString *clubRegisterDate = @"";
    if (!IsStringEmptyOrNull(self.clubInfor.clubRegisterDate)) {
        clubRegisterDate = [NSString stringWithFormat:@"%@  %@",self.clubInfor.clubRegisterDate,@"入驻"];
    }
    [dateTimeLabel setText:clubRegisterDate];
    [dateTimeLabel setTextAlignment:NSTextAlignmentLeft];
    [dateTimeLabel setFont:KContentLeftTitleFontOfSize];
    [dateTimeLabel setTextColor:KContentTextColor];
    [contentBGView addSubview:dateTimeLabel];
    
    
    if(!IsStringEmptyOrNull(self.clubInfor.clubSalonContent)){
        
        
        UILabel *sloganLabel = [[UILabel alloc]init];
        [sloganLabel setBackgroundColor:[UIColor clearColor]];
        [sloganLabel setFrame:CGRectMake(KBtnContentLeftWidth,dateTimeLabel.bottom,50.0f,25.0f)];
        [sloganLabel setText:@"标语:"];
        [sloganLabel setFont:KLVYEUIContentFontSize(20.0f)];
        [sloganLabel setTextAlignment:NSTextAlignmentLeft];
        [contentBGView addSubview:sloganLabel];
        
        UILabel *addressLabel = [[UILabel alloc]init];
        [addressLabel setBackgroundColor:[UIColor clearColor]];
        [addressLabel setFrame:CGRectMake(KBtnContentLeftWidth,(sloganLabel.bottom-sloganLabel.height/2-8.0f),(KProjectScreenWidth - KBtnContentLeftWidth),KBtnForBtnCellNormalHeight*0.8)];
        [addressLabel setText:[NSString stringWithFormat:@"\t\t%@",self.clubInfor.clubSalonContent]];
        [addressLabel setTextAlignment:NSTextAlignmentLeft];
        ///设置宽高限制。
        CGSize boundingSize = CGSizeMake((KProjectScreenWidth - KBtnContentLeftWidth*2), MAXFLOAT);
        ///设置属性
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:KInforLeftIntervalWidth/3];
        NSDictionary *attDic =@{NSFontAttributeName: KDefaultOperationButtonTitleFontOfSize,
                                NSParagraphStyleAttributeName:paragraphStyle,};
        CGRect contentRect =  [[NSString stringWithFormat:@"\t\t%@",self.clubInfor.clubSalonContent] boundingRectWithSize:boundingSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
        [addressLabel setFont:KDefaultOperationButtonTitleFontOfSize];
        [addressLabel setNumberOfLines:0];
        [addressLabel setLineBreakMode:NSLineBreakByTruncatingHead];
        [addressLabel setHeight:contentRect.size.height];
        [addressLabel setTextColor:KContentTextColor];
        [contentBGView addSubview:addressLabel];
        
//        UIDottedView *viewDotted = [[UIDottedView alloc]init];
//        [viewDotted setFrame:CGRectMake(KBtnContentLeftWidth, addressLabel.bottom+KBtnContentLeftWidth,
//                                        (KProjectScreenWidth -2*KBtnContentLeftWidth) ,
//                                        1.0f)];
//        [viewDotted setBackgroundColor:[UIColor clearColor]];
//        [contentBGView addSubview:viewDotted];
//
        bottomFloat =addressLabel.bottom;
    }
    
    [contentBGView setHeight:bottomFloat+KBtnContentLeftWidth];

    
    ///13英吋  Retina 显示屏的MacBook Pro 2.9GHz 双核?Intel?Core i5 处理器 Turbo Boost 高达 3.3GHz 8GB? 1866MHz LPDDR3 内存
    
    
    
}

@end
