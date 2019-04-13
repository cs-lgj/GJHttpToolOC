//
//  GJHttpNetworkingManager.m
//  GaoYuanFeng
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJHttpNetworkingManager.h"

static NSString * GJErrorDomain = @"com.hsrd.app";

@implementation GJHttpNetworkingManager

+ (GJHttpNetworkingManager *)sharedInstance {
    static GJHttpNetworkingManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[GJHttpNetworkingManager alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _httpConditionType = kHttpCondition_Develop;
    }
    return self;
}

#pragma mark -  Request Fuction
// POST RequestType Form Key_Value
- (NSURLSessionDataTask *)requestFormTypePostWithPathUrl:(NSString *)pathUrl andParaDic:(NSDictionary *)parameter  andSucceedCallback:(HTTPTaskSuccessBlock)succeedCallback
                                       andFailedCallback:(HTTPTaskFailureBlock)failedCallback {
    return  [self requestPostType:kHttpRequestParameterType_KeyValue PathUrl:pathUrl andParaDic:parameter andSucceedCallback:succeedCallback andFailedCallback:failedCallback];
    
}

- (NSURLSessionDataTask *)requestAllDataPostWithPathUrl:(NSString *)pathUrl andParaDic:(NSDictionary *)parameter andSucceedCallback:(HTTPTaskSuccessBlock)succeedCallback andFailedCallback:(HTTPTaskFailureBlock)failedCallback {
    return  [self requestAllDataPostType:kHttpRequestParameterType_KeyValue PathUrl:pathUrl andParaDic:parameter andSucceedCallback:succeedCallback andFailedCallback:failedCallback];
}


// POST RequestType JSON
- (NSURLSessionDataTask *)requestJsonPostWithPathUrl:(NSString *)pathUrl andParaDic:(NSDictionary *)parameter  andSucceedCallback:(HTTPTaskSuccessBlock)succeedCallback
                                   andFailedCallback:(HTTPTaskFailureBlock)failedCallback {
    
    return   [self requestPostType:kHttpRequestParameterType_JSON PathUrl:pathUrl andParaDic:parameter andSucceedCallback:succeedCallback andFailedCallback:failedCallback];
}

// POST RequestType
- (NSURLSessionDataTask *)requestPostType:(HttpRequestParameterType)requestType PathUrl:(NSString *)pathUrl andParaDic:(NSDictionary *)parameter  andSucceedCallback:(HTTPTaskSuccessBlock)succeedCallback
                        andFailedCallback:(HTTPTaskFailureBlock)failedCallback {
    
    NSDictionary *heardDic = [self getCommonHeard];
    NSDictionary *fullParameter = [self configFullParameter:parameter];
    
    return  [GJHttpServerBase sendBaseRequestWithBaseString:self.httpBaseUrl pathString:pathUrl addHeaderField:heardDic methodType:kHttpRequestMethodType_Post paramType:requestType params:fullParameter success:^(NSURLResponse *urlResponse, id response) {
        if ([self handResponseIsSuccess:response]) {
            BLOCK_SAFE(succeedCallback)(urlResponse,response[@"data"]);
        }else {
            NSError *error = [self creatCustomError:response];
            BLOCK_SAFE(failedCallback)(urlResponse,error);
        }
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        BLOCK_SAFE(failedCallback)(urlResponse,error);
    }];
}

- (NSURLSessionDataTask *)requestAllDataPostType:(HttpRequestParameterType)requestType PathUrl:(NSString *)pathUrl andParaDic:(NSDictionary *)parameter  andSucceedCallback:(HTTPTaskSuccessBlock)succeedCallback
                        andFailedCallback:(HTTPTaskFailureBlock)failedCallback {
    
    NSDictionary *heardDic = [self getCommonHeard];
    NSDictionary *fullParameter = [self configFullParameter:parameter];
    
    return  [GJHttpServerBase sendBaseRequestWithBaseString:self.httpBaseUrl pathString:pathUrl addHeaderField:heardDic methodType:kHttpRequestMethodType_Post paramType:requestType params:fullParameter success:^(NSURLResponse *urlResponse, id response) {
        if ([self handResponseIsSuccess:response]) {
            BLOCK_SAFE(succeedCallback)(urlResponse,response);
        }else {
            NSError *error = [self creatCustomError:response];
            BLOCK_SAFE(failedCallback)(urlResponse,error);
        }
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        BLOCK_SAFE(failedCallback)(urlResponse,error);
    }];
}


- (NSURLSessionDataTask *)requestGetWithPathUrl:(NSString *)pathUrl andParaDic:(NSDictionary *)parameter  andSucceedCallback:(HTTPTaskSuccessBlock)succeedCallback
                              andFailedCallback:(HTTPTaskFailureBlock)failedCallback {
    //
    NSDictionary *heardDic = [self getCommonHeard];
    NSDictionary *fullParameter = [self configFullParameter:parameter];
    return  [GJHttpServerBase sendBaseRequestWithBaseString:self.httpBaseUrl pathString:pathUrl addHeaderField:heardDic methodType:kHttpRequestMethodType_Get paramType:kHttpRequestParameterType_KeyValue params:fullParameter success:^(NSURLResponse *urlResponse, id response) {
        if ([self handResponseIsSuccess:response]) {
            BLOCK_SAFE(succeedCallback)(urlResponse,response[@"data"]);
        }else {
            NSError *error = [self creatCustomError:response];
            BLOCK_SAFE(failedCallback)(urlResponse,error);
        }
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        BLOCK_SAFE(failedCallback)(urlResponse,error);
    }];
    
}

