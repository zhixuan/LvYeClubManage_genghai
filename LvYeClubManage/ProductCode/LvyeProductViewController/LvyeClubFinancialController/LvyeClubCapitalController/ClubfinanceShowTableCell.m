//
//  ClubfinanceShowTableCell.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/27.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubfinanceShowTableCell.h"

@interface ClubfinanceShowTableCell ()


/*!
 * @property
 * @brief 进账类别
 */
@property (nonatomic , weak)      UILabel               *recodStyleLabel;

/*!
 * @property
 * @brief 添加时间
 */
@property (nonatomic , weak)      UILabel               *recodCreateDateLabel;
@end

@implementation ClubfinanceShowTableCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KClubfinanceShowTableCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        
        
        
        UILabel *orderNumber = [[UILabel alloc]init];
        [orderNumber setBackgroundColor:[UIColor clearColor]];
        [orderNumber setFont:[UIFont systemFontOfSize:17.0f]];
        [orderNumber setTextColor:KContentTextColor];
        [orderNumber setTextAlignment:NSTextAlignmentLeft];
        self.cellTitleLabel = orderNumber;
        [self.contentView addSubview:self.cellTitleLabel];
        
        
        UILabel *recodStyle = [[UILabel alloc]init];
        [recodStyle setBackgroundColor:[UIColor clearColor]];
        [recodStyle setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [recodStyle setTextColor:KContentTextColor];
        [recodStyle setTextAlignment:NSTextAlignmentRight];
        self.recodStyleLabel = recodStyle;
        [self.contentView addSubview:self.recodStyleLabel];
        
        UILabel *recodContent= [[UILabel alloc]init];
        [recodContent setBackgroundColor:[UIColor clearColor]];
        [recodContent setFont:[UIFont boldSystemFontOfSize:18.0f]];
        [recodContent setTextColor:KContentTextColor];
        [recodContent setTextAlignment:NSTextAlignmentLeft];
        self.cellContentLabel = recodContent;
        [self.contentView addSubview:self.cellContentLabel];
        
        
        UILabel *recodCreateDate= [[UILabel alloc]init];
        [recodCreateDate setBackgroundColor:[UIColor clearColor]];
        [recodCreateDate setFont:[UIFont systemFontOfSize:15.0f]];
        [recodCreateDate setTextColor:KContentTextColor];
        [recodCreateDate setTextAlignment:NSTextAlignmentRight];
        self.recodCreateDateLabel = recodCreateDate;
        [self.contentView addSubview:self.recodCreateDateLabel];
        
        
        
        [self.cellSeparatorView setBackgroundColor:KSeparateColorSetup];
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


- (void)fillClubfinanceShowTableCellDataSourceWithClubFinanceCapitalRecod:(ClubFinanceCapitalRecod *)recod{
    
    
    
    NSInteger depositStrLen=   [recod.capitalDepositId length];
    NSString *codeStr = [NSString stringWithFormat:@"提款编号:%@",@"TX"];
    for(int count = 0;count < (10 - depositStrLen - 2);count++){
        codeStr = [codeStr stringByAppendingString:@"0"];
    }
    codeStr = [codeStr stringByAppendingString:recod.capitalDepositId];
    [self.cellTitleLabel setText:codeStr];
    
    [self.recodCreateDateLabel setText:recod.capitalAddTimeStr];
    
    
    if (recod.capitalRecodStatusType == 1){
        [self.recodStyleLabel setText:@"收入"];
        [self.recodStyleLabel setTextColor:HUIRGBColor(211.0f, 52.0f, 5.0f, 1.0f)];
        
    }else if(recod.capitalRecodStatusType == 2 || recod.capitalRecodStatusType == 3){
        
        [self.recodStyleLabel setText:@"支出"];
        [self.recodStyleLabel setTextColor:HUIRGBColor(56.0f, 153.0f, 57.0f, 1.0f)];
    }
    
    [self.cellContentLabel setText:[@"金额:" stringByAppendingString:recod.capitalMoneyCotnent]];
    
    
    
    
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    
    
    [self.cellTitleLabel setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth, 280.0f, 18.0f)];
    [self.recodCreateDateLabel setFrame:CGRectMake(200.0f, KInforLeftIntervalWidth,
                                                   (KProjectScreenWidth - KInforLeftIntervalWidth - 200.0f), 18.0f)];
    
    [self.cellContentLabel setFrame:CGRectMake(KInforLeftIntervalWidth,
                                               (self.cellTitleLabel.bottom  + KInforLeftIntervalWidth),
                                               180.0f, 18.0f)];
    
    [self.recodStyleLabel setFrame:CGRectMake(200.0f,( self.cellTitleLabel.bottom  + KInforLeftIntervalWidth),
                                              (KProjectScreenWidth - KInforLeftIntervalWidth - 200.0f), 18.0f)];
    
    [self.cellSeparatorView setFrame:CGRectMake(KInforLeftIntervalWidth, (KClubfinanceShowTableCellHeight - 1.0f),
                                                (KProjectScreenWidth - KInforLeftIntervalWidth*2), 1.0f)];
}
@end
