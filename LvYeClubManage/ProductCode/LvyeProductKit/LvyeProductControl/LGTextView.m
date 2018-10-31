//
//  LGTextView.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/24.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "LGTextView.h"

@interface LGTextView()
/*!
 * @property
 * @brief 是否显示占位符内容
 */
@property (nonatomic , assign)      BOOL        shouldDrawPlaceholder;
@end

@implementation LGTextView

- (void)setText:(NSString *)text{
    
    [super setText:text];
    [self drawPlaceholder];
    return;
}
- (void)setPlaceholder:(NSString *)placeholder {
    
    
    
    if (![placeholder isEqual:_placeholder]) {
        _placeholder = placeholder;
        [self drawPlaceholder];
    }
    return;
}

#pragma mark - 父类方法
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self configureBase];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureBase];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if (self.shouldDrawPlaceholder) {
        [_placeholderTextColor set];
        UIFont *font = self.font;
        [_placeholder drawInRect:CGRectMake(8.0f, 6.0f, self.frame.size.width - 16.0f,
                                            self.frame.size.height - 16.0f) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:self.placeholderTextColor}];
    }
    return;
}

- (void)configureBase {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textChanged:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:self];
    
    self.placeholderTextColor = [UIColor colorWithWhite:0.702f alpha:1.0f];
    self.shouldDrawPlaceholder = NO;
    return;
}

- (void)drawPlaceholder {
    BOOL prev = self.shouldDrawPlaceholder;
    self.shouldDrawPlaceholder = self.placeholder && self.placeholderTextColor && self.text.length == 0;
    
    if (prev != self.shouldDrawPlaceholder) {
        [self setNeedsDisplay];
    }
    return;
}

- (void)textChanged:(NSNotification *)notification {
    [self drawPlaceholder];
    return;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
    return;
}




@end
