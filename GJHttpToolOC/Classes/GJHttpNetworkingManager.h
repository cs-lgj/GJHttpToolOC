//
//  GJHttpNetworkingManager.h
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJHttpServerBase.h"

#define HTTP_SESSION_ID  @"com.hsrdid"

typedef enum {
    kHttpCondition_Develop = 0, // 测试
    kHttpCondition_BeatDistribution, // 准生产
    kHttpCondition_Distribution
}kHttpConditionType;

@interface GJHttpNetworkingManager : NSObject

@property (strong, nonatomic, readonly) NSString *socketBaseUrl; ///< socket 地址
@property (strong, nonatomic, readonly) NSString *httpBaseUrl; ///< 服务器接口地址
@property (strong, nonatomic, readonly) NSString *h5BaseUrl; ///< H5RUL
@property (strong, nonatomic, readonly) NSString *h5NewUrl; ///< H5 官网地址

@property (strong, nonatomic, readonly) NSString *imgBaseUrl;
@property (assign, nonatomic) kHttpConditionType httpConditionType; ///< 请求环境

+ (GJHttpNetworkingManager *)sharedInstance;


/**
 *  默认Form post请求
 *
 *  @param pathUrl         接口地址
 *  @param parameter       接口参数 (请求格式Form表单 格式)
 *  @param succeedCallback 请求成功回调
 *  @param failedCallback  请求失败回调
 *
 *  @return 网络操作
 */
- (NSURLSessionDataTask *)requestFormTypePostWithPathUrl:(NSString *)pathUrl andParaDic:(NSDictionary *)parameter  andSucceedCallback:(HTTPTaskSuccessBlock)succeedCallback
                                       andFailedCallback:(HTTPTaskFailureBlock)failedCallback;

- (NSURLSessionDataTask *)requestAllDataPostWithPathUrl:(NSString *)pathUrl andParaDic:(NSDictionary *)parameter  andSucceedCallback:(HTTPTaskSuccessBlock)succeedCallback
                                       andFailedCallback:(HTTPTaskFailureBlock)failedCallback;


/**
 *  Json post请求
 *
 *  @param pathUrl         接口地址
 *  @param parameter       接口参数 (请求格式JSON 格式)
 *  @param succeedCallback 请求成功回调
 *  @param failedCallback  请求失败回调
 *
 *  @return 网络操作
 */
- (NSURLSessionDataTask *)requestJsonPostWithPathUrl:(NSString *)pathUrl andParaDic:(NSDictionary *)parameter  andSucceedCallback:(HTTPTaskSuccessBlock)succeedCallback
                                   andFailedCallback:(HTTPTaskFailureBlock)failedCallback;



/**
 *   发送Get请求
 *
 *  @param pathUrl         接口地址
 *  @param parameter       接口参数 (统一是JSON 格式)
 *  @param succeedCallback 请求成功回调
 *  @param failedCallback  请求失败回调
 *
 *  @return 网络操作
 */
- (NSURLSessionDataTask *)requestGetWithPathUrl:(NSString *)pathUrl andParaDic:(NSDictionary *)parameter  andSucceedCallback:(HTTPTaskSuccessBlock)succeedCallback
                              andFailedCallback:(HTTPTaskFailureBlock)failedCallback;



/**
 *   发送Get RESTful风格请求
 *
 *  @param pathUrl         接口地址
 *  @param parameter       RESTful拼接参数 数组（为了方便顺序）
 *  @param succeedCallback 请求成功回调
 *  @param failedCallback  请求失败回调
 *
 *  @return 网络操作
 */
- (NSURLSessionDataTask *)requestRESTfulGetWithPathUrl:(NSString *)pathUrl andParaDic:(NSArray *)parameter  andSucceedCallback:(HTTPTaskSuccessBlock)succeedCallback
                                     andFailedCallback:(HTTPTaskFailureBlock)failedCallback;


/**
  发送Update 上传图片请求
 
 @param data 图片二进制
 @param progeress 进度回调
 @param succeedCallback 请求成功
 @param failedCallback 请求失败
 */
- (void)reqeustLoadImageData:(NSArray <NSData *> *)data
                         url:(NSString *)url
                      params:(NSDictionary *)params
                 andProgress:(HTTPTaskProgress)progeress
          andSucceedCallback:(HTTPTaskSuccessBlock)succeedCallback
           andFailedCallback:(HTTPTaskFailureBlock)failedCallback;




/**
 Get 请求全地址
 @param url 请求的全地址
 @param succeedCallback 成功
 @param failedCallback 失败
 */
- (NSURLSessionDataTask *)reqeustGetAllPathURL:(NSString *)url parameter:(NSDictionary *)parameter andSucceedCallback:(HTTPTaskSuccessBlock)succeedCallback
                             andFailedCallback:(HTTPTaskFailureBlock)failedCallback;

@end
