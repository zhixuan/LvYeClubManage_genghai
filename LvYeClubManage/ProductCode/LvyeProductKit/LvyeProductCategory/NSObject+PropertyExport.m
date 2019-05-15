//
//  NSString+PropertyExport.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/4/18.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "NSObject+PropertyExport.h"
#import <objc/message.h>

@implementation NSObject (PropertyExport)

- (NSString *)toPropertyExportString{
#ifdef DEBUG
    const char *clasName = object_getClassName(self);
     Class clas = NSClassFromString([NSString stringWithCString:clasName encoding:NSUTF8StringEncoding]);
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(clas, &outCount);

    NSMutableString *str = [NSMutableString stringWithFormat:@"\nClassName : 【%@】\n%@",[NSString stringWithCString:clasName encoding:NSUTF8StringEncoding],@""];
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
//        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
        if(propertyValue) [str appendFormat:@"%@", [NSString stringWithFormat:@" --- %@ = %@\n",propertyName,propertyValue]];
    }
    free(properties);

#else
    NSString *str = [NSString stringWithFormat:@"%@",@""];
#endif
    
    
    return str;
}
@end
