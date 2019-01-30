//
//  DepartmenUserTableCell.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/22.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//



#define KUserPhotoImageWidth                (KLVYEUIControlSizeWidth(50.0f))
#import "DepartmenUserTableCell.h"

@implementation DepartmenUserTableCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KDepartmenUserTableCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        
        
        UIImageView *photoImage = [[UIImageView alloc]init];
        [photoImage setBackgroundColor:[UIColor clearColor]];
        self.cellLeftImageView =photoImage;
        [self.contentView addSubview:self.cellLeftImageView];
        
        UILabel   *bankNameContent = [[UILabel alloc]init];
        [bankNameContent setBackgroundColor:[UIColor clearColor]];
        [bankNameContent setFont:KContentLeftTitleFontOfSize];
        [bankNameContent setTextColor:KContentTextColor];
        [bankNameContent setTextAlignment:NSTextAlignmentLeft];
        self.cellTitleLabel =bankNameContent;
        [self.contentView addSubview:self.cellTitleLabel];
        
        
        UIImage *rightImage = [FontAwesome imageWithIcon:FMIconFontF105 iconColor:KButtonStateNormalColor iconSize:20.0f imageSize:CGSizeMake(20.0f, 20.0f)];
        UIImageView *rightImageView = [[UIImageView alloc]initWithImage:rightImage];
//        [rightImageView setFrame:CGRectMake((KProjectScreenWidth-20.0f-KInforLeftIntervalWidth/2), (KBtnForRegisterOrLoginButtonHeight -20.0f)/2, 20.0f, 20.0f)];
        [rightImageView setBackgroundColor:[UIColor clearColor]];
        self.cellRightImageView =rightImageView;
        [self.contentView addSubview:self.cellRightImageView];
        
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


- (void)fillDataInforForCellWithUserDataSource:(NSDictionary *)dataSource{
    
    [self.cellRightImageView setHidden:YES];
    NSString *photoImageURL = [NSString stringWithFormat:@"%@%@",@"http://club.lvye.com",StringForKeyInUnserializedJSONDic(dataSource, @"photourl")];
    [self.cellLeftImageView setImageWithURL:[NSURL URLWithString:photoImageURL]
                           placeholderImage:KClueDefaultImage_ClubUserPhotoDefaultImage];
    
    NSString *userNameStr = StringForKeyInUnserializedJSONDic(dataSource, @"userName");
    NSString *userMobileStr = StringForKeyInUnserializedJSONDic(dataSource, @"userMobile");
    
    BOOL isLock = BoolForKeyInUnserializedJSONDic(dataSource, @"IsLock");
    NSString *userContentStr = [NSString stringWithFormat:@"%@\t%@",userNameStr,userMobileStr];
    
    NSDictionary *attribtDic = @{};
    if(isLock){
        attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    }
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:userContentStr attributes:attribtDic];
    self.cellTitleLabel.attributedText = attribtStr;
    
    self.dataSourceStyle = DataSourceForUserInfoStyle;
    
    [self layoutIfNeeded];
}

- (void)fillDataInfoForCellWithClubDepartmenDataSource:(NSDictionary *)dataSource{
    
    [self.cellRightImageView setHidden:NO];
    [self.cellTitleLabel setText:StringForKeyInUnserializedJSONDic(dataSource, @"departmentName")];
    self.dataSourceStyle = DataSourceForDepartmenStyle;
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    if(self.dataSourceStyle == DataSourceForUserInfoStyle){
        NSLog(@"DataSourceForUserInfoStyle is %lu",DataSourceForUserInfoStyle);
        CGFloat imageWidth = (KDepartmenUserTableCellHeight - KUserPhotoImageWidth)/2;
        [self.cellLeftImageView setFrame:CGRectMake(KUserPhotoForCellLeftInterval,imageWidth,
                                                    KUserPhotoImageWidth, KUserPhotoImageWidth)];
        [self.cellLeftImageView.layer setMasksToBounds:YES];
        [self.cellLeftImageView.layer setCornerRadius:KUserPhotoImageWidth/2];
        [self.cellTitleLabel setFrame:CGRectMake((self.cellLeftImageView.right + KUserPhotoForCellLeftInterval), 0.0f,
                                                 (KProjectScreenWidth-KBtnContentLeftWidth*2.0f-self.cellLeftImageView.right),
                                                 KDepartmenUserTableCellHeight)];
    }else if (self.dataSourceStyle == DataSourceForDepartmenStyle){
        
        NSLog(@"DataSourceForDepartmenStyle is %lu",DataSourceForDepartmenStyle);
        [self.cellTitleLabel setFrame:CGRectMake(KUserPhotoForCellLeftInterval, 0.0f,
                                                 (KProjectScreenWidth-KBtnContentLeftWidth),
                                                 KDepartmenUserTableCellHeight)];
        
        [self.cellRightImageView setFrame:CGRectMake((KProjectScreenWidth-20.0f-KInforLeftIntervalWidth/2), (KDepartmenUserTableCellHeight -20.0f)/2, 20.0f, 20.0f)];
    }
    [self.cellSeparatorView setFrame:CGRectMake(KUserPhotoForCellLeftInterval, (KDepartmenUserTableCellHeight-1.0f),
                                                (KProjectScreenWidth- KUserPhotoForCellLeftInterval), 1.0f)];
}



@end
