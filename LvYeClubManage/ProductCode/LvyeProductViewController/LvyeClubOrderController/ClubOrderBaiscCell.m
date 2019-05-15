//
//  ClubOrderBaiscCell.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/3/11.
//  Copyright © 2019年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubOrderBaiscCell.h"

/*
 
 [itemOrder.orderLinkUserInfo  setUserName:StringForKeyInUnserializedJSONDic(dic, @"user_name")];
 [itemOrder.orderLinkUserInfo setUserMobile:StringForKeyInUnserializedJSONDic(dic, @"user_mobile")];
 **/

@interface ClubOrderBaiscCell ()



/*!
 * @property
 * @brief 订单状态
 */
@property (nonatomic , weak)      UILabel           *orderStatusLable;

/*!
 * @property
 * @brief 界面数据内容背景视图
 */
@property (nonatomic ,  weak)      UIView           *contentBackGroudView;

/*!
 * @property
 * @brief 出发时间
 */
@property (nonatomic , weak)      UILabel           *orderOutDateLabel;

/*!
 * @property
 * @brief 出游天数
 */
@property (nonatomic , weak)      UILabel           *orderOutDaysLabel;

/*!
 * @property
 * @brief 团期名
 */
@property (nonatomic , weak)      UILabel           *orderPriceThemeName;

/*!
 * @property
 * @brief 联系人姓名
 */
@property (nonatomic , weak)      UILabel           *orderLinkerUserNameLabel;

/*!
 * @property
 * @brief 联系人手机
 */
@property (nonatomic , weak)      UILabel           *orderLinkerUserMobileLabel;

/*!
 * @property
 * @brief 下单渠道
 */
@property (nonatomic , weak)      UILabel           *orderConsultRoadLabel;
/*!
 * @property
 * @brief 下单时间
 */
@property (nonatomic ,  weak)      UILabel          *orderCreateDateTimeLabel;


/*!
 * @property
 * @brief 订单人数
 */
@property (nonatomic , weak)      UILabel           *orderPeopleCountLabel;

/*!
 * @property
 * @brief 订单总价格
 */
@property (nonatomic , weak)      UILabel           *orderPriceContentLabel;


@end

