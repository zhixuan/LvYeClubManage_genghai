//
//  VerificationCodeImageView.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/20.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "VerificationCodeImageView.h"


#define KImageCodeLength    4
#define ARC4RAND_MAX 0x100000000

@interface VerificationCodeImageView()

/*!
 * @property
 * @brief 验证码信息源
 */
@property (nonatomic , strong)      NSArray         *codeTextArry;

@property (nonatomic, strong) UIView *bgView;
@end

@implementation VerificationCodeImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.codeLength = KImageCodeLength;
        
        self.codeTextArry = [[NSArray alloc]initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",
                             @"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",
                             @"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
        
    }
    return self;
}

- (void)setCodeStr{
    
    for (NSInteger indexTemp = 0; indexTemp< self.codeLength; indexTemp++) {
        NSInteger index = arc4random() % ([self.codeTextArry count] - 1);
        NSString *itemCode = [self.codeTextArry objectAtIndex:index];
        self.imageCode = indexTemp == 0 ? itemCode: [self.imageCode stringByAppendingString:itemCode];
    }
    
    if (self.block) {
        self.block(self.imageCode);
    }
}

- (void)setImageCodeView{
    
    if (_bgView) {
        [_bgView removeFromSuperview];
    }
    _bgView = [[UIView alloc]initWithFrame:self.bounds];
    [self addSubview:_bgView];
    [_bgView setBackgroundColor:[self backgroundColorWithAlpah:0.5]];
    
    NSUInteger imageCodeLength = self.imageCode.length;
    
    CGSize textSize = [@"W" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    int randWidth = (self.frame.size.width)/imageCodeLength - textSize.width;
    int randHeight = self.frame.size.height - textSize.height;

    
    
    ///加入 label 内容
    for (int i = 0; i<imageCodeLength; i++) {
        
        CGFloat px = arc4random()%randWidth + i*(self.frame.size.width-3)/imageCodeLength;
        CGFloat py = arc4random()%randHeight;
        UILabel * label = [[UILabel alloc] initWithFrame: CGRectMake(px+3, py, textSize.width, textSize.height)];
        label.text = [NSString stringWithFormat:@"%C",[self.imageCode characterAtIndex:i]];
        label.font = [UIFont systemFontOfSize:20];
        [label setTextColor:[self backgroundColorWithAlpah:0.8]];
        if (self.isRotation) {
            double r = (double)arc4random() / ARC4RAND_MAX * 2 - 1.0f;//随机-1到1
            if (r>0.3) {
                r=0.3;
            }else if(r<-0.3){
                r=-0.3;
            }
            label.transform = CGAffineTransformMakeRotation(r);
        }
        
        [_bgView addSubview:label];
    }
    
    
    ////加入图片冗余项
    for (int i = 0; i<10; i++) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGFloat pX = arc4random() % (int)CGRectGetWidth(self.frame);
        CGFloat pY = arc4random() % (int)CGRectGetHeight(self.frame);
        [path moveToPoint:CGPointMake(pX, pY)];
        CGFloat ptX = arc4random() % (int)CGRectGetWidth(self.frame);
        CGFloat ptY = arc4random() % (int)CGRectGetHeight(self.frame);
        [path addLineToPoint:CGPointMake(ptX, ptY)];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.strokeColor = [[self backgroundColorWithAlpah:0.2] CGColor];//layer的边框色
        layer.lineWidth = 1.0f;
        layer.strokeEnd = 1;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.path = path.CGPath;
        [_bgView.layer addSublayer:layer];
    }
}


- (UIColor *)backgroundColorWithAlpah:(CGFloat)alpha{
    float red = arc4random() % 100 / 100.0;
    float green = arc4random() % 100 / 100.0;
    float blue = arc4random() % 100 / 100.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return color;
}

/**
 刷新验证码
 */
- (void)freshCodeContent{
    [self setCodeStr];
    [self setImageCodeView];
}
@end
