//
//  UIDottedView.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/14.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "UIDottedView.h"

@implementation UIDottedView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context=UIGraphicsGetCurrentContext();//获取绘图用的图形上下文
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);//填充色设置成
    CGFloat lengths[] = {4};
    CGContextSetLineDash(context, 4, lengths,1);
    
    CGContextFillRect(context,self.bounds);//把整个空间用刚设置的颜色填充
    //上面是准备工作，下面开始画线了
    CGContextSetStrokeColorWithColor(context, KContentTextColor.CGColor);//设置线的颜色
    CGContextMoveToPoint(context,0,0);//画线的起始点位置
    CGContextAddLineToPoint(context,self.frame.size.width,0);//画第一条线的终点位置
    
    CGContextStrokePath(context);//把线在界面上绘制出来
}

@end
