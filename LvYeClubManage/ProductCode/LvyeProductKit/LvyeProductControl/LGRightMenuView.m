//
//  LGRightMenuView.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/4/2.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "LGRightMenuView.h"

#define KButtonItemButtonHegith     (40.0f)
#define KButtonItemButtonBasicTag   (1412111)

@interface LGRightMenuView ()

/*!
 * @property
 * @brief 用户需要的操作内容
 */
@property (nonatomic , strong)      NSDictionary            *userOperContent;

/*!
 * @property
 * @brief 显示在外面的Menu内容
 */
@property (nonatomic , strong)      NSArray                 *userMenuContentArray;
@end
@implementation LGRightMenuView
- (instancetype)initWithFrame:(CGRect)frame content:(NSDictionary *)content menuContent:(nonnull NSArray *)menuContent{
    
    
    self = [super initWithFrame:frame];
    if (self) {
        self.userOperContent = [[NSDictionary alloc]initWithDictionary:content];
        self.userMenuContentArray = [[NSArray alloc]initWithArray:menuContent];
        [self setBackgroundImage:createImageWithColor(HUIRGBColor(62.0f, 62.0f, 62.0f, 0.6f)) forState:UIControlStateNormal];
        [self setBackgroundImage:createImageWithColor(HUIRGBColor(62.0f, 62.0f, 62.0f, 0.6f)) forState:UIControlStateHighlighted];
        [self addTarget:self action:@selector(setHiddenEventOperation) forControlEvents:UIControlEventTouchUpInside];
        
        [self setupFrameControlInfo];
    }
    
    return self;
}

#pragma mark -
#pragma mark -  用户点击界面任意位置，页面收缩
- (void)setHiddenEventOperation{
    [self setHidden:YES];
}


- (void)setupFrameControlInfo{
    
    
    UIView  *menuBGView = [[UIView alloc]init];
    [menuBGView setBackgroundColor:[UIColor whiteColor]];
    
    CGFloat heightFloat = [self.userOperContent count] * KButtonItemButtonHegith + 0.8f*([self.userOperContent count] -1);
    [menuBGView setFrame:CGRectMake((KProjectScreenWidth - KInforLeftIntervalWidth - 100.0f), 44.0f +20.0f,100.0f, heightFloat)];
    [menuBGView.layer setMasksToBounds:YES];
    [menuBGView.layer setCornerRadius:1.0f];
    [self addSubview:menuBGView];
    
    CGFloat btnBottomFloat = 0.0f;
    for (NSString *nameKey in self.userMenuContentArray) {
        
        UIButton *itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemButton setBackgroundImage:createImageWithColor([UIColor whiteColor])
                              forState:UIControlStateNormal];
        [itemButton setBackgroundImage:createImageWithColor(HUIRGBColor(244.0, 244.0f, 244.0, 0.8))
                              forState:UIControlStateHighlighted];
        [itemButton setTitleColor: KContentTextColor forState:UIControlStateNormal];
        [itemButton setTitleColor:KContentTextColor forState:UIControlStateHighlighted];
        [itemButton setTitle:nameKey forState:UIControlStateNormal];
        [itemButton setFrame:CGRectMake(0.0f, btnBottomFloat, menuBGView.width, KButtonItemButtonHegith)];
        [itemButton setTag:(KButtonItemButtonBasicTag + IntForKeyInUnserializedJSONDic(self.userOperContent, nameKey))];
        [itemButton addTarget:self action:@selector(userPersonalOperaiontEvent:)
             forControlEvents:UIControlEventTouchUpInside];
        [menuBGView addSubview:itemButton];
    
        if (![@"更多" isEqualToString:nameKey]) {
            UIView *cellSeparator = [[UIView alloc]init];
            [cellSeparator setBackgroundColor:KSeparateColorSetup];
            [cellSeparator setFrame:CGRectMake(0.0f, itemButton.bottom, itemButton.width, 0.8)];
             [menuBGView addSubview:cellSeparator];
             btnBottomFloat=cellSeparator.bottom;
           
        }
    }
}

- (void)userPersonalOperaiontEvent:(UIButton *)button{
    
    NSInteger buttonTag = button.tag - KButtonItemButtonBasicTag ;
    
    if(buttonTag < 100){
        self.block(NO,@{@"tourStatus":[NSString stringWithFormat:@"%ld",buttonTag]});
    }else{
        self.block(YES, @{});
    }
    
    
}


@end
