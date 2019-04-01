//
//  WebAPIResponse.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/10.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "WebAPIResponse.h"



@implementation WebAPIResponse


+ (id)responseWithCode:(WebAPIResponseCode)code description:(NSString *)codeDescription
{
    id response = [[self alloc] init];
    [(WebAPIResponse*)response setCode:code];
    [(WebAPIResponse*)response setCodeDescription:codeDescription];
    return response;
}


+(id)responseWithCode:(WebAPIResponseCode)code{
    return [[self class] responseWithCode:code description:nil];
}

+(id)successedResponse{
    return [[self class] responseWithCode:WebAPIResponseCodeSuccess];
}

+(id)invalidArgumentsResonse{
    return [[self class] responseWithCode:WebAPIResponseCodeParamError
                              description:@"请求参数错误"];
}

+ (id) responseWithImageURL:(NSString *)url{
    WebAPIResponse *response = [[WebAPIResponse alloc]init];
    
    if (IsStringEmptyOrNull(url)) {
        [response setCode:WebAPIResponseCodeFailed];
        [response setCodeDescription:@"服务器返回数据异常"];
    }else{
        [response setCode:WebAPIResponseCodeSuccess];
        NSDictionary *urlDic = @{@"url":url,};
        [response setResponseObject:urlDic];
    }
    
    return response;
}

+(id)responseWithUnserializedJSONDic:(id)returnData{
    
    
    WebAPIResponse *response = [[WebAPIResponse alloc]init];
    
    if(returnData == nil || ![returnData isKindOfClass:[NSDictionary class]]){
        [response setCode:WebAPIResponseCodeFailed];
        [response setCodeDescription:@"服务器返回数据异常"];
    }else{
        [response setCode:[ObjForKeyInUnserializedJSONDic((NSDictionary* )returnData, kCodeNameOnServer) integerValue]];
        [response setCodeDescription:ObjForKeyInUnserializedJSONDic((NSDictionary* )returnData, kCodeDescriptionNameOnServer)];
        [response setResponseObject:(NSDictionary* )returnData];
    }
    
    return response;
}

@end
