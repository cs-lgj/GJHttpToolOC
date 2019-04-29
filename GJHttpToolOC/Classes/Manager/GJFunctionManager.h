//
//  GJFunctionManager.h
//  LGJ
//
//  Created by LGJ on 2018/3/17.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kGJIphone4Height 480.0
#define kGJIphone5Height 568.0
#define kGJIphone6Height 667.0
#define kGJIphone6pHeight 736.0
#define kGJIphoneX    812.0

// 日期字符串分隔符
typedef NS_ENUM(NSInteger, DateFormatterSeparatorType) {
    
    DateFormatterYMD= 0,        // 2014-12-32
    DateFormatterYMDHM,         // 2014-12-32 11:30
    DateFormatterMD,            // 12-32
    DateFormatterMDHM,          // 12-32 11:30
    DateFormatterHM             // 11:30
};

UIFont *AdapFont(UIFont *font);
CGSize boundsAdap(CGFloat width,CGFloat height);

#pragma mark - 打电话
void callAPhone(NSString *telephoneNum);

#pragma mark - 日期相关
NSString *GetHHMMtimeStr(NSInteger timeinteger,DateFormatterSeparatorType formateType);

/*
 * 获取当前时间String
 */
NSString *GetCurrentTime(void);

/*
 * 获取时间String
 */
NSString *GetDateNStringWith(NSDate *date);


#pragma mark - 图片相关
/*
 颜色获取图片
 */
UIImage * CreatImageWithColor(UIColor *color);

#pragma mark - 数据操作相关
/*
 获取应用程序版本信息 1.1.0
 */
NSString *GetAppVersionCodeInfo(void);

/*
 获取设备信息，拼接成一个字符串 eg: iPhone_iOS_4.0
 */
NSString *GetCurrentDeviceBaseInfo(void);

/*
 * 判断容器是否是空,是否是零(支持NSArray,NSDictionary,NSString,NSNumber)
 */
BOOL JudgeContainerCountIsNull(id object);

/*获取文字大小长度*/
CGRect getStringContentSize(UIFont *font , CGSize size , NSString *string);


#pragma mark - 试图相关
UIImage * ScaleImageSize(UIImage * image,CGSize targetSize);

UIImage * drawImage(UIImage * originImage,CGSize rectSize,CGFloat roundedRadius);
#pragma mark - 提示信息相关(MBHUD)
void ShowProgressHUD(BOOL isShow,id toView);
void ShowProgressHUDWithText(BOOL isShow,id toView,NSString *text);

/*!
 *  @brief  显示操作成功的提示
 *
 *  @param message 提示信息
 *  @param toView  应用到的地方
 */
void ShowSucceedAlertHUD(NSString *message,id toView);
/*!
 *  @brief  显示
 *
 *  @param message 提示信息
 *  @param toView  应用到的地方
 */
void ShowFailedAlertHUD(NSString *message, id toView);

/**
 *  显示提示信息（自动消失）
 *
 *  @param message 提示内容
 *  @param toView  呈现的视图
 */
void ShowWaringAlertHUD(NSString *message, id toView);

@interface GJFunctionManager : NSObject

+ (UIViewController *)CurrentTopViewcontroller;

+ (void)setStatusStyleDefault;
+ (void)setStatusStyleLightContent;

@end
