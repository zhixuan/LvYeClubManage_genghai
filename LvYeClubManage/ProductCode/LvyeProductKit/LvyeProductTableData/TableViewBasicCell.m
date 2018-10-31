//
//  TableViewBasicCell.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/13.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "TableViewBasicCell.h"


@implementation TableViewBasicCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KProjectScreenHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *cellSeparator = [[UIView alloc]init];
        [cellSeparator setBackgroundColor:[UIColor clearColor]];
        self.cellSeparatorView  =cellSeparator;
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

@end
