//
//  ClubTourCommentCell.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/5/10.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubTourCommentCell.h"

@implementation ClubTourCommentCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KClubTourCommentCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        
        
        UIImageView *leftImageView  =[[UIImageView alloc]init];
        [leftImageView setBackgroundColor:KImageNormalColor];
        [leftImageView.layer setMasksToBounds:YES];
        self.cellLeftImageView = leftImageView;
        [self.contentView addSubview:self.cellLeftImageView];
        
        
        UILabel *tourName = [[UILabel alloc]init];
        [tourName setBackgroundColor:[UIColor clearColor]];
        [tourName setFont:[UIFont systemFontOfSize:15.0f]];
        [tourName setTextColor:KContentTextColor];
        [tourName setNumberOfLines:2];
        [tourName setLineBreakMode:NSLineBreakByWordWrapping];
        [tourName setTextAlignment:NSTextAlignmentLeft];
        self.cellTitleLabel = tourName;
        [self.contentView addSubview:self.cellTitleLabel];
        
        
        
        UILabel *groupDateLable = [[UILabel alloc]init];
        [groupDateLable setBackgroundColor:[UIColor clearColor]];
        [groupDateLable setFont:[UIFont systemFontOfSize:14.0f]];
        [groupDateLable setTextColor:KContentTextColor];
        [groupDateLable setTextAlignment:NSTextAlignmentLeft];
        self.tourGroupDateLable = groupDateLable;
        [self.contentView addSubview:self.tourGroupDateLable];
        
        
        UILabel *userNameLable = [[UILabel alloc]init];
        [userNameLable setBackgroundColor:[UIColor clearColor]];
        [userNameLable setFont:[UIFont systemFontOfSize:14.0f]];
        [userNameLable setTextColor:KContentTextColor];
        [userNameLable setTextAlignment:NSTextAlignmentLeft];
        self.tourCommentUserName = userNameLable;
        [self.contentView addSubview:self.tourCommentUserName];
        
        UILabel *scaleLable = [[UILabel alloc]init];
        [scaleLable setBackgroundColor:[UIColor clearColor]];
        [scaleLable setFont:[UIFont boldSystemFontOfSize:17.0f]];
        [scaleLable setTextColor:HUIRGBColor(229.0f,83.0f,21.0f,1.0f)];
        [scaleLable setTextAlignment:NSTextAlignmentRight];
        self.tourCommentScale = scaleLable;
        [self.contentView addSubview:self.tourCommentScale];

//
        UILabel *tourId = [[UILabel alloc]init];
        [tourId setBackgroundColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.4f]];
        [tourId setFont:[UIFont systemFontOfSize:14.0f]];
        [tourId setTextColor:[UIColor whiteColor]];
        [tourId setTextAlignment:NSTextAlignmentCenter];
        self.tourIdLabel =tourId;
        [self.cellLeftImageView addSubview:self.tourIdLabel];
        
        
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


- (void)fillClubTourCommentTableCellDataSourceWithTourBasicInfo:(NSDictionary *)info{
    
    [self.cellLeftImageView setImageWithURL:getCompleteImageURLForQiNiuWithImageURLStr(StringForKeyInUnserializedJSONDic(info, @"tourPic")) placeholderImage:KImageNormalImageViewWithColor];
    
    [self.cellTitleLabel setText:StringForKeyInUnserializedJSONDic(info, @"team_name")];
    [self.tourIdLabel setText:StringForKeyInUnserializedJSONDic(info, @"tour_id")];
    [self.tourGroupDateLable setText:[@"出游时间:" stringByAppendingString:StringForKeyInUnserializedJSONDic(info, @"intention_date")]];
    
    [self.tourCommentUserName setText:[@"用户名:"stringByAppendingString:StringForKeyInUnserializedJSONDic(info, @"user_name")]];
    NSString *scaleIntStr = StringForKeyInUnserializedJSONDic(info, @"scale");
    [self.tourCommentScale setText:@"中评"];
    if ([@"1" isEqualToString:scaleIntStr]) {
        [self.tourCommentScale setText:@"好评"];
    }else if ([@"2" isEqualToString:scaleIntStr]) {
        [self.tourCommentScale setText:@"中评"];
    }else if ([@"3" isEqualToString:scaleIntStr]) {
        [self.tourCommentScale setText:@"差评"];
    }else{
        [self.tourCommentScale setText:@"中评"];
    }
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    
    [self.cellLeftImageView setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth, KClubTourCommentLeftImageHeight*1.3, KClubTourCommentLeftImageHeight)];
    
    [self.tourIdLabel setFrame:CGRectMake(0.0f, self.cellLeftImageView.height -20.0f, self.cellLeftImageView.width, 20.0f)];
    
    ///设置宽高限制。
    CGSize boundingSize = CGSizeMake((KProjectScreenWidth - self.cellLeftImageView.right- KBtnContentLeftWidth*1.5), MAXFLOAT);
    ///设置属性
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:KInforLeftIntervalWidth/1.5];
    NSDictionary *attDic =@{NSFontAttributeName:[UIFont systemFontOfSize:15.0f],
                            NSParagraphStyleAttributeName:paragraphStyle,};
    CGRect contentRect =  [self.cellTitleLabel.text boundingRectWithSize:boundingSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
    [self.cellTitleLabel setFrame:CGRectMake(self.cellLeftImageView.right+KInforLeftIntervalWidth,
                                             KInforLeftIntervalWidth,
                                             (KProjectScreenWidth -self.cellLeftImageView.right -KInforLeftIntervalWidth*1.5) ,
                                             contentRect.size.height > 50.0f ? 48.0f : contentRect.size.height)];
    
     [self.tourGroupDateLable setFrame:CGRectMake(self.cellTitleLabel.left, (self.cellTitleLabel.bottom+6.0f), 160.0f, 18.0f)];
    
    [self.tourCommentUserName  setFrame:CGRectMake(self.cellTitleLabel.left, (self.tourGroupDateLable.bottom+6.0f), 140.0f, 18.0f)];
    [self.tourCommentScale setFrame:CGRectMake(self.cellTitleLabel.left,
                                               (self.cellTitleLabel.bottom+6.0f),
                                               (KProjectScreenWidth - KInforLeftIntervalWidth - self.cellTitleLabel.left) , 42)];
    
    [self.cellSeparatorView setFrame:CGRectMake(0.0f, (KClubTourCommentCellHeight-1.0f), KProjectScreenWidth, 1.0f)];
}
@end
