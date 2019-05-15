//
//  ClubTourTableCell.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/4/8.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubTourTableCell.h"


@interface ClubTourTableCell ( )


/*!
 * @property
 * @brief y活动出发地
 */
@property (nonatomic , weak)      UILabel           *tourSendCityLabel;


/*!
 * @property
 * @brief 活动出游天数
 */
@property (nonatomic , weak)      UILabel           *tourDaysIntervalLabel;

/*!
 * @property
 * @brief 活动起步价哦
 */
@property (nonatomic , weak)      UILabel           *tourUpPriceLabel;


/*!
 * @property
 * @brief 活动状态
 */
@property (nonatomic , weak)      UILabel           *tourStatusLabel;

/*!
 * @property
 * @brief 线路 ID
 */
@property (nonatomic , weak)      UILabel           *tourIdLabel;

/*!
 * @property
 * @brief 活动交通方式
 */
@property (nonatomic , weak)      UILabel           *tourTrafficStyleNameLabel;


@end

@implementation ClubTourTableCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KClubTourTableCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        
        
        UIImageView *leftImageView  =[[UIImageView alloc]init];
        [leftImageView setBackgroundColor:KImageNormalColor];
        [leftImageView.layer setMasksToBounds:YES];
        self.cellLeftImageView = leftImageView;
        [self.contentView addSubview:self.cellLeftImageView];
        
        UILabel *sendCityLabel = [[UILabel alloc]init];
        [sendCityLabel setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.4f]];
        [sendCityLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [sendCityLabel setTextColor:[UIColor whiteColor]];
        [sendCityLabel setTextAlignment:NSTextAlignmentCenter];
        self.tourSendCityLabel =sendCityLabel;
        [self.cellLeftImageView addSubview:self.tourSendCityLabel];
        
        UILabel *tourName = [[UILabel alloc]init];
        [tourName setBackgroundColor:[UIColor clearColor]];
        [tourName setFont:[UIFont systemFontOfSize:14.0f]];
        [tourName setTextColor:KContentTextColor];
        [tourName setNumberOfLines:2];
        [tourName setLineBreakMode:NSLineBreakByWordWrapping];
        [tourName setTextAlignment:NSTextAlignmentLeft];
        self.cellTitleLabel = tourName;
        [self.contentView addSubview:self.cellTitleLabel];
        
        
        UILabel *tourDay = [[UILabel alloc]init];
        [tourDay setBackgroundColor:[UIColor clearColor]];
        [tourDay setFont:[UIFont systemFontOfSize:12.0f]];
        [tourDay setTextColor:KContentTextColor];
        [tourDay setTextAlignment:NSTextAlignmentRight];
        self.tourDaysIntervalLabel = tourDay;
        [self.contentView addSubview:self.tourDaysIntervalLabel];
        
        
        UILabel *tourTraffic = [[UILabel alloc]init];
        [tourTraffic setBackgroundColor:[UIColor clearColor]];
        [tourTraffic setFont:[UIFont systemFontOfSize:12.0f]];
        [tourTraffic setTextColor:KContentTextColor];
        [tourTraffic setTextAlignment:NSTextAlignmentLeft];
        self.tourTrafficStyleNameLabel = tourTraffic;
        [self.contentView addSubview:self.tourTrafficStyleNameLabel];
        
        
        
        UILabel *upPriceLabel =  [[UILabel alloc]init];
        [upPriceLabel setBackgroundColor:[UIColor clearColor]];
        [upPriceLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [upPriceLabel setTextColor:KContentTextColor];
        [upPriceLabel setTextAlignment:NSTextAlignmentLeft];
        self.tourUpPriceLabel = upPriceLabel;
        [self.contentView addSubview:self.tourUpPriceLabel];
        
        
        UILabel *statusLabel = [[UILabel alloc]init];
        [statusLabel setBackgroundColor:[UIColor clearColor]];
        [statusLabel setFont:[UIFont systemFontOfSize:18.0f]];
        [statusLabel setTextColor:HUIRGBColor(68.0f, 206.0f, 137.0f, 1.0f)];
        [statusLabel setTextAlignment:NSTextAlignmentRight];
        self.tourStatusLabel = statusLabel;
        [self.contentView addSubview:self.tourStatusLabel];
        
        
        UILabel *tourId = [[UILabel alloc]init];
        [tourId setBackgroundColor:[UIColor clearColor]];
        [tourId setFont:[UIFont systemFontOfSize:12.0f]];
        [tourId setTextColor:KContentTextColor];
        [tourId setTextAlignment:NSTextAlignmentLeft];
        self.tourIdLabel = tourId;
        [self.contentView addSubview:self.tourIdLabel];
        
        
        UIView * separatorView = [[UIView alloc]init];
        [separatorView setBackgroundColor:KSeparateColorSetup];
        self.cellSeparatorView = separatorView;
        [self.contentView addSubview:self.cellSeparatorView];
        
    }
    
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

- (void)fillClubTourTableCellDataSourceWithTourBasicInfo:(TourBasicInfo *)info{
    
    [self.cellTitleLabel setText:info.tourName];
    
    [self.cellLeftImageView setImageWithURL:getCompleteImageURLForQiNiuWithImageURLStr(info.tourPublicizeImageURL) placeholderImage:KImageNormalImageViewWithColor];
    [self.tourSendCityLabel setText:[info.tourSendCitiesName stringByAppendingString:@"出发"]];
    
    
    NSString *daysIntervalContentStr = [@"出游天数:" stringByAppendingString: [info.tourTeamDays stringByAppendingString:@"天"]];
    NSMutableAttributedString *daysIntervalAttributedString = [[NSMutableAttributedString alloc] initWithString:daysIntervalContentStr];
    NSRange daysIntervalAttributeRange=[ daysIntervalContentStr rangeOfString: [NSString stringWithFormat:@"%@",info.tourTeamDays]];
    [daysIntervalAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:(15*KLVYEAdapterSizeWidth)] range:daysIntervalAttributeRange];
    self.tourDaysIntervalLabel.attributedText= daysIntervalAttributedString;
    
    
    

    NSString *trafficContentStr = [@"主要交通:" stringByAppendingString:info.tourBigTrafficName];
    NSMutableAttributedString *trafficAttributedString = [[NSMutableAttributedString alloc] initWithString:trafficContentStr];
    NSRange subtractAttributeRange=[ trafficContentStr rangeOfString: [NSString stringWithFormat:@"%@",info.tourBigTrafficName]];
    [trafficAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:(15*KLVYEAdapterSizeWidth)] range:subtractAttributeRange];
    self.tourTrafficStyleNameLabel.attributedText= trafficAttributedString;

    
    NSString * tourPriceStr = formateCurrencyDecimalWithMoneyStr(info.tourStartingPrice);
    NSString *upPriceContentStr = [@"¥:" stringByAppendingString:[tourPriceStr stringByAppendingString:@"起"]];
    NSMutableAttributedString *upPriceAttributedString = [[NSMutableAttributedString alloc] initWithString:upPriceContentStr];
    NSRange upPriceAttributeRange=[ upPriceContentStr rangeOfString: [NSString stringWithFormat:@"%@",tourPriceStr]];
    [upPriceAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:(15*KLVYEAdapterSizeWidth)] range:upPriceAttributeRange];
    [upPriceAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:upPriceAttributeRange];
    self.tourUpPriceLabel.attributedText= upPriceAttributedString;
    
    [self.tourIdLabel setText:[@"线路编号:" stringByAppendingString:info.tourBasicId]];
    
    [self.tourStatusLabel setText:StringForKeyInUnserializedJSONDic(KLvyeProductClubSettings.clubTourInfoStyleContentDictionary, info.tourStatus)];

    
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    
    [self.cellLeftImageView setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth, KClubTourLeftImageHeight*1.1, KClubTourLeftImageHeight)];
    
    [self.tourSendCityLabel setFrame:CGRectMake(0.0f, self.cellLeftImageView.height -20.0f, self.cellLeftImageView.width, 20.0f)];
    ///设置宽高限制。
    CGSize boundingSize = CGSizeMake((KProjectScreenWidth - self.cellLeftImageView.right- KBtnContentLeftWidth*1.5), MAXFLOAT);
    ///设置属性
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:KInforLeftIntervalWidth/1.5];
    NSDictionary *attDic =@{NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
                            NSParagraphStyleAttributeName:paragraphStyle,};
    CGRect contentRect =  [self.cellTitleLabel.text boundingRectWithSize:boundingSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
    [self.cellTitleLabel setFrame:CGRectMake(self.cellLeftImageView.right+KInforLeftIntervalWidth,
                                             KInforLeftIntervalWidth,
                                             (KProjectScreenWidth -self.cellLeftImageView.right -KInforLeftIntervalWidth*1.5) ,
                                             contentRect.size.height > 50.0f ? 48.0f : contentRect.size.height)];
    
       [self.tourTrafficStyleNameLabel setFrame:CGRectMake(self.cellTitleLabel.left, (self.cellTitleLabel.bottom+3.0f),  110.0f, 18.0f)];
    
    
    [self.tourDaysIntervalLabel setFrame:CGRectMake(self.tourDaysIntervalLabel.left, (self.cellTitleLabel.bottom+3.0f),
                                                    (KProjectScreenWidth - self.tourDaysIntervalLabel.left - KInforLeftIntervalWidth), 18.0f)];
    
 
    
    [self.tourUpPriceLabel setFrame:CGRectMake(self.cellTitleLabel.left, (self.tourTrafficStyleNameLabel.bottom+6.0f), 110.0f, 18.0f)];
    
    [self.tourIdLabel setFrame:CGRectMake(self.cellTitleLabel.left, (self.tourUpPriceLabel.bottom+6.0f), 110.0f, 18.0f)];
    
    
    [self.tourStatusLabel setFrame:CGRectMake(self.cellTitleLabel.left, self.tourDaysIntervalLabel.bottom, (KProjectScreenWidth -self.cellTitleLabel.left - KInforLeftIntervalWidth), (KClubTourTableCellHeight - self.tourDaysIntervalLabel.bottom -1.0f))];
    
    
    [self.cellSeparatorView setFrame:CGRectMake(0.0f, (KClubTourTableCellHeight-1.0f), KProjectScreenWidth, 1.0f)];
    
}




@end