- (NSURLSessionDataTask *)requestRESTfulGetWithPathUrl:(NSString *)pathUrl andParaDic:(NSArray *)parameter  andSucceedCallback:(HTTPTaskSuccessBlock)succeedCallback
                                     andFailedCallback:(HTTPTaskFailureBlock)failedCallback {
    NSDictionary *heardDic = [self getCommonHeard];
    NSMutableString *parameterUrl = [[NSMutableString alloc] initWithString:pathUrl];
    for (NSString *value in parameter) {
        [parameterUrl appendFormat:@"/%@",value];
    }
    return  [GJHttpServerBase sendBaseRequestWithBaseString:self.httpBaseUrl pathString:parameterUrl addHeaderField:heardDic methodType:kHttpRequestMethodType_Get paramType:kHttpRequestParameterType_KeyValue params:nil success:^(NSURLResponse *urlResponse, id response) {
        if ([self handResponseIsSuccess:response]) {
            BLOCK_SAFE(succeedCallback)(urlResponse,response[@"data"]);
        }else {
            NSError *error = [self creatCustomError:response];
            BLOCK_SAFE(failedCallback)(urlResponse,error);
        }
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        BLOCK_SAFE(failedCallback)(urlResponse,error);
    }];
}

- (void)reqeustLoadImageData:(NSArray <NSData *> *)data
                         url:(NSString *)url
                      params:(NSDictionary *)params
                 andProgress:(HTTPTaskProgress)progeress
          andSucceedCallback:(HTTPTaskSuccessBlock)succeedCallback
           andFailedCallback:(HTTPTaskFailureBlock)failedCallback {
    
    NSDictionary *fullParameter = [self configFullParameter:params];
    
    [GJHttpServerBase sendBaseLoadImageWithBaseString:self.httpBaseUrl pathString:url addHeaderField:[self getCommonHeard] paramType:kHttpRequestParameterType_KeyValue params:fullParameter dataFormate:data progress:^(NSProgress *uploadProgress) {
        BLOCK_SAFE(progeress)(uploadProgress);
    } success:^(NSURLResponse *urlResponse, id response) {
        if ([self handResponseIsSuccess:response]) {
            BLOCK_SAFE(succeedCallback)(urlResponse,response);
        }else {
            NSError *error = [self creatCustomError:response];
            BLOCK_SAFE(failedCallback)(urlResponse,error);
        }
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        BLOCK_SAFE(failedCallback)(urlResponse,error);
    }];
}

#pragma mark - request Config

- (NSDictionary *)getCommonHeard {
    
    NSMutableDictionary *dic = [@{} mutableCopy];
    NSMutableDictionary *cookieDic = [NSMutableDictionary dictionary];
    NSMutableString *cookieValue = [NSMutableString string];
    NSHTTPCookieStorage *cookieDefaul = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    // 获取默认Cookie 过滤Id key
    for (NSHTTPCookie *cookie in [cookieDefaul cookies]) {
        if (![cookie.name isEqualToString:@"id"]) {
            [cookieDic setObject:cookie.value forKey:cookie.name];
        }
    }
    // cookie 拼接
    for (NSString *key in cookieDic) {
        NSString *appendString = [NSString stringWithFormat:@"%@=%@;", key, [cookieDic valueForKey:key]];
        [cookieValue appendString:appendString];
    }
    //
//    NSString *tempSessionId = [TKUserDefaults loadObjectWithKey:];
//    if (!JudgeContainerCountIsNull(tempSessionId)) {
//        NSMutableString *appendString = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"id=%@",tempSessionId]];
//        [cookieValue appendString:appendString];
//    }
//    [dic setValue:@"1" forKey:@"channelType"]; //1 ios 2 android 3 pc
    
//    [dic setValue:GetAppVersionCodeInfo() forKey:@"appVersion"]; //1 ios 2 android 3 pc
    if (cookieValue.length > 1) {
        [dic setValue:cookieValue forKey:@"Cookie"];
    }
    
//    NSString *UDID = [HDeviceIdentifier deviceIdentifier];
    // 访客id
//    NSString *visiId = JudgeContainerCountIsNull([TKConfigureManager sharedManager].visiId) ? UDID : [TKConfigureManager sharedManager].visiId;
//    [dic setValue:visiId forKey:@"visitorId"];
//    [dic setValue:UDID forKey:@"X-Device-Id"];
    
    return dic;
    // 0-->PC  1-->iOS 2-->Andriod
    
}

