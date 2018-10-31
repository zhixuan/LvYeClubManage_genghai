//
//  NSString+TransformCategory.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/22.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "NSString+TransformCategory.h"

@implementation NSString (TransformCategory)


- (NSString *)transformLetterWithChinese{
    NSMutableString *pinyin = [self mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    
    ///返回大写
//    return [pinyin uppercaseString];

    ///返回小写 去除汉字音标之间的空格
    return [pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
    
}
@end
