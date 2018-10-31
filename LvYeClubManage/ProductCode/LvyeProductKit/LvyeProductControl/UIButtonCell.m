//
//  UIButtonCell.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/7.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "UIButtonCell.h"
#import "FontAwesome.h"



@implementation UIButtonCell


- (instancetype)init{
    self = [super init];
    
    if (self) {
        self.btnControTitleName = [[NSString alloc]initWithFormat:@"%@",@""];
        self.btnClassName = [[NSString alloc]initWithFormat:@"%@",@""];
        self.btnItemInfoId = [[NSString alloc]initWithFormat:@"%@",@""];
        self.btnItemInfoContent = [[NSString alloc]initWithFormat:@"%@",@""];
    }
    
    return self;
}


+ (instancetype)buttonNormalWithType:(UIButtonType)buttonType{
   
    UIButtonCell *button = [UIButtonCell buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:createImageWithColor([UIColor whiteColor]) forState:UIControlStateNormal];
    [button setBackgroundImage:createImageWithColor(KButtonStateHighlightedColor) forState:UIControlStateHighlighted];
    [button setTitleColor:KContentTextColor forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, KBtnContentLeftWidth, 0, 0)];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    UIImage *rightImage = [FontAwesome imageWithIcon:FMIconFontF105 iconColor:KButtonStateNormalColor iconSize:20.0f imageSize:CGSizeMake(20.0f, 20.0f)];
    UIImageView *rightImageView = [[UIImageView alloc]initWithImage:rightImage];
    [rightImageView setFrame:CGRectMake((KProjectScreenWidth-20.0f-KInforLeftIntervalWidth/2), (KBtnForRegisterOrLoginButtonHeight -20.0f)/2, 20.0f, 20.0f)];
    [rightImageView setBackgroundColor:[UIColor clearColor]];
    [button addSubview:rightImageView];
    
    return button;
}

+ (instancetype)buttonCellWithType:(UIButtonType)buttonType{
    
    UIButtonCell *button = [UIButtonCell buttonWithType:UIButtonTypeCustom];

    [button setBackgroundImage:createImageWithColor([UIColor whiteColor]) forState:UIControlStateNormal];
    [button setBackgroundImage:createImageWithColor(KButtonStateHighlightedColor) forState:UIControlStateHighlighted];
    [button setTitleColor:KContentTextColor forState:UIControlStateNormal];
    [button.layer setMasksToBounds:YES];
    [button.layer setBorderWidth:1.0];
    [button.layer setBorderColor:KSeparateColorSetup.CGColor];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, (KInforLeftIntervalWidth*1.5+20.0f), 0, 0)];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView setImage:createImageWithColor(KButtonStateNormalColor)];
    [imageView setBackgroundColor:KButtonStateNormalColor];
    [imageView setFrame:CGRectMake(KInforLeftIntervalWidth, (KBtnForRegisterOrLoginButtonHeight -25.0f)/2, 3.0f, 25.0f)];
    [imageView setBackgroundColor:[UIColor clearColor]];
    [button addSubview:imageView];
    
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, (KInforLeftIntervalWidth*1.5+3.0f), 0, 0)];
    
    
    
    UIImage *rightImage = [FontAwesome imageWithIcon:FMIconFontF105 iconColor:KButtonStateNormalColor iconSize:20.0f imageSize:CGSizeMake(20.0f, 20.0f)];
    UIImageView *rightImageView = [[UIImageView alloc]initWithImage:rightImage];
    [rightImageView setFrame:CGRectMake((KProjectScreenWidth-20.0f-KInforLeftIntervalWidth/2), (KBtnForRegisterOrLoginButtonHeight -20.0f)/2, 20.0f, 20.0f)];
    [rightImageView setBackgroundColor:[UIColor clearColor]];
    [button addSubview:rightImageView];
    
    return button;
}

+ (instancetype)buttonCellWithType:(UIButtonType)buttonType icon:(FMIconFont)imageIcon{
    UIButtonCell *button = [UIButtonCell buttonWithType:UIButtonTypeCustom];
    
    
    UIImage *normalImage= [UIImage initWithGradientColorWithDirection:GradientColorHorizontalStyle
                                                                 size:CGSizeMake(KProjectScreenWidth, KBtnCellHeight)
                                                           startColor:HUIRGBColor(225.0, 225.0f, 225.0f, 1.0f)
                                                             endColor:[UIColor whiteColor]];
    [button setBackgroundImage:normalImage forState:UIControlStateNormal];
//    [button setBackgroundImage:createImageWithColor([UIColor whiteColor]) forState:UIControlStateNormal];
    [button setBackgroundImage:createImageWithColor(KButtonStateHighlightedColor) forState:UIControlStateHighlighted];
    [button setTitleColor:KContentTextColor forState:UIControlStateNormal];
    [button.layer setMasksToBounds:YES];
    [button.layer setBorderWidth:1.0];
    [button.layer setBorderColor:KSeparateColorSetup.CGColor];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, (KInforLeftIntervalWidth*1.5+20.0f), 0, 0)];
    [button setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    
    
    if(imageIcon != FMIconNULL){
        UIImage *image = [FontAwesome imageWithIcon:imageIcon iconColor:KButtonStateNormalColor iconSize:20.0f imageSize:CGSizeMake(20.0f, 20.0f)];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [imageView setFrame:CGRectMake(KInforLeftIntervalWidth, (KBtnForRegisterOrLoginButtonHeight -20.0f)/2, 20.0f, 20.0f)];
        [imageView setBackgroundColor:[UIColor clearColor]];
        [button addSubview:imageView];
        
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, (KInforLeftIntervalWidth*1.5+20.0f), 0, 0)];
    }else{
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setImage:createImageWithColor(KButtonStateNormalColor)];
        [imageView setBackgroundColor:KButtonStateNormalColor];
        [imageView setFrame:CGRectMake(KInforLeftIntervalWidth, (KBtnForRegisterOrLoginButtonHeight -25.0f)/2, 3.0f, 25.0f)];
        [imageView setBackgroundColor:[UIColor clearColor]];
        [button addSubview:imageView];
        
        [button setTitleEdgeInsets:UIEdgeInsetsMake(0, (KInforLeftIntervalWidth*1.5+3.0f), 0, 0)];
        
    }

    
    UIImage *rightImage = [FontAwesome imageWithIcon:FMIconFontF105 iconColor:KButtonStateNormalColor iconSize:20.0f imageSize:CGSizeMake(20.0f, 20.0f)];
    UIImageView *rightImageView = [[UIImageView alloc]initWithImage:rightImage];
    [rightImageView setFrame:CGRectMake((KProjectScreenWidth-20.0f-KInforLeftIntervalWidth/2), (KBtnForRegisterOrLoginButtonHeight -20.0f)/2, 20.0f, 20.0f)];
    [rightImageView setBackgroundColor:[UIColor clearColor]];
    [button addSubview:rightImageView];
    
    return button;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
