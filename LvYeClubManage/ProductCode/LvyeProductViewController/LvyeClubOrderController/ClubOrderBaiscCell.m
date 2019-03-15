//
//  ClubOrderBaiscCell.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/3/11.
//  Copyright © 2019年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubOrderBaiscCell.h"

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
    }
    
    return self;
}

- (void)setupCellDataInfo:(ClubOrderInfo *)itemOrder{
    
    
    
}
@end
