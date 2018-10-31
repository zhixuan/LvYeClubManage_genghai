//
//  BankDataTableViewCell.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/13.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "BankDataTableViewCell.h"

@implementation BankDataTableViewCell


- (instancetype)init{
    self = [super init];
    if (self) {
        
        UILabel   *bankNameContent = [[UILabel alloc]init];
        [bankNameContent setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KBankDataTableViewCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        
        UILabel   *bankNameContent = [[UILabel alloc]init];
        [bankNameContent setBackgroundColor:[UIColor clearColor]];
        [bankNameContent setFont:KContentLeftTitleFontOfSize];
        [bankNameContent setTextColor:KContentTextColor];
        [bankNameContent setTextAlignment:NSTextAlignmentLeft];
        self.cellTitleLabel =bankNameContent;
        [self.contentView addSubview:self.cellTitleLabel];
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

- (void)fillDataInfoWithBankInfo:(BankInfo *)bank{
    
    [self.cellTitleLabel setText:bank.bankSourceName];
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    
    [self.cellTitleLabel setFrame:CGRectMake(KBtnContentLeftWidth, 0.0f,
                                             (KProjectScreenWidth-KBtnContentLeftWidth*3.0f),
                                             KBankDataTableViewCellHeight)];
}

@end
