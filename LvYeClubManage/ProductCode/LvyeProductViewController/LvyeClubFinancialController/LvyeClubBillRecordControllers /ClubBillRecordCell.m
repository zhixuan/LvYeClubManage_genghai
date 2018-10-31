//
//  ClubBillRecordCell.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/9/3.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubBillRecordCell.h"

@implementation ClubBillRecordCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KClubBillRecordCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        [self.backgroundView setBackgroundColor:[UIColor clearColor]];
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        
        
        UIView *contentBackGroudView = [[UIView alloc]init];
        [contentBackGroudView setBackgroundColor:[UIColor whiteColor]];
//        [contentBackGroudView.layer setCornerRadius:2.0f];
//        [contentBackGroudView.layer setMasksToBounds:YES];
        [contentBackGroudView setFrame:CGRectMake(0.0f, KInforLeftIntervalWidth,
                                                  (KProjectScreenWidth),
                                                  (KClubBillRecordCellHeight - KInforLeftIntervalWidth))];
        
        self.contentBackGroudView = contentBackGroudView;
        [self.contentView addSubview:contentBackGroudView];
        
        UILabel  *orderNumber = [[UILabel alloc]init];
        [orderNumber setBackgroundColor:[UIColor clearColor]];
        [orderNumber setFont:[UIFont boldSystemFontOfSize:(18*KLVYEAdapterSizeWidth)]];
        [orderNumber setTextColor:KContentTextColor];
        self.cellTitleLabel = orderNumber;
        [self.contentBackGroudView addSubview:self.cellTitleLabel ];
        
        
        UILabel  *recodStatus = [[UILabel alloc]init];
        [recodStatus setBackgroundColor:[UIColor clearColor]];
        [recodStatus setTextAlignment:NSTextAlignmentRight];
        [recodStatus setFont:[UIFont boldSystemFontOfSize:(14*KLVYEAdapterSizeWidth)]];
        [recodStatus setTextColor:[UIColor redColor]];
        self.recordStatusLable = recodStatus;
        [self.contentBackGroudView addSubview:self.recordStatusLable ];
        
         [self.cellSeparatorView setBackgroundColor:KSeparateColorSetup];
        [self.contentBackGroudView addSubview:self.cellSeparatorView];
        
        
        UILabel *tourName = [[UILabel alloc]init];
        [tourName setBackgroundColor:[UIColor clearColor]];
        [tourName setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
        [tourName setTextColor:KContentTextColor];
        [tourName setNumberOfLines:2];
        [tourName setLineBreakMode:NSLineBreakByTruncatingHead];
        self.cellContentLabel = tourName;
        [self.contentBackGroudView addSubview:self.cellContentLabel ];
        
        UILabel  *recodGoDate = [[UILabel alloc]init];
        [recodGoDate setBackgroundColor:[UIColor clearColor]];
        [recodGoDate setTextAlignment:NSTextAlignmentLeft];
        [recodGoDate setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
        [recodGoDate setTextColor:KContentTextColor];
        self.recordOutDateLabel = recodGoDate;
        [self.contentBackGroudView addSubview:self.recordOutDateLabel];
        
        UILabel  *recodPriceTheme = [[UILabel alloc]init];
        [recodPriceTheme setBackgroundColor:[UIColor clearColor]];
        [recodPriceTheme setTextAlignment:NSTextAlignmentRight];
        [recodPriceTheme setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
        [recodPriceTheme setTextColor:KContentTextColor];
        self.recordPriceThemeName = recodPriceTheme;
        [self.contentBackGroudView addSubview:self.recordPriceThemeName];
        
        
        UILabel  *recodIntMoney = [[UILabel alloc]init];
        [recodIntMoney setBackgroundColor:[UIColor clearColor]];
        [recodIntMoney setTextAlignment:NSTextAlignmentLeft];
        [recodIntMoney setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
        [recodIntMoney setTextColor:KContentTextColor];
        self.recordIncreaseLabel = recodIntMoney;
        [self.contentBackGroudView addSubview:self.recordIncreaseLabel];
        
        UILabel  *recodOutMoney = [[UILabel alloc]init];
        [recodOutMoney setBackgroundColor:[UIColor clearColor]];
        [recodOutMoney setTextAlignment:NSTextAlignmentCenter];
        [recodOutMoney setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
        [recodOutMoney setTextColor:KContentTextColor];
        self.recordSubtractLabel = recodOutMoney;
        [self.contentBackGroudView addSubview:self.recordSubtractLabel];
        
        UILabel  *recodResultMoney = [[UILabel alloc]init];
        [recodResultMoney setBackgroundColor:[UIColor clearColor]];
        [recodResultMoney setTextAlignment:NSTextAlignmentRight];
        [recodResultMoney setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
        [recodResultMoney setTextColor:KContentTextColor];
        self.recordResultLabel = recodResultMoney;
        [self.contentBackGroudView addSubview:self.recordResultLabel];
        
        
        UILabel  *recodOrderChannel = [[UILabel alloc]init];
        [recodOrderChannel setBackgroundColor:[UIColor clearColor]];
        [recodOrderChannel setTextAlignment:NSTextAlignmentLeft];
        [recodOrderChannel setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
        [recodOrderChannel setTextColor:KContentTextColor];
        self.recordOrderChannelLabel = recodOrderChannel;
        [self.contentBackGroudView addSubview:self.recordOrderChannelLabel];
        
        UILabel  *recodOrderPayStyle = [[UILabel alloc]init];
        [recodOrderPayStyle setBackgroundColor:[UIColor clearColor]];
        [recodOrderPayStyle setTextAlignment:NSTextAlignmentRight];
        [recodOrderPayStyle setFont:[UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)]];
        [recodOrderPayStyle setTextColor:KContentTextColor];
        self.recordOrderPayStyleLabel = recodOrderPayStyle;
        [self.contentBackGroudView addSubview:self.recordOrderPayStyleLabel];
       
        
    }
     self.backgroundColor = [UIColor clearColor];
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)fillClubBillRecordShowTableCellDataSourceWithClubFinanceCapitalRecod:(ClubFinanceCapitalRecod *)recod{
    
    [self.cellTitleLabel setText:recod.orderNumber];
    
    
    if (recod.capitalBillCheckStateType ==0) {
        [self.recordStatusLable setText:@"未结算"];
    } else if (recod.capitalBillCheckStateType ==1) {
        [self.recordStatusLable setText:@"申请中"];
    } else if (recod.capitalBillCheckStateType ==2) {
        [self.recordStatusLable setText:@"已结算"];
    }
    
    [self.cellContentLabel setText:[NSString stringWithFormat:@"%@ -- %@",recod.tourName,recod.tourBasicId]];
    
    
    [self.recordOutDateLabel setText:[NSString stringWithFormat:@"出发时间:%@",recod.tourPriceLeaveDate]];
    [self.recordPriceThemeName setText:[NSString stringWithFormat:@"%@",recod.tourPriceTheme]];
    
    NSString *increaseContentStr = [NSString stringWithFormat:@"入账: ¥%@",recod.orderTotalAmountMoney];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:increaseContentStr];
    NSRange attributeRange=[ increaseContentStr rangeOfString:[NSString stringWithFormat:@"¥%@",recod.orderTotalAmountMoney]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:HUIRGBColor(211.0f, 52.0f, 5.0f, 1.0f) range:attributeRange];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:(17*KLVYEAdapterSizeWidth)] range:attributeRange];
    self.recordIncreaseLabel.attributedText = attributedString;
    
    

    NSString *subtractContentStr = [NSString stringWithFormat:@"出账: ¥%@",recod.orderRefundPrice];
    NSMutableAttributedString *subtractAttributedString = [[NSMutableAttributedString alloc] initWithString:subtractContentStr];
    NSRange subtractAttributeRange=[ subtractContentStr rangeOfString: [NSString stringWithFormat:@"¥%@",recod.orderRefundPrice]];
    [subtractAttributedString addAttribute:NSForegroundColorAttributeName value:HUIRGBColor(56.0f, 153.0f, 57.0f, 1.0f) range:subtractAttributeRange];
    [subtractAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:(17*KLVYEAdapterSizeWidth)] range:subtractAttributeRange];
    self.recordSubtractLabel.attributedText= subtractAttributedString;
    
    
    
    NSString *resultContentStr = [NSString stringWithFormat:@"余额: ¥%@",recod.capitalMoneyCotnent];
    NSMutableAttributedString *resultAttributedString = [[NSMutableAttributedString alloc] initWithString:resultContentStr];
    NSRange resultAttributeRange=[ resultContentStr rangeOfString: [NSString stringWithFormat:@"¥%@",recod.capitalMoneyCotnent]];
    [resultAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:resultAttributeRange];
    [resultAttributedString addAttribute:NSFontAttributeName
                                   value:[UIFont boldSystemFontOfSize:(17*KLVYEAdapterSizeWidth)]
                                   range:resultAttributeRange];
    self.recordResultLabel.attributedText= resultAttributedString;
//    [self.recordResultLabel setText:[NSString stringWithFormat:@"余额: ¥%@",recod.capitalMoneyCotnent]];
    
    
    if(recod.orderConsultRoad == ClubOrderConsultForPCClientStyle){
        [self.recordOrderChannelLabel setText:@"来源：绿野网站"];
    } else if(recod.orderConsultRoad == ClubOrderConsultForH5APPClientStyle){
        [self.recordOrderChannelLabel setText:@"来源：六只脚H5"];
    } else if(recod.orderConsultRoad == ClubOrderConsultForMobileClientStyle){
        [self.recordOrderChannelLabel setText:@"来源：绿野移动站"];
    }else if(recod.orderConsultRoad == ClubOrderConsultForBToBClientStyle){
        [self.recordOrderChannelLabel setText:@"来源：B to B 交易"];
    } else{
         [self.recordOrderChannelLabel setText:@"来源：其他途径"];
    }
    
    
    if (recod.orderPayStyle == ClubOrderPayForAliPayStyle) {
        [self.recordOrderPayStyleLabel setText:@"支付方式：支付宝"];
    } else if (recod.orderPayStyle == ClubOrderPaylWeChatPayStyle) {
        [self.recordOrderPayStyleLabel setText:@"支付方式：微信"];
    }else {
        [self.recordOrderPayStyleLabel setText:@"支付方式：其他"];
    }
    
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    
    
    [self.contentBackGroudView setFrame:CGRectMake(0.0f, KInforLeftIntervalWidth,
                                                   (KProjectScreenWidth),
                                                   (KClubBillRecordCellHeight - KInforLeftIntervalWidth))];
    
    [self.cellTitleLabel setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f,(KProjectScreenWidth- KInforLeftIntervalWidth*2), KBtnCellHeight)];
    [self.recordStatusLable setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f,
                                                (self.contentBackGroudView.width -KInforLeftIntervalWidth*2), KBtnCellHeight)];
    [self.cellSeparatorView setFrame:CGRectMake(KInforLeftIntervalWidth, KBtnCellHeight,
                                               (KProjectScreenWidth-KInforLeftIntervalWidth*2), 1.0f)];
    
    
    
    ///设置宽高限制。
    CGSize boundingSize = CGSizeMake((KProjectScreenWidth - KBtnContentLeftWidth*2), MAXFLOAT);
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
    
    
    [self.recordOutDateLabel setFrame:CGRectMake(KInforLeftIntervalWidth, self.cellContentLabel.bottom+3.0f,
                                                 (self.cellSeparatorView.width-KInforLeftIntervalWidth), KBtnCellHeight*0.6)];

    [self.recordPriceThemeName setFrame:CGRectMake(0.00f, self.cellContentLabel.bottom+3.0f ,
                                                   (self.cellSeparatorView.width+KInforLeftIntervalWidth), KBtnCellHeight*0.6)];
    
    [self.recordIncreaseLabel setFrame:CGRectMake(KInforLeftIntervalWidth, self.recordOutDateLabel.bottom,
                                                  (KProjectScreenWidth - KInforLeftIntervalWidth*2)/3, KBtnCellHeight*0.6)];
    
    [self.recordSubtractLabel setFrame:CGRectMake(self.recordIncreaseLabel.right, self.recordOutDateLabel.bottom,
                                                  (KProjectScreenWidth - KInforLeftIntervalWidth*2)/3, KBtnCellHeight*0.6)];
    
    [self.recordResultLabel setFrame:CGRectMake(self.recordSubtractLabel.right, self.recordOutDateLabel.bottom,
                                                  (KProjectScreenWidth - KInforLeftIntervalWidth*2)/3, KBtnCellHeight*0.6)];
    
    [self.recordOrderChannelLabel setFrame:CGRectMake(KInforLeftIntervalWidth, self.recordSubtractLabel.bottom,
                                                      (KProjectScreenWidth - KInforLeftIntervalWidth*2)/2, KBtnCellHeight*0.6)];
    [self.recordOrderPayStyleLabel setFrame:CGRectMake(self.recordOrderChannelLabel.right, self.recordSubtractLabel.bottom,
                                                      (KProjectScreenWidth - KInforLeftIntervalWidth*2)/2, KBtnCellHeight*0.6)];
    
    
}
@end
