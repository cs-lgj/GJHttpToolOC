//
//  NSString+GJCategory.h
//  LGJ
//
//  Created by LGJ on 2018/3/29.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GJCategory)

/**************************字符加密相关******************************/
//16位MD5加密方式
+ (NSString *)getMd5_16Bit_String:(NSString *)srcString;
//32位MD5加密方式
+ (NSString *)getMd5_32Bit_String:(NSString *)srcString;
//sha1加密方式
+ (NSString *)getSha1String:(NSString *)srcString;
//sha256加密方式
+ (NSString *)getSha256String:(NSString *)srcString;
//sha384加密方式
+ (NSString *)getSha384String:(NSString *)srcString;
//sha512加密方式
+ (NSString*) getSha512String:(NSString*)srcString;


/*****检查格式****/
- (BOOL)isQQ;
- (BOOL)isValidMobileNumber;
- (BOOL)isValidMoneyCharge;
- (BOOL)isValidFixedPhone;
- (BOOL)isValidPassword;
- (BOOL)isValidEmail;
- (BOOL)isIPAddress;
- (BOOL)isValidNickName;

// 清空字符串中的空白字符
- (NSString *)trimString;

// 字符串大小
- (CGSize)stringContetenSizeWithFount:(UIFont *)font andSize:(CGSize)size;

// TextFieldText
- (NSString *)changeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

// 字符串转json 数据
- (id)stringTrasformJSONObjectData;

@end
