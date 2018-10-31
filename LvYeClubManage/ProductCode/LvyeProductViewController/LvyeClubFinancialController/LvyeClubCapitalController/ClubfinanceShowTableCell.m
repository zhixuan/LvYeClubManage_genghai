//
//  ClubfinanceShowTableCell.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/27.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubfinanceShowTableCell.h"

@implementation ClubfinanceShowTableCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KClubfinanceShowTableCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        
        
        
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
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    
    [self.cellSeparatorView setFrame:CGRectMake(KInforLeftIntervalWidth, (KClubfinanceShowTableCellHeight - 1.0f),
                                                (KProjectScreenWidth - KInforLeftIntervalWidth*2), 1.0f)];
}
@end
