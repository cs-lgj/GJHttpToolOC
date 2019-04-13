//
//  GJHttpServerBase.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

extern const NSTimeInterval HttpServerManage_RequestTimeoutInterval;

#define BLOCK_SAFE(block)           if(block)block

/*!
 请求方法类型
 */
typedef enum {
    kHttpRequestMethodType_None = 0,
    kHttpRequestMethodType_Get,
    kHttpRequestMethodType_Post,
    kHttpRequestMethodType_Put,
    kHttpRequestMethodType_Delete
}HttpRequestMethodType;

/*!
 请求参数类型
 */
typedef enum {
    kHttpRequestParameterType_None = 0,
    kHttpRequestParameterType_Path,
    kHttpRequestParameterType_KeyValue,
    kHttpRequestParameterType_JSON,
}HttpRequestParameterType;

typedef void (^HTTPTaskSuccessBlock)(NSURLResponse *urlResponse, id response);
typedef void (^HTTPTaskFailureBlock)(NSURLResponse *urlResponse, NSError *error);
typedef void (^HTTPTaskProgress)(NSProgress * uploadProgress);

typedef void (^HTTPTaskHandelBlock)(NSError *error,id response);

@interface GJHttpServerBase : NSObject

/**
 封装AFNetworking 底层请求接口
 
 @param baseString 请求的基地址
 @param pathString 接口路径
 @param heards HTTP Heard 字段
 @param methodType 请求方式 POST GET
 @param paramType 参数方式
 @param params 请求参数
 @param success 请求成功回调
 @param failure 失败回调
 @return 操作Task
 */
+ (NSURLSessionDataTask *)sendBaseRequestWithBaseString:(NSString *)baseString
                                             pathString:(NSString *)pathString
                                         addHeaderField:(NSDictionary *)heards
                                             methodType:(HttpRequestMethodType)methodType
                                              paramType:(HttpRequestParameterType)paramType
                                                 params:(id)params
                                                success:(HTTPTaskSuccessBlock)success
                                                failure:(HTTPTaskFailureBlock)failure;




/**
 请求图片
 
 @param baseString baseString
 @param pathString pathString
 @param heards 头部参数
 @param paramType 请求参数类型 json／formate
 @param params 参数
 @param dataImages 图片集合<data>
 @param progress 上传进度
 @param success success
 @param failure failure descriptionfailure
 @return return
 */
+ (NSURLSessionDataTask *)sendBaseLoadImageWithBaseString:(NSString *)baseString
                                               pathString:(NSString *)pathString
                                           addHeaderField:(NSDictionary *)heards
                                                paramType:(HttpRequestParameterType)paramType
                                                   params:(id)params
                                              dataFormate:(NSArray<NSData *>*)dataImages
                                                 progress:(HTTPTaskProgress)progress
                                                  success:(HTTPTaskSuccessBlock)success
                                                  failure:(HTTPTaskFailureBlock)failure;

@end
