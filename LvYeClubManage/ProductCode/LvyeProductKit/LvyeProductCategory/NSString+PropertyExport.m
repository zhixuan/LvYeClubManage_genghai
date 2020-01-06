//
//  NSString+PropertyExport.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/4/18.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "NSString+PropertyExport.h"
#import <objc/message.h>

@implementation NSObject (PropertyExport)

- (NSString *)toPropertyExportString{
    
    id tfClass = objc_getClass("userClass");
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(tfClass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        fprintf(stdout, "%s %s\n", property_getName(property), property_getAttributes(property));
    }
    return @"";
}
@end
