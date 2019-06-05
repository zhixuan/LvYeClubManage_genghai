//
//  CommentDetailCell.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/5/15.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "CommentDetailCell.h"
#import "UIFont+FontAwesome.h"

@interface CommentDetailCell ()

/*!
 * @property
 * @brief 评论时间
 */
@property (nonatomic , weak)      UILabel               *commentDateLabel;

/*!
 * @property
 * @brief 评论人名字
 */
@property (nonatomic , weak)      UILabel               *commentUserNameLabel;


/*!
 * @property
 * @brief 描述评价
 */
@property (nonatomic , weak)      UILabel               *commentDescriptionLabel;

/*!
 * @property
 * @brief 组织评价
 */
@property (nonatomic , weak)      UILabel               *commentOrganizeLabel;

/*!
 * @property
 * @brief 精彩程度平阿基
 */
@property (nonatomic , weak)      UILabel               *commentWonderfulLabel;

/*!
 * @property
 * @brief 评论的总评价得分
 */
@property (nonatomic ,  weak)      UILabel              *commentScaleLabel;


@end


@implementation CommentDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        //设置选中Cell后的背景图
        UIView *selectedView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KCommentDetailCellHeight)];
        [selectedView setBackgroundColor:KTableViewCellSelectedColor];
        self.selectedBackgroundView = selectedView;
        
        ////评论内容
        UILabel *commentContent = [[UILabel alloc]init];
        [commentContent setBackgroundColor:[UIColor clearColor]];
        [commentContent setFont:KCommentDetailContentFont];
        [commentContent setTextColor:KContentTextColor];
        [commentContent setNumberOfLines:3];
        [commentContent setLineBreakMode:NSLineBreakByWordWrapping];
        [commentContent setTextAlignment:NSTextAlignmentLeft];
        self.cellContentLabel = commentContent;
        [self.contentView addSubview:self.cellContentLabel];
        
        UILabel *commentUserName= [[UILabel alloc]init];
        [commentUserName setBackgroundColor:[UIColor clearColor]];
        [commentUserName setFont:[UIFont systemFontOfSize:14.0f]];
        [commentUserName setTextColor:KContentTextColor];
        [commentUserName setTextAlignment:NSTextAlignmentLeft];
        self.commentUserNameLabel = commentUserName;
        [self.contentView addSubview:self.commentUserNameLabel];
        
        UILabel *commentDate = [[UILabel alloc]init];
        [commentDate setBackgroundColor:[UIColor clearColor]];
        [commentDate setFont:[UIFont systemFontOfSize:14.0f]];
        [commentDate setTextColor:KContentGreyTextColor];
        [commentDate setTextAlignment:NSTextAlignmentRight];
        self.commentDateLabel = commentDate;
        [self.contentView addSubview:self.commentDateLabel];
        
        
        UILabel *commentDescription= [[UILabel alloc]init];
        [commentDescription setBackgroundColor:[UIColor clearColor]];
        [commentDescription setFont:[UIFont fontAwesomeFontOfSize:14.0f]];
        [commentDescription setTextColor:KContentTextColor];
        [commentDescription setTextAlignment:NSTextAlignmentLeft];
        self.commentDescriptionLabel = commentDescription;
        [self.contentView addSubview:self.commentDescriptionLabel];
        
     
        
        UILabel *commentOrganize= [[UILabel alloc]init];
        [commentOrganize setBackgroundColor:[UIColor clearColor]];
        [commentOrganize setFont:[UIFont fontAwesomeFontOfSize:14.0f]];
        [commentOrganize setTextColor:KContentTextColor];
        [commentOrganize setTextAlignment:NSTextAlignmentLeft];
        self.commentOrganizeLabel = commentOrganize;
        [self.contentView addSubview:self.commentOrganizeLabel];
        

        
        UILabel *commentWonderful= [[UILabel alloc]init];
        [commentWonderful setBackgroundColor:[UIColor clearColor]];
        [commentWonderful setFont:[UIFont fontAwesomeFontOfSize:14.0f]];
        [commentWonderful setTextColor:KContentTextColor];
        [commentWonderful setTextAlignment:NSTextAlignmentLeft];
        self.commentWonderfulLabel = commentWonderful;
        [self.contentView addSubview:self.commentWonderfulLabel];
        
        UILabel *scaleLable = [[UILabel alloc]init];
        [scaleLable setBackgroundColor:[UIColor clearColor]];
        [scaleLable setFont:[UIFont boldSystemFontOfSize:17.0f]];
        [scaleLable setTextColor:HUIRGBColor(229.0f,83.0f,21.0f,1.0f)];
        [scaleLable setTextAlignment:NSTextAlignmentRight];
        self.commentScaleLabel = scaleLable;
        [self.contentView addSubview:self.commentScaleLabel];
        
        
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


