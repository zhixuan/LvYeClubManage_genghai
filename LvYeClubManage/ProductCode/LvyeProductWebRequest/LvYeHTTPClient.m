//
//  LvYeHTTPClient.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/10.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvYeHTTPClient.h"

@implementation LvYeHTTPClient

 static LvYeHTTPClient *shareHttpClient = nil;

+ (LvYeHTTPClient *)shareLvYeHTTPClient{
   
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        shareHttpClient = [[LvYeHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:KEY_LVYE_API_URL]];
    });
    
    return shareHttpClient;
}

- (id)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if (self == nil)
        return nil;
    
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    //只接受JSON格式的返回数据, 向服务器传消息也用JSON数据
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    [self setDefaultHeader:@"Content-Type" value:@"application/json"];
    
    
    //如果使用JSON格式请求RESTFUL API,打开此选项
    //[self setParameterEncoding:AFJSONParameterEncoding];
    
    return self;
}


#pragma mark -
#pragma mark -  AFHTTP GET 请求操作
- (AFHTTPRequestOperation *)getPath:(NSString *)path
                         parameters:(NSDictionary *)parameters
                         completion:(WebAPIResponstComlitionBlock)completionBlock{
    NSMutableDictionary *mutableParameters = [[NSMutableDictionary alloc]init];
    if (parameters != nil) {
        [mutableParameters setDictionary:parameters];
    }
    NSLog(@"\n\nGET is %@\nparam is %@\n",path,mutableParameters);
//    
    NSURLRequest *request = [self requestWithMethod:@"GET" path:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                                         parameters:mutableParameters];

    AFHTTPRequestOperation *operation =
    [self HTTPRequestOperationWithRequest:request
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
                                      if (httpResponse.statusCode == 200) {
                                          if (completionBlock) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  completionBlock([WebAPIResponse responseWithUnserializedJSONDic:responseObject]);
                                              });
                                          }
                                      } else {
                                          if (completionBlock) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  completionBlock([WebAPIResponse responseWithCode:WebAPIResponseCodeNetError]);
                                              });
                                          }
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      if (completionBlock) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              completionBlock([WebAPIResponse responseWithCode:WebAPIResponseCodeNetError]);
                                          });
                                      }
                                  }];
    [self enqueueHTTPRequestOperation:operation];
    return operation;
}

#pragma mark -
#pragma mark -  AFHTTP POST 请求操作
- (AFHTTPRequestOperation *)postPath:(NSString *)path
                          parameters:(NSDictionary *)parameters
                          completion:(WebAPIResponstComlitionBlock)completionBlock{
    NSLog(@"\n\n POST 请求is %@\nparam is %@\n",path,parameters);

    
      NSURLRequest *request = [self requestWithMethod:@"POST"
                                                 path:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
                                          parameters:parameters];
    
    AFHTTPRequestOperation *operation =
    [self HTTPRequestOperationWithRequest:request
                                  success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                      NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)operation.response;
                                      
                                      
                                      if (httpResponse.statusCode == 200) {
                                          if (completionBlock) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  completionBlock([WebAPIResponse responseWithUnserializedJSONDic:responseObject]
                                                                  );
                                              });
                                          }
                                      } else {
                                          
                                          if (completionBlock) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  completionBlock([WebAPIResponse responseWithCode:WebAPIResponseCodeNetError]);
                                              });
                                          }
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      NSLog(@"Received: %@", [error localizedDescription]);
                                      if (completionBlock) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              completionBlock([WebAPIResponse responseWithCode:WebAPIResponseCodeNetError]);
                                              //                                              NSLog(@"error=%@",error);
                                          });
                                      }
                                  }];
    [self enqueueHTTPRequestOperation:operation];
    return operation;

}
@end
