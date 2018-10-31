//
//  ClubLeaderTableViewCell.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubLeaderTableViewCell.h"

#define KLeaderPhotoImageWidth                  (48.0f)
@implementation ClubLeaderTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KClubLeaderTableViewCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        
        
        UIImageView *leftImageView  =[[UIImageView alloc]init];
        [leftImageView setBackgroundColor:KImageNormalColor];
        [leftImageView.layer setMasksToBounds:YES];
        [leftImageView.layer setCornerRadius:KLeaderPhotoImageWidth/2];
        self.cellLeftImageView = leftImageView;
        [self.contentView addSubview:self.cellLeftImageView];
        
        UILabel *leaderName = [[UILabel alloc]init];
        [leaderName setBackgroundColor:[UIColor clearColor]];
        [leaderName setFont:[UIFont systemFontOfSize:15.0f]];
        [leaderName setTextColor:KContentTextColor];
        [leaderName setTextAlignment:NSTextAlignmentLeft];
        self.cellTitleLabel = leaderName;
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


- (void)fillClubLeaderDataSource:(ClubLeaderInfo *)dataSource{

    ///image url
    NSString *imageUrlStr = [NSString stringWithFormat:@"%@%@",KEY_RESPONSE_LVYE_IMAGE_URL,dataSource.userPhotoImageURL];
    [self.cellLeftImageView setImageWithURL:[NSURL URLWithString:imageUrlStr] placeholderImage:KClueDefaultImage_ClubLeaderPhotoImage];
   
    [self.cellTitleLabel setText:dataSource.userName];
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    [self.cellLeftImageView setFrame:CGRectMake(KBtnContentLeftWidth, KBtnBackGroundTop, KLeaderPhotoImageWidth, KLeaderPhotoImageWidth)];
    [self.cellTitleLabel setFrame:CGRectMake((self.cellLeftImageView.right+KBtnContentLeftWidth), KBtnBackGroundTop, 200.0f, 20.0f)];
}
@end