@implementation ClubOrderBaiscCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    if (self) {
        
        
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KClubOrderBaiscCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        [self.backgroundView setBackgroundColor:KDefaultViewBackGroundColor];
        [self.contentView setBackgroundColor:KDefaultViewBackGroundColor];
        
        
        UIView *contentBackGroudView = [[UIView alloc]init];
        [contentBackGroudView setBackgroundColor:[UIColor whiteColor]];
        [contentBackGroudView setFrame:CGRectMake(0.0f, KInforLeftIntervalWidth,
                                                  (KProjectScreenWidth),
                                                  (KClubOrderBaiscCellHeight - KInforLeftIntervalWidth))];
        
        self.contentBackGroudView = contentBackGroudView;
        [self.contentView addSubview:contentBackGroudView];
        
        
        ///订单号
        UILabel  *orderNumber = [[UILabel alloc]init];
        [orderNumber setBackgroundColor:[UIColor clearColor]];
        [orderNumber setFont:[UIFont boldSystemFontOfSize:(18*KLVYEAdapterSizeWidth)]];
        [orderNumber setTextColor:KContentTextColor];
        self.cellTitleLabel = orderNumber;
        [self.contentBackGroudView addSubview:self.cellTitleLabel ];
        
        
        UILabel  *orderStatus = [[UILabel alloc]init];
        [orderStatus setBackgroundColor:[UIColor clearColor]];
        [orderStatus setTextAlignment:NSTextAlignmentRight];
        [orderStatus setFont:[UIFont boldSystemFontOfSize:(14*KLVYEAdapterSizeWidth)]];
        [orderStatus setTextColor:[UIColor redColor]];
        self.orderStatusLable = orderStatus;
        [self.contentBackGroudView addSubview:self.orderStatusLable ];
        
        [self.cellSeparatorView setBackgroundColor:KSeparateColorSetup];
        [self.contentBackGroudView addSubview:self.cellSeparatorView];
        
        UILabel *tourName = [[UILabel alloc]init];
        [tourName setBackgroundColor:[UIColor clearColor]];
        [tourName setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
        [tourName setTextColor:KContentTextColor];
        [tourName setNumberOfLines:3];
        [tourName setLineBreakMode:NSLineBreakByTruncatingHead];
        self.cellContentLabel = tourName;
        [self.contentBackGroudView addSubview:self.cellContentLabel ];
        
        
        UILabel  *recodGoDate = [[UILabel alloc]init];
        [recodGoDate setBackgroundColor:[UIColor clearColor]];
        [recodGoDate setTextAlignment:NSTextAlignmentLeft];
        [recodGoDate setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
        [recodGoDate setTextColor: KContentGreyTextColor];
        self.orderOutDateLabel = recodGoDate;
        [self.contentBackGroudView addSubview:self.orderOutDateLabel];
        
       
        
        UILabel  *recodPriceTheme = [[UILabel alloc]init];
        [recodPriceTheme setBackgroundColor:[UIColor clearColor]];
        [recodPriceTheme setTextAlignment:NSTextAlignmentRight];
        [recodPriceTheme setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
        [recodPriceTheme setTextColor:KContentTextColor];
        self.orderPriceThemeName = recodPriceTheme;
        [self.contentBackGroudView addSubview:self.orderPriceThemeName];
        
        
        
        UILabel  *linkerName = [[UILabel alloc]init];
        [linkerName setBackgroundColor:[UIColor clearColor]];
        [linkerName setTextAlignment:NSTextAlignmentLeft];
        [linkerName setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
        [linkerName setTextColor:KContentTextColor];
        self.orderLinkerUserNameLabel = linkerName;
        [self.contentBackGroudView addSubview:self.orderLinkerUserNameLabel];
        
        UILabel *linkerMobile = [[UILabel alloc]init];
        [linkerMobile setBackgroundColor:[UIColor clearColor]];
        [linkerMobile setTextAlignment:NSTextAlignmentRight];
        [linkerMobile setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
        [linkerMobile setTextColor:KContentTextColor];
        self.orderLinkerUserMobileLabel = linkerMobile;
        [self.contentBackGroudView addSubview:self.orderLinkerUserMobileLabel];
        
        UILabel  *consultRoad = [[UILabel alloc]init];
        [consultRoad setBackgroundColor:[UIColor clearColor]];
        [consultRoad setTextAlignment:NSTextAlignmentLeft];
        [consultRoad setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
        [consultRoad setTextColor:HUIRGBColor(162.0, 162.0, 162.0, 1.0)];
        self.orderConsultRoadLabel = consultRoad;
        [self.contentBackGroudView addSubview:self.orderConsultRoadLabel];
        
        UILabel *orderCreateDate = [[UILabel alloc]init];
        [orderCreateDate setBackgroundColor:[UIColor clearColor]];
        [orderCreateDate setTextAlignment:NSTextAlignmentRight];
        [orderCreateDate setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
        [orderCreateDate setTextColor:HUIRGBColor(162.0, 162.0, 162.0, 1.0)];
        self.orderCreateDateTimeLabel= orderCreateDate;
        [self.contentBackGroudView addSubview:self.orderCreateDateTimeLabel];
        
        
        UILabel *orderOutDay = [[UILabel alloc]init];
        [orderOutDay setBackgroundColor:[UIColor clearColor]];
        [orderOutDay setTextAlignment:NSTextAlignmentRight];
        [orderOutDay setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
        [orderOutDay setTextColor:KContentTextColor];
        self.orderOutDaysLabel = orderOutDay;
        [self.contentBackGroudView addSubview:self.orderOutDaysLabel];
        
        UILabel *peopleCount = [[UILabel alloc]init];
        [peopleCount setBackgroundColor:[UIColor clearColor]];
        [peopleCount setTextAlignment:NSTextAlignmentRight];
        [peopleCount setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
        [peopleCount setTextColor:KContentTextColor];
        self.orderPeopleCountLabel = peopleCount;
        [self.contentBackGroudView addSubview:self.orderPeopleCountLabel];
        
        UILabel *priceContent = [[UILabel alloc]init];
        [priceContent setBackgroundColor:[UIColor clearColor]];
        [priceContent setTextAlignment:NSTextAlignmentLeft];
        [priceContent setFont:[UIFont boldSystemFontOfSize:(18*KLVYEAdapterSizeWidth)]];
        [priceContent setTextColor:[UIColor redColor]];
        self.orderPriceContentLabel =priceContent;
        [self.contentBackGroudView addSubview:self.orderPriceContentLabel];
        
        
    }
    
    return self;
}

- (void)setupCellDataInfo:(ClubOrderInfo *)itemOrder{
    
    [self.cellTitleLabel setText:itemOrder.orderNumber];
    
    [self.orderStatusLable setText:[KLvyeProductClubSettings.clubOrderPaymentStyleContentArray objectAtIndex:[itemOrder.orderPaymentStatus integerValue]]];
    [self.cellContentLabel setText:[NSString stringWithFormat:@"%@ -- %@",itemOrder.tourName,itemOrder.tourBasicId]];
    
    [self.orderOutDateLabel setText:[NSString stringWithFormat:@"团期:%@(%@)",itemOrder.orderOutDateTime,itemOrder.tourPriceTheme] ];
    
    [self.orderLinkerUserNameLabel setText:[NSString stringWithFormat:@"联系人:%@",itemOrder.orderLinkUserInfo.userName]];
    [self.orderLinkerUserMobileLabel setText:[NSString stringWithFormat:@"联系电话:%@",itemOrder.orderLinkUserInfo.userMobile]];

    if(itemOrder.orderConsultRoad == ClubOrderConsultForPCClientStyle){
        [self.orderConsultRoadLabel setText:@"来源:绿野网站"];
    } else if(itemOrder.orderConsultRoad == ClubOrderConsultForH5APPClientStyle){
        [self.orderConsultRoadLabel setText:@"来源:六只脚H5"];
    } else if(itemOrder.orderConsultRoad == ClubOrderConsultForMobileClientStyle){
        [self.orderConsultRoadLabel setText:@"来源:绿野移动站"];
    }else if(itemOrder.orderConsultRoad == ClubOrderConsultForBToBClientStyle){
        [self.orderConsultRoadLabel setText:@"来源:B to B 交易"];
    } else{
        [self.orderConsultRoadLabel setText:@"来源:其他途径"];
    }
    
    
    [self.orderCreateDateTimeLabel setText:[NSString stringWithFormat:@"下单时间:%@",itemOrder.orderAddDateTime]];
    
    
    [self.orderPeopleCountLabel setText:[NSString stringWithFormat:@"人数:%ld人",itemOrder.orderManPeopleCount]];
    [self.orderOutDaysLabel setText:[NSString stringWithFormat:@"天数:%@天",itemOrder.tourTeamDays]];
//
    [self.orderPriceContentLabel setText:[NSString stringWithFormat:@"价格:¥%@",itemOrder.orderTotalAmountMoney]];
//
     [self layoutIfNeeded];
}


- (void)layoutSubviews{
    
    
    [self.contentBackGroudView setFrame:CGRectMake(0.0f, KInforLeftIntervalWidth,
                                                   (KProjectScreenWidth),
                                                   (KClubOrderBaiscCellHeight - KInforLeftIntervalWidth))];
    
    [self.cellTitleLabel setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f,(KProjectScreenWidth- KInforLeftIntervalWidth*2), KBtnCellHeight)];
    [self.orderStatusLable setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f,
                                                (self.contentBackGroudView.width -KInforLeftIntervalWidth*2), KBtnCellHeight)];
    [self.cellSeparatorView setFrame:CGRectMake(KInforLeftIntervalWidth, KBtnCellHeight,
                                                (KProjectScreenWidth-KInforLeftIntervalWidth*2), 1.0f)];
    
    ///设置宽高限制。
    CGSize boundingSize = CGSizeMake((KProjectScreenWidth - KBtnContentLeftWidth*1.5), MAXFLOAT);
    ///设置属性
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:KInforLeftIntervalWidth/2.5];
    NSDictionary *attDic =@{NSFontAttributeName: [UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)],
                            NSParagraphStyleAttributeName:paragraphStyle,};
    CGRect contentRect =  [self.cellContentLabel.text boundingRectWithSize:boundingSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
    
    [self.cellContentLabel setFrame:CGRectMake(KInforLeftIntervalWidth, self.cellSeparatorView.bottom+10.0,
                                               (self.contentBackGroudView.width -KInforLeftIntervalWidth*1.5) , contentRect.size.height)];
    ///设置行高度
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.cellContentLabel.text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.cellContentLabel.text length])];
    self.cellContentLabel.attributedText = attributedString;
    [self.cellContentLabel sizeToFit];
    
    
    [self.contentBackGroudView setHeight:((KClubOrderBaiscCellHeight - KInforLeftIntervalWidth) + contentRect.size.height)];
    [self.selectedBackgroundView setHeight:(KClubOrderBaiscCellHeight+contentRect.size.height)];
    
    
    [self.orderOutDateLabel setFrame:CGRectMake(KInforLeftIntervalWidth, self.cellContentLabel.bottom+3.0f,
                                                 (self.cellSeparatorView.width-KInforLeftIntervalWidth), KBtnCellHeight*0.6)];
    
    
    
    [self.orderLinkerUserNameLabel setFrame:CGRectMake(KInforLeftIntervalWidth, self.orderOutDateLabel.bottom+3.0f, 200.0f, KBtnCellHeight*0.6)];
    
    [self.orderLinkerUserMobileLabel setFrame:CGRectMake(0.00, self.orderOutDateLabel.bottom+3.0f,
                                                         (self.cellSeparatorView.width+KInforLeftIntervalWidth), KBtnCellHeight*0.6)];
    
    
    [self.orderConsultRoadLabel setFrame:CGRectMake(KInforLeftIntervalWidth,
                                                    self.orderLinkerUserNameLabel.bottom+3.0f, 200.0f,
                                                    KBtnCellHeight*0.6)];
    
    [self.orderCreateDateTimeLabel setFrame:CGRectMake(0.00, self.orderLinkerUserNameLabel.bottom+3.0f,
                                                         (self.cellSeparatorView.width+KInforLeftIntervalWidth), KBtnCellHeight*0.6)];

    CGRect peopleCountRect =  [self.orderPeopleCountLabel.text boundingRectWithSize:boundingSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.orderPeopleCountLabel.font} context:nil];
    [self.orderPeopleCountLabel setFrame:CGRectMake((KProjectScreenWidth - peopleCountRect.size.width - KInforLeftIntervalWidth),
                                               self.orderCreateDateTimeLabel.bottom+3.0f,
                                               peopleCountRect.size.width, KBtnCellHeight*0.6)];
    CGRect outDaysRect =  [self.orderOutDaysLabel.text boundingRectWithSize:boundingSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.orderOutDaysLabel.font} context:nil];
    [self.orderOutDaysLabel  setFrame:CGRectMake((self.orderPeopleCountLabel.left - KInforLeftIntervalWidth-outDaysRect.size.width), self.orderCreateDateTimeLabel.bottom+3.0f ,
                                                 outDaysRect.size.width, KBtnCellHeight*0.6)];
    
    [self.orderPriceContentLabel setFrame:CGRectMake(KInforLeftIntervalWidth, self.orderCreateDateTimeLabel.bottom+3.0f, self.cellSeparatorView.width+KInforLeftIntervalWidth, KBtnCellHeight*0.6)];

}
@end