- (void)fildCommentDetailDataSourceWithTourCommentInfo:(NSDictionary *)info{
    
    [self.commentUserNameLabel setText:[@"评论人:" stringByAppendingString:StringForKeyInUnserializedJSONDic(info, @"user_name")]];
    [self.commentDateLabel setText:StringForKeyInUnserializedJSONDic(info, @"add_time")];
    
    [self.cellContentLabel setText:StringForKeyInUnserializedJSONDic(info, @"content")];
    
    
    
    self.commentDescriptionLabel.attributedText= [self attributedStringWithTitle:@"描述信息: " scale:StringForKeyInUnserializedJSONDic(info, @"description")];
    
    self.commentWonderfulLabel.attributedText= [self attributedStringWithTitle:@"精彩程度: " scale:StringForKeyInUnserializedJSONDic(info, @"wonderful")];
    
    self.commentOrganizeLabel.attributedText= [self attributedStringWithTitle:@"组织情况: " scale:StringForKeyInUnserializedJSONDic(info, @"organize")];
    
    NSString *scaleIntStr = StringForKeyInUnserializedJSONDic(info, @"scale");
    [self.commentScaleLabel setText:@"中评"];
    if ([@"1" isEqualToString:scaleIntStr]) {
        [self.commentScaleLabel setText:@"好评"];
    }else if ([@"2" isEqualToString:scaleIntStr]) {
        [self.commentScaleLabel setText:@"中评"];
    }else if ([@"3" isEqualToString:scaleIntStr]) {
        [self.commentScaleLabel setText:@"差评"];
    }else{
        [self.commentScaleLabel setText:@"中评"];
    }
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    
    
    [self.commentUserNameLabel setFrame:CGRectMake(KInforLeftIntervalWidth, KInforLeftIntervalWidth, 200.0f, 25.0f)];
    [self.commentDateLabel setFrame:CGRectMake((KProjectScreenWidth - KInforLeftIntervalWidth - 150.0f), KInforLeftIntervalWidth, 150.0f, 25.0f)];
    
     CGFloat contentHeight = 0.00;
    
    if(!IsStringEmptyOrNull(self.cellContentLabel.text)){
        ///设置宽高限制。
        CGSize boundingSize = CGSizeMake((KProjectScreenWidth - KBtnContentLeftWidth*2), MAXFLOAT);
        ///设置属性
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:KInforLeftIntervalWidth/1.5];
        NSDictionary *attDic =@{NSFontAttributeName:KCommentDetailContentFont,};
        CGRect contentRect =  [self.cellContentLabel.text boundingRectWithSize:boundingSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
        
        contentHeight =contentRect.size.height ;
        
        [self.cellContentLabel setFrame:CGRectMake(KInforLeftIntervalWidth,
                                                   self.commentDateLabel.bottom,
                                                   (KProjectScreenWidth - KBtnContentLeftWidth*2),contentHeight+10.0f)];

    }else{
        [self.cellContentLabel setFrame:CGRectMake(KInforLeftIntervalWidth,
                                                   self.commentDateLabel.bottom,
                                                   (KProjectScreenWidth - KBtnContentLeftWidth*2),contentHeight)];
    }
    
    
    
    [self.commentDescriptionLabel setFrame:CGRectMake(KInforLeftIntervalWidth, self.cellContentLabel.bottom, 250.0f, 25.0f)];
    
    [self.commentOrganizeLabel setFrame:CGRectMake(KInforLeftIntervalWidth, self.commentDescriptionLabel.bottom, 250.0f, 25.0f)];
    
    [self.commentWonderfulLabel setFrame:CGRectMake(KInforLeftIntervalWidth, self.commentOrganizeLabel.bottom, 250.0f, 25.0f)];
    
    [self.commentScaleLabel setFrame:CGRectMake((KProjectScreenWidth - KInforLeftIntervalWidth - 70.0f), self.commentDescriptionLabel.top, 70.0f, 75.0f)];
    
    [self.cellSeparatorView setFrame:CGRectMake(0.0f, (self.commentWonderfulLabel.bottom + KInforLeftIntervalWidth-1.0f), KProjectScreenWidth, 1.0f)];
    [self.selectedBackgroundView setHeight:self.commentWonderfulLabel.bottom + KInforLeftIntervalWidth];
}


- (NSMutableAttributedString *)attributedStringWithTitle:(NSString *)title scale:(NSString *)scale{
    
    ///描述信息
    NSMutableString * starDescription = [NSMutableString stringWithFormat:@"%@",@""];
    for (int index = 0; index<5; index++) {
        FMIconFont defalut = FMIconFontF005;
        if ( [scale intValue] - 1 < index) {
            defalut =FMIconFontF006;
        }
        [starDescription appendString:[@"  " stringByAppendingString:[NSString fontAwesomeIconStringForEnum:defalut]]];
    }
    
    [starDescription appendString: [@"  " stringByAppendingString:[scale stringByAppendingString:@"分" ]]];
    
    NSString *contentStr =[title stringByAppendingString:starDescription];
    NSMutableAttributedString *resultAttributedString = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSRange resultAttributeRange=[contentStr rangeOfString: starDescription];
    [resultAttributedString addAttribute:NSForegroundColorAttributeName value:HUIRGBHexColor(0xF77911,1.0) range:resultAttributeRange];
    [resultAttributedString addAttribute:NSFontAttributeName
                                   value:[UIFont fontAwesomeFontOfSize:17.0f]
                                   range:resultAttributeRange];
    return resultAttributedString;
}
@end
