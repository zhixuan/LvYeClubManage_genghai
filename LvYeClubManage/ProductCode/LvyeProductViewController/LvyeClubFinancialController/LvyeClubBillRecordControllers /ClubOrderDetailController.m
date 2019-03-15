//
//  ClubOrderDetailController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/9/4.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubOrderDetailController.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+ClubOrder.h"
#import "ClubOrderAuditViewController.h"


@interface ClubOrderDetailController ()<AuditOperationDelegate>

@end

@implementation ClubOrderDetailController


#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {

    }
    return self;
}

- (instancetype)initWithOrderInfo:(ClubOrderInfo *)orderInfo{
    self = [super init];
    if (self) {
//        self.itemOrderInfo = [[ClubOrderInfo alloc]init];
        self.itemOrderInfo  =orderInfo;
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
    
    
    NSLog(@"orderNumber is %@  clubId is %@",self.itemOrderInfo.orderNumber,KLvyeClubCurrentUser.clubId);
    
    __weak __typeof(&*self)weakSelf = self;
    [KShareHTTPLvyeHTTPClient clubOrderForOrderManageItemOrderDetailInforWithClubId:KLvyeClubCurrentUser.clubId orderNumber:self.itemOrderInfo.orderNumber completion:^(WebAPIResponse *response) {
        if (response.code == WebAPIResponseCodeSuccess) {
            
            if([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]){
                NSDictionary *dataDictionary =(NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                weakSelf.itemOrderInfo = [ClubOrderInfo initWithOrderDetailInfoWithUnserializedJSONDic:dataDictionary];
                NSLog(@"dataDictionary is \n %@",dataDictionary);
                [weakSelf setupUserOperationButtonFrame];
                
                [weakSelf setupControllFrameView];
            }
            
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupControllFrameView{
    
    UIScrollView  *bgContentScrollView = [[UIScrollView alloc]init];
    [bgContentScrollView setBackgroundColor:[UIColor whiteColor]];
    [bgContentScrollView setShowsVerticalScrollIndicator:NO];
    [bgContentScrollView setFrame:CGRectMake(0.00f, 10.0f, (KProjectScreenWidth-KInforLeftIntervalWidth*0.0f), self.view.height)];
    [bgContentScrollView setContentSize:CGSizeMake(bgContentScrollView.width, bgContentScrollView.height+40.0f)];
    [bgContentScrollView.layer setMasksToBounds:YES];
    [bgContentScrollView.layer setCornerRadius:2.0f];
    [self.view addSubview:bgContentScrollView];
    
    
    UILabel * orderNumberLabel = [[UILabel alloc]init];
    [orderNumberLabel setBackgroundColor:[UIColor clearColor]];
    [orderNumberLabel setTextColor:KContentTextColor];
    [orderNumberLabel setTextAlignment:NSTextAlignmentLeft];
    [orderNumberLabel setText:self.itemOrderInfo.orderNumber];
    [orderNumberLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [orderNumberLabel setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f, (bgContentScrollView.width -KInforLeftIntervalWidth)/2, KBtnCellHeight)];
    [bgContentScrollView addSubview:orderNumberLabel];
    
    
    UILabel *orderPayStateLabel = [[UILabel alloc]init];
    [orderPayStateLabel setBackgroundColor:[UIColor clearColor]];
    [orderPayStateLabel setTextAlignment:NSTextAlignmentRight];
    [orderPayStateLabel setFont:[UIFont boldSystemFontOfSize:(14*KLVYEAdapterSizeWidth)]];
    [orderPayStateLabel setTextColor:[UIColor redColor]];
    [orderPayStateLabel setFrame:CGRectMake(bgContentScrollView.width/2, 0.0f, (bgContentScrollView.width/2 -KInforLeftIntervalWidth), KBtnCellHeight)];
    [bgContentScrollView addSubview:orderPayStateLabel];
    if(!IsStringEmptyOrNull(self.itemOrderInfo.orderPaymentStatus)){
        [orderPayStateLabel setText:[KLvyeProductClubSettings.clubOrderPaymentStyleContentArray objectAtIndex:[self.itemOrderInfo.orderPaymentStatus integerValue]] ];
    }
    
    
    NSLog(@"clubTourInfoStyleContentDictionary is %@ \n\n\n",KLvyeProductClubSettings.clubTourInfoStyleContentDictionary);
    
    NSLog(@" [self.itemOrderInfo.orderPaymentStatus integerValue] %@",[KLvyeProductClubSettings.clubOrderPaymentStyleContentArray objectAtIndex:[self.itemOrderInfo.orderPaymentStatus integerValue]]);
    
    
    UIView *cellSeparator = [[UIView alloc]init];
    [cellSeparator setBackgroundColor:KSeparateColorSetup];
    [cellSeparator setFrame:CGRectMake(0.0f, orderPayStateLabel.bottom, bgContentScrollView.width, 1.0f)];
    [bgContentScrollView addSubview:cellSeparator];
    
    
    UILabel *tourName = [[UILabel alloc]init];
    [tourName setBackgroundColor:[UIColor clearColor]];
    [tourName setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
    [tourName setTextColor:KContentTextColor];
    [tourName setNumberOfLines:3];
    [tourName setLineBreakMode:NSLineBreakByTruncatingMiddle];
    [tourName setText:[NSString stringWithFormat:@"%@ -- %@",self.itemOrderInfo.tourName,self.itemOrderInfo.tourBasicId] ];
    
    ///设置宽高限制。
    CGSize boundingSize = CGSizeMake((KProjectScreenWidth - KBtnContentLeftWidth*1.5), MAXFLOAT);
    ///设置属性
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:KInforLeftIntervalWidth/2.5];
    NSDictionary *attDic =@{NSFontAttributeName: [UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)],
                            NSParagraphStyleAttributeName:paragraphStyle,};
    CGRect contentRect =  [tourName.text boundingRectWithSize:boundingSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
    
    [tourName setFrame: CGRectMake(KBtnContentLeftWidth, cellSeparator.bottom + 3.0f, (KProjectScreenWidth - KBtnContentLeftWidth*1.5), contentRect.size.height)];
    [bgContentScrollView addSubview:tourName];
    
   
    
    
    
}

- (void)setupUserOperationButtonFrame{
    
    if([@"7" isEqual:self.itemOrderInfo.orderPaymentStatus] ){
        
        [self setRightNavButtonTitleStr:@"审核" withFrame:kNavBarButtonRect
                           actionTarget:self action:@selector(userOrderAuditOperaiton)];
    }
    
}

- (void)userOrderAuditOperaiton{
    ClubOrderAuditViewController  *viewController = [[ClubOrderAuditViewController alloc]initWithClubOrderDetailInfo:self.itemOrderInfo deletage:self];
    [viewController setTitle:@"审核"];
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}


- (void)userAuditOperationFinish{
    
    
}
@end
