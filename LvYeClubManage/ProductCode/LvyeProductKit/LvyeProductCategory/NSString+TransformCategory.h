//
//  NSString+TransformCategory.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/22.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TransformCategory)


/**
 将中文转为中文音标字符

 @return 转译好的音标字符串
 */
- (NSString *)transformLetterWithChinese;
@end
