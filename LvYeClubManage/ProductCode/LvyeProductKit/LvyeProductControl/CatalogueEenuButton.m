//
//  CatalogueEenuButton.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/15.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "CatalogueEenuButton.h"


#define KBtnCellBasicTag            (1520111)
@interface CatalogueEenuButton()

/*!
 * @property
 * @brief 界面 CGRect
 */
@property (nonatomic , assign)      CGRect btnFrame;

/*!
 * @property
 * @brief 内容数组信息
 */
@property (nonatomic ,  strong)      NSArray        *contentArray;
@end

@implementation CatalogueEenuButton



- (instancetype)initWithFrame:(CGRect)frame contentArray:(NSArray *)array{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.btnFrame = frame;
        self.contentArray = [[NSArray alloc]initWithArray:array];
    }
    
    return self;
}

- (void)setContentViewFrame{
    
    
    NSInteger contentCount = [self.contentArray count];
    CGFloat btnWidthFloat = KProjectScreenWidth/contentCount;
    
    for (NSUInteger index = 0; index<[self.contentArray count]; index++) {
        NSDictionary *itemDic = (NSDictionary *)[self.contentArray objectAtIndex:index];
        NSString *itemNameStr = StringForKeyInUnserializedJSONDic(itemDic, @"name");
        NSString *itemContId = StringForKeyInUnserializedJSONDic(itemDic, @"id");
        
        UIButtonCell *button = [UIButtonCell buttonWithType:UIButtonTypeCustom];
        [button setBtnItemInfoId:itemContId];
        [button setBtnItemInfoContent:itemNameStr];
        [button setFrame:CGRectMake(btnWidthFloat*index, 0.0f, btnWidthFloat, self.height-2.0f)];
        [button setTitle:itemNameStr forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor clearColor]];
        [button setTag:(KBtnCellBasicTag+index)];
        [button setBackgroundImage:createImageWithColor([UIColor whiteColor]) forState:UIControlStateNormal];
        [button setBackgroundImage:createImageWithColor([UIColor whiteColor]) forState:UIControlStateHighlighted];
//        [button setTitleColor:kna forState:<#(UIControlState)#>];
    }
}

- (void)userPersonalClickedEvent:(UIButtonCell *)button{
    ///信息传递
    if (self.block) {
        self.block([button.btnItemInfoId integerValue]);
    }
    
}
@end
