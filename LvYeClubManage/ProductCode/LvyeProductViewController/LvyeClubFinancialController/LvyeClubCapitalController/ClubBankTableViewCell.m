//
//  ClubBankTableViewCell.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubBankTableViewCell.h"

@interface ClubBankTableViewCell()
/*!
 * @property
 * @brief 银行卡类型
 */
@property (nonatomic , weak)      UILabel               *bankStyleLabel;

@end

@implementation ClubBankTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView setBackgroundColor: [UIColor clearColor]];
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KClubBankTableViewCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        
        
        
        UIView *bgView = [[UIView alloc]init];
        [bgView.layer setMasksToBounds:YES];
        [bgView.layer setCornerRadius:5.0f];
        [bgView setBackgroundColor:[UIColor whiteColor]];
        [bgView setFrame:CGRectMake(KBtnContentLeftWidth, KBtnContentLeftWidth,
                                    (KProjectScreenWidth - KBtnContentLeftWidth*2),
                                    (KClubBankTableViewCellHeight - KBtnContentLeftWidth))];
        [self.contentView addSubview:bgView];
        
        
        UILabel   *bankNameContent = [[UILabel alloc]init];
        [bankNameContent setBackgroundColor:[UIColor clearColor]];
        [bankNameContent setFont:[UIFont systemFontOfSize:22.0f]];
        [bankNameContent setTextColor:KContentTextColor];
        [bankNameContent setTextAlignment:NSTextAlignmentLeft];
        self.cellTitleLabel =bankNameContent;
        [bgView addSubview:self.cellTitleLabel];
        
        UILabel   *bankStyleContent = [[UILabel alloc]init];
        [bankStyleContent setBackgroundColor:[UIColor clearColor]];
        [bankStyleContent setFont:[UIFont systemFontOfSize:12.0f]];
        [bankStyleContent setTextColor:KContentTextColor];
        [bankStyleContent setTextAlignment:NSTextAlignmentLeft];
        self.bankStyleLabel =bankStyleContent;
        [bgView addSubview:self.bankStyleLabel ];
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


- (void)fillClubBankInfo:(ClubBankInfo *)clubBank{
    [self.cellTitleLabel setText:clubBank.bankSourceName];
    
    if (clubBank.clubBankAccounStyle == ClubBankPublicStyle) {
        [self.bankStyleLabel setText:@"对公账户"];
    } else {
        [self.bankStyleLabel setText:@"个人账户"];
    }
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    
    [self.cellTitleLabel setFrame:CGRectMake(KBtnContentLeftWidth, KBtnContentLeftWidth,
                                             (KProjectScreenWidth-KBtnContentLeftWidth*3.0f),
                                             25.0f)];
    [self.bankStyleLabel setFrame:CGRectMake(KBtnContentLeftWidth, self.cellTitleLabel.bottom, 80.0f, 25.0f)];
}
@end
