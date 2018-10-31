//
//  ClubSettleTableCell.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/9/3.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubSettleTableCell.h"

@implementation ClubSettleTableCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KClubSettleTableCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        [self.backgroundView setBackgroundColor:[UIColor clearColor]];
        [self.contentView setBackgroundColor:[UIColor clearColor]];
        
        
        UIView *contentBackGroudView = [[UIView alloc]init];
        [contentBackGroudView setBackgroundColor:[UIColor whiteColor]];
        [contentBackGroudView.layer setCornerRadius:2.0f];
        [contentBackGroudView.layer setMasksToBounds:YES];
        [contentBackGroudView setFrame:CGRectMake(0.0f, KInforLeftIntervalWidth,
                                                  (KProjectScreenWidth),
                                                  (KClubSettleTableCellHeight - KInforLeftIntervalWidth))];
        
        self.contentBackGroudView = contentBackGroudView;
        [self.contentView addSubview:contentBackGroudView];
        
        UILabel  *orderNumber = [[UILabel alloc]init];
        [orderNumber setBackgroundColor:[UIColor clearColor]];
        [orderNumber setFont:[UIFont boldSystemFontOfSize:(18*KLVYEAdapterSizeWidth)]];
        [orderNumber setTextColor:KContentTextColor];
        self.cellTitleLabel = orderNumber;
        [self.contentBackGroudView addSubview:self.cellTitleLabel ];
        
        
        UILabel  *recodAddDate = [[UILabel alloc]init];
        [recodAddDate setBackgroundColor:[UIColor clearColor]];
        [recodAddDate setTextAlignment:NSTextAlignmentRight];
        [recodAddDate setFont:[UIFont systemFontOfSize:(14*KLVYEAdapterSizeWidth)]];
        [recodAddDate setTextColor:KContentTextColor];
        self.recordAddDateLabel = recodAddDate;
        [self.contentBackGroudView addSubview:self.recordAddDateLabel ];
        
        [self.cellSeparatorView setBackgroundColor:KSeparateColorSetup];
        [self.contentBackGroudView addSubview:self.cellSeparatorView];
        
        
        
        UILabel  *recodResultMoney = [[UILabel alloc]init];
        [recodResultMoney setBackgroundColor:[UIColor clearColor]];
        [recodResultMoney setTextAlignment:NSTextAlignmentLeft];
        [recodResultMoney setFont:[UIFont systemFontOfSize:(14*KLVYEAdapterSizeWidth)]];
        [recodResultMoney setTextColor:KContentTextColor];
        self.recordResultLabel = recodResultMoney;
        [self.contentBackGroudView addSubview:self.recordResultLabel];
        
        UILabel  *recodStatus = [[UILabel alloc]init];
        [recodStatus setBackgroundColor:[UIColor clearColor]];
        [recodStatus setTextAlignment:NSTextAlignmentRight];
        [recodStatus setFont:[UIFont boldSystemFontOfSize:(14*KLVYEAdapterSizeWidth)]];
        [recodStatus setTextColor:[UIColor redColor]];
        self.recordStatusLable = recodStatus;
        [self.contentBackGroudView addSubview:self.recordStatusLable ];
        
        
        
        UILabel  *recodOrderCount = [[UILabel alloc]init];
        [recodOrderCount setBackgroundColor:[UIColor clearColor]];
        [recodOrderCount setTextAlignment:NSTextAlignmentRight];
        [recodOrderCount setFont:[UIFont systemFontOfSize:(14*KLVYEAdapterSizeWidth)]];
        [recodOrderCount setTextColor:KContentTextColor];
        self.recordOrderCountLabel = recodOrderCount;
        [self.contentBackGroudView addSubview:self.recordOrderCountLabel ];
        
        UILabel  *recodPeople = [[UILabel alloc]init];
        [recodPeople setBackgroundColor:[UIColor clearColor]];
        [recodPeople setTextAlignment:NSTextAlignmentLeft];
        [recodPeople setFont:[UIFont systemFontOfSize:(14*KLVYEAdapterSizeWidth)]];
        [recodPeople setTextColor:KContentTextColor];
        self.recordOrderPeopleCountLabel = recodPeople;
        [self.contentBackGroudView addSubview:self.recordOrderPeopleCountLabel ];
        
        
        
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

