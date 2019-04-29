//
//  GJHttpServerBase.m
//  LGJ
//
//  Created by LGJ on 2018/3/29.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "GJHttpServerBase.h"

const NSTimeInterval HttpServerManage_RequestTimeoutInterval  = 25; //请求超时时间限制

@implementation GJHttpServerBase

+ (NSURLSessionDataTask *)sendBaseRequestWithBaseString:(NSString *)baseString
                                             pathString:(NSString *)pathString
                                         addHeaderField:(NSDictionary *)heards
                                             methodType:(HttpRequestMethodType)methodType
                                              paramType:(HttpRequestParameterType)paramType
                                                 params:(id)params
                                                success:(HTTPTaskSuccessBlock)success
                                                failure:(HTTPTaskFailureBlock)failure {
    
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.HTTPShouldSetCookies = YES;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript",@"text/plain", nil];
    switch (paramType) {
        case kHttpRequestParameterType_KeyValue:
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        case kHttpRequestParameterType_JSON:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        default:
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
    }
    
    NSString *method;
    switch (methodType) {
        case kHttpRequestMethodType_Get:
            method = @"GET";
            break;
        case kHttpRequestMethodType_Post:
            method = @"POST";
            break;
            
        default:
            break;
    }
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:method URLString:[NSString stringWithFormat:@"%@%@",baseString,pathString] parameters:params error:&serializationError];
    request.timeoutInterval = HttpServerManage_RequestTimeoutInterval;
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(manager.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }
    
    __block NSURLSessionDataTask *dataTask = nil;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        // To do background task
        // 配置heard参数
        for (NSString *key in heards.allKeys) {
            NSString *value = heards[key] ;
            [request setValue:value forHTTPHeaderField:key];
        }
        
        dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            if (error) {
                if (failure) {
                    NSString *msg = responseObject[@"message"];
                    NSError *newError = [NSError errorWithDomain:@"com.lgj.error" code:error.code userInfo:@{NSLocalizedDescriptionKey:msg?msg:@"网络开小差咯～"}];
                    failure(response,newError);
                }
            }else {
                if (success) {
#ifdef DEBUG
                    if (!JudgeContainerCountIsNull(responseObject)) {
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
                        NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                        NSLog(@"%@",jsonStr);
                        
                    }
#endif
                    success(response,responseObject);
                }
            }
        }];
        [dataTask resume];
    });
    
    return dataTask;
}

+ (NSURLSessionDataTask *)sendBaseLoadImageWithBaseString:(NSString *)baseString
                                               pathString:(NSString *)pathString
                                           addHeaderField:(NSDictionary *)heards
                                                paramType:(HttpRequestParameterType)paramType
                                                   params:(id)params
                                              dataFormate:(NSArray<NSData *>*)dataImages
                                                 progress:(HTTPTaskProgress)progress
                                                  success:(HTTPTaskSuccessBlock)success
                                                  failure:(HTTPTaskFailureBlock)failure {
    
    NSString *urlStr = [NSString stringWithFormat:@"%@%@",baseString,pathString];
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:urlStr parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSData *data in dataImages) {
            [formData appendPartWithFileData:data name:@"file" fileName:@"filename.jpg" mimeType:@"image/jpg"];
        }
    } error:nil];
    
    for (NSString *key in heards.allKeys) {
        [request setValue:heards[key] forHTTPHeaderField:key];
    }
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json",@"text/json",@"text/javascript",@"text/html",nil,nil];
    switch (paramType) {
        case kHttpRequestParameterType_KeyValue:
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        case kHttpRequestParameterType_JSON:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
            break;
        default:
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
    }
    
    NSURLSessionUploadTask *uploadTask;
    uploadTask = [manager
                  uploadTaskWithStreamedRequest:request
                  progress:^(NSProgress * _Nonnull uploadProgress) {
                      if (progress) progress(uploadProgress);
                  }
                  completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                      if (error) {
                          if (failure) failure(response,error);
                      } else {
                          if(success) success(response,responseObject);
                      }
                  }];
    [uploadTask resume];
    return uploadTask;
}

@end
