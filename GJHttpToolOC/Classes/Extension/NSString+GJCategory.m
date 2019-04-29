//
//  NSString+GJCategory.m
//  LGJ
//
//  Created by LGJ on 2018/3/29.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "NSString+GJCategory.h"
#import <CommonCrypto/CommonDigest.h>
#import <objc/message.h>
#import <objc/runtime.h>

#define kRegMobilePredicate @"^1+[235678]+\\d{9}" // 手机号码
#define kRegFixedPhone @"(\\(\\d{3,4}\\)|\\d{3,4}-|\\s)?\\d{6,14}" //固话测
#define kRegPasswordPredicate @"^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{6,16}$" // 字母数字或字符下划线 6-16位
#define kRegNickNamePredicate @"^[a-zA-Z0-9_\u4e00-\u9fa5]{2,16}$" // 字母数字或下划线或中文 2-16位
#define kRegMoneyPredicatecharge @"^(([1-9]{1}\\d*)|([0]{1}))(\\.(\\d){0,2})?$"// 金额，小数点后两位

#define kRegEmailPredicate @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

#define kRegIpAdressPredicate @"^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$"

@implementation NSString (GJCategory)

#pragma mark -数据加密相关
//16位MD5加密方式
+ (NSString *)getMd5_16Bit_String:(NSString *)srcString{
    //提取32位MD5散列的中间16位
    NSString *md5_32Bit_String=[NSString getMd5_32Bit_String:srcString];
    NSString *result = [[md5_32Bit_String substringToIndex:24] substringFromIndex:8];//即9～25位
    
    return result;
}

//32位MD5加密方式
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString{
    const char *cStr = [srcString UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest );
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    
    return result;
}

//sha1加密方式
+ (NSString *)getSha1String:(NSString *)srcString{
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

//sha256加密方式
+ (NSString *)getSha256String:(NSString *)srcString {
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

//sha384加密方式
+ (NSString *)getSha384String:(NSString *)srcString {
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[CC_SHA384_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA384_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA384_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}

//sha512加密方式
+ (NSString*) getSha512String:(NSString*)srcString {
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [result appendFormat:@"%02x", digest[i]];
    return result;
}

#pragma mark 实例方法
/*****检查格式****/
- (BOOL)match:(NSString *)pattern
{
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}

- (BOOL)isQQ
{
    return [self match:@"^[1-9]\\d{4,10}$"];
}

- (BOOL)isValidNickName {
    return [self match:kRegNickNamePredicate];
}
- (BOOL)isValidMobileNumber {
    return [self match:kRegMobilePredicate];
}
- (BOOL)isValidMoneyCharge {
    return [self match:kRegMoneyPredicatecharge];
}
- (BOOL)isValidFixedPhone {
    return [self match:kRegFixedPhone];
}
- (BOOL)isValidPassword {
    return [self match:kRegPasswordPredicate];
}

- (BOOL)isValidEmail {
    return [self match:kRegEmailPredicate];
}

- (BOOL)isIPAddress
{
    return [self match:kRegIpAdressPredicate];
}

// 清除空串
- (NSString *)trimString
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

// 字符串大小
- (CGSize)stringContetenSizeWithFount:(UIFont *)font andSize:(CGSize)size
{
    CGSize endSize;
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSDictionary *attributes = @{NSFontAttributeName:font};
    endSize  =  [self boundingRectWithSize:size options:options attributes:attributes context:nil].size;
    CGSize returnSize = CGSizeMake(ceilf(endSize.width), ceilf(endSize.height));
    return returnSize;
}

// TextFiled代理
- (NSString *)changeCharactersInRange:(NSRange)range replacementString:(NSString *)string   {
    NSMutableString * futureString = [NSMutableString stringWithString:self];
    if (range.length == 0) {
        [futureString insertString:string atIndex:range.location];
    } else {
        [futureString deleteCharactersInRange:range];
    }
    
    return futureString;
}

- (id)stringTrasformJSONObjectData {
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    return  [NSJSONSerialization JSONObjectWithData:jsonData
             
                                            options:NSJSONReadingMutableContainers
                                              error:&err];
}

@end