- (NSDictionary *)configFullParameter:(NSDictionary *)parameter {
    NSMutableDictionary *fullParaDic = [[NSMutableDictionary alloc] initWithDictionary:parameter];
    // appid
    [fullParaDic addEntriesFromDictionary:@{@"appid":@"com.hsrd.highlandwind"}];
    return fullParaDic;
}

- (NSURLSessionDataTask *)reqeustGetAllPathURL:(NSString *)url parameter:(NSDictionary *)parameter andSucceedCallback:(HTTPTaskSuccessBlock)succeedCallback
                             andFailedCallback:(HTTPTaskFailureBlock)failedCallback {
    NSDictionary *heardDic = [self getCommonHeard];
    NSDictionary *fullParameter = [self configFullParameter:parameter];
    
    return [GJHttpServerBase sendBaseRequestWithBaseString:@"" pathString:url addHeaderField:heardDic methodType:kHttpRequestMethodType_Get paramType:kHttpRequestParameterType_KeyValue params:fullParameter success:^(NSURLResponse *urlResponse, id response) {
        if ([self handResponseIsSuccess:response]) {
            BLOCK_SAFE(succeedCallback)(urlResponse,response[@"data"]);
        }else {
            NSError *error = [self creatCustomError:response];
            BLOCK_SAFE(failedCallback)(urlResponse,error);
        }
    } failure:^(NSURLResponse *urlResponse, NSError *error) {
        BLOCK_SAFE(failedCallback)(urlResponse,error);
    }];
}


#pragma mark - private fuction
- (NSError *)creatCustomError:(id)response {
    NSString *errorStr = JudgeContainerCountIsNull2(response[@"message"]) ? @"网络开小差咯～" : response[@"message"];
    NSError *erro = [NSError errorWithDomain:GJErrorDomain code:[response[@"code"] integerValue] userInfo:@{NSLocalizedDescriptionKey:errorStr}];
    return  erro;
}

BOOL JudgeContainerCountIsNull2(id object)
{
    if (object)
    {
        if ([object isKindOfClass:[NSArray class]])
        {
            NSArray *array = (NSArray *)object;
            if ([array count] > 0)
            {
                return NO;
            }else
            {
                return YES;
            }
        }else if ([object isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dictionary = (NSDictionary *)object;
            if ([[dictionary allKeys] count] > 0)
            {
                return NO;
            }else
            {
                return YES;
            }
        }else if ([object isKindOfClass:[NSString class]])
        {
            NSString *temp = (NSString *)object;
            NSString *string =  [temp stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            if ([string length] > 0)
            {
                if ([string isEqualToString:@"(null)"] || [string isEqualToString:@"(NULL)"] || [string isEqualToString:@"null"] || [string isEqualToString:@"NULL"])
                {
                    return YES;
                }else
                {
                    return NO;
                }
            }
        }else if ([object isKindOfClass:[NSNumber class]])
        {
            NSNumber *number = (NSNumber *)object;
            if ([number isEqualToNumber:[NSNumber numberWithInt:0]])
            {
                return YES;
            }else
            {
                return NO;
            }
        }
    }
    return YES;
}

- (BOOL)handResponseIsSuccess:(id)response {
    NSDictionary *responseData = (NSDictionary *)response;
    NSInteger code = [responseData[@"code"] integerValue];
    if (code == 0) {
        return YES;
    }
    return NO;
}

#pragma mark - Getter
- (NSString *)httpBaseUrl
{
    if (_httpConditionType == kHttpCondition_Develop) {
        return @"http://192.168.1.105/gyfapp/public/";
    } else if(_httpConditionType == kHttpCondition_BeatDistribution) {
        return @"http://www.gyfapp.com/";
    }else if(_httpConditionType == kHttpCondition_Distribution){
        return @"http://www.qzylcn.com/";
    }
    return nil;
}

- (NSString *)h5BaseUrl {
    if (_httpConditionType == kHttpCondition_Develop) {
        return @"http://";
    } else if(_httpConditionType == kHttpCondition_BeatDistribution) {
        return @"http://";
    }else if(_httpConditionType == kHttpCondition_Distribution){
        return @"http://";
    }
    return nil;
}

- (NSString *)h5NewUrl {
    if (_httpConditionType == kHttpCondition_Develop) {
        return @"http://";
    } else if(_httpConditionType == kHttpCondition_BeatDistribution) {
        return @"http://";
    }else if(_httpConditionType == kHttpCondition_Distribution){
        return @"http://";
    }
    return nil;
}

- (NSString *)imgBaseUrl {
    if (_httpConditionType == kHttpCondition_Develop) {
        return @"http://";
    } else if(_httpConditionType == kHttpCondition_BeatDistribution) {
        return @"http://";
    }else if(_httpConditionType == kHttpCondition_Distribution){
        return @"http://";
    }
    return nil;
}

- (NSString *)socketBaseUrl {
    if (_httpConditionType == kHttpCondition_Develop) {
        return @"http://";
    } else if(_httpConditionType == kHttpCondition_BeatDistribution) {
        return @"http://";
    }else if(_httpConditionType == kHttpCondition_Distribution){
        return @"";
    }
    return nil;
    
}

@end