- (void)fillClubSettleTableCellDataSourceWithClubFinanceCapitalRecod:(ClubFinanceCapitalRecod *)recod{

    [self.cellTitleLabel setText:recod.capitalRecodNumber];
    

    [self.recordAddDateLabel setText:recod.capitalAddTimeStr];
    
    
    
    if (recod.capitalBillCheckStateType ==1) {
        [self.recordStatusLable setText:@"未结算"];
    } else if (recod.capitalBillCheckStateType ==2) {
        [self.recordStatusLable setText:@"申请中"];
    } else if (recod.capitalBillCheckStateType ==3) {
        [self.recordStatusLable setText:@"已结算"];
    }

    
    
    NSString *resultContentStr = [NSString stringWithFormat:@"余额: ¥%@",recod.capitalMoneyCotnent];
    NSMutableAttributedString *resultAttributedString = [[NSMutableAttributedString alloc] initWithString:resultContentStr];
    NSRange resultAttributeRange=[ resultContentStr rangeOfString: [NSString stringWithFormat:@"¥%@",recod.capitalMoneyCotnent]];
    [resultAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:resultAttributeRange];
    [resultAttributedString addAttribute:NSFontAttributeName
                                   value:[UIFont boldSystemFontOfSize:(17*KLVYEAdapterSizeWidth)]
                                   range:resultAttributeRange];
    self.recordResultLabel.attributedText= resultAttributedString;
    
    
    
    NSString *increaseContentStr = [NSString stringWithFormat:@"人 数： %ld人",recod.capitalOrderPeopleCount];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:increaseContentStr];
    NSRange attributeRange=[ increaseContentStr rangeOfString:[NSString stringWithFormat:@"%ld人",recod.capitalOrderPeopleCount]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:(18*KLVYEAdapterSizeWidth)] range:attributeRange];
    self.recordOrderPeopleCountLabel.attributedText = attributedString;

    NSString *subtractContentStr = [NSString stringWithFormat:@"订单个数： %ld个",recod.capitalOrderCount];
    NSMutableAttributedString *subtractAttributedString = [[NSMutableAttributedString alloc] initWithString:subtractContentStr];
    NSRange subtractAttributeRange=[ subtractContentStr rangeOfString: [NSString stringWithFormat:@"%ld个",recod.capitalOrderCount]];
    [subtractAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:(18*KLVYEAdapterSizeWidth)] range:subtractAttributeRange];
    self.recordOrderCountLabel.attributedText= subtractAttributedString;
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    
    [self.contentBackGroudView setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth,
                                                   (KProjectScreenWidth - KInforLeftIntervalWidth*2),
                                                   (KClubSettleTableCellHeight - KInforLeftIntervalWidth))];
    
    [self.cellTitleLabel setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f,self.contentBackGroudView.width, KBtnCellHeight)];
    
    
    [self.recordStatusLable setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f,
                                                (self.contentBackGroudView.width -KInforLeftIntervalWidth*2), KBtnCellHeight)];

    [self.cellSeparatorView setFrame:CGRectMake(KInforLeftIntervalWidth, KBtnCellHeight,
                                                (KProjectScreenWidth-KInforLeftIntervalWidth*2), 1.0f)];
    
    [self.recordResultLabel setFrame:CGRectMake(KInforLeftIntervalWidth, self.cellSeparatorView.bottom, (self.contentBackGroudView.width -KInforLeftIntervalWidth*2), KBtnCellHeight*0.7)];
    
    [self.recordAddDateLabel setFrame:CGRectMake(KInforLeftIntervalWidth, self.cellSeparatorView.bottom,
                                                 (self.contentBackGroudView.width -KInforLeftIntervalWidth*2), KBtnCellHeight*0.7)];
    
    [self.recordOrderPeopleCountLabel setFrame:CGRectMake(KInforLeftIntervalWidth, self.recordAddDateLabel.bottom,
                                                          (self.contentBackGroudView.width -KInforLeftIntervalWidth*2), KBtnCellHeight*0.7)];
    
    
    [self.recordOrderCountLabel setFrame:CGRectMake(KInforLeftIntervalWidth, self.recordAddDateLabel.bottom,
                                                    (self.contentBackGroudView.width -KInforLeftIntervalWidth*2), KBtnCellHeight*0.7)];
}

@end
