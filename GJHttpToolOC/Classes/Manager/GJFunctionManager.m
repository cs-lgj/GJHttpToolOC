//
//  GJFunctionManager.m
//  LGJ
//
//  Created by LGJ on 2018/3/17.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "GJFunctionManager.h"
#import "MBProgressHUD+GJMBL.h"
#import "UIColor+Extension.h"
#import "UIView+GJToast.h"
#import "GJHttpConstant.h"

@implementation GJFunctionManager

+ (UIViewController *)CurrentTopViewcontroller {
    UIViewController *controller;
    controller = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (YES) {
        if (controller.presentedViewController) {
            controller = controller.presentedViewController;
        } else {
            if ([controller isKindOfClass:[UINavigationController class]]) {
                controller = [controller.childViewControllers lastObject];
            } else if ([controller isKindOfClass:[UITabBarController class]]) {
                UITabBarController *tabBarController = (UITabBarController *)controller;
                controller = tabBarController.selectedViewController;
            } else {
                if (controller.childViewControllers.count > 0) {
                    controller = [controller.childViewControllers lastObject];
                } else {
                    return controller;
                }
            }
        }
    }
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

+ (void)setStatusStyleDefault
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

+ (void)setStatusStyleLightContent
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

+ (UIImage *)sd_animatedGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            if (!image) {
                continue;
            }
            
            duration += [self sd_frameDurationAtIndex:i source:source];
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    return animatedImage;
}

+ (float)sd_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    // Many annoying ads specify a 0 duration to make an image flash as quickly as possible.
    // We follow Firefox's behavior and use a duration of 100 ms for any frames that specify
    // a duration of <= 10 ms. See <rdar://problem/7689300> and <http://webkit.org/b/36082>
    // for more information.
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}

@end

#pragma mark - 适配相关
CGFloat FontSizeScale(CGFloat size){
    if (SCREEN_H ==  kGJIphone4Height) {
        return size * 0.93;
    }
    else if (SCREEN_H == kGJIphone5Height) {
        return  size * 0.93;
    }
    else if (SCREEN_H == kGJIphone6Height) {
        return  size * 1.0;
    }
    else {
        return  size * 1.07;
    }
}


UIFont *AdapFont(UIFont *font) {
    
    return [UIFont fontWithName:font.fontName size:FontSizeScale(font.pointSize)];
}

UIFont *FontAdap(CGFloat size) {
    return [UIFont systemFontOfSize:FontSizeScale(size)];
}

void callAPhone(NSString *telephoneNum) {
    [[NSOperationQueue new] addOperationWithBlock:^{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", telephoneNum]]];
    }];
}

CGSize boundsAdap(CGFloat width,CGFloat height) {
    return CGSizeMake(AdaptatSize(width), AdaptatSize(height));
    
}

#pragma mark - 日期相关
NSString *GetHHMMtimeStr(NSInteger timeinteger,DateFormatterSeparatorType formateType){
    if (timeinteger < 0) {
        return @"";
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSString *formateStr;
    switch (formateType) {
        case DateFormatterYMD:
            formateStr = @"yyyy-MM-dd";
            break;
        case DateFormatterMD:
            formateStr = @"MM-dd";
            break;
        case DateFormatterYMDHM:
            formateStr = @"yyyy-MM-dd HH:mm";
            break;
        case DateFormatterMDHM:
            formateStr = @"MM-dd HH:mm";
            break;
        case DateFormatterHM:
            formateStr = @"HH:mm";
            break;
            
        default:
            break;
    }
    formatter.dateFormat = formateStr;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeinteger];
    NSString *dateString = [formatter stringFromDate:date];
    return dateString;
}

/*
 * 获取当前时间String
 */
NSString *GetCurrentTime(void)
{
    NSDate *nowUTC = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    NSString *dateString = [dateFormatter stringFromDate:nowUTC];
    
    return dateString;
}

NSString *GetDateNStringWith(NSDate *date)
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    return [dateFormat stringFromDate:date];
    
}

#pragma mark - 图片相关
UIImage * CreatImageWithColor(UIColor *color){
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark 数据操作相关
NSString *GetAppVersionCodeInfo(void)
{
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
    NSString* versionNum =(NSString *)[infoDict objectForKey:@"CFBundleShortVersionString"];  //版本号
    //    NSString*appName =[infoDict objectForKey:@"CFBundleDisplayName"];  //应用名字
    return versionNum;
}

NSString *GetCurrentDeviceBaseInfo(void)
{
    /*
     @"iPhone", @"iPod touch"
     @"iOS"
     @"4.0"
     */
    UIDevice *device = [UIDevice currentDevice];
    return [NSString stringWithFormat:@"%@_%@_%@",[device model],[device systemName],[device systemVersion]];
}

BOOL JudgeContainerCountIsNull(id object)
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

NSString *GetDocumentPath(NSString *name)
{
    NSArray *homePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [homePath objectAtIndex:0];
    NSString *paths = [docDir stringByAppendingPathComponent:name];
    return paths;
}

CGRect getStringContentSize(UIFont *font , CGSize size , NSString *string)
{
    CGRect rect;
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    NSDictionary *attributes = @{NSFontAttributeName:font};
    
    rect  =  [string boundingRectWithSize:size options:options attributes:attributes context:nil];
    return rect;
}

#pragma mark - 绘制圆角
UIImage * ScaleImageSize(UIImage * image,CGSize targetSize) {
    UIImage *sourceImage = image;
    UIImage *newImage = nil;
    UIGraphicsBeginImageContextWithOptions(targetSize, NO, [UIScreen mainScreen].scale);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = CGPointZero;
    thumbnailRect.size.width  = targetSize.width;
    thumbnailRect.size.height = targetSize.height;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage ;
    
}

UIImage * drawImage(UIImage * originImage,CGSize rectSize,CGFloat roundedRadius) {
    CGRect rect = CGRectMake(0, 0,rectSize.width, rectSize.height);
    UIGraphicsBeginImageContextWithOptions(rectSize, NO, [UIScreen mainScreen].scale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextAddPath(currentContext, [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(roundedRadius, roundedRadius)].CGPath);
    CGContextClip(currentContext);
    [originImage drawAsPatternInRect:rect];
    CGContextDrawPath(currentContext, kCGPathFillStroke);
    UIImage *roundedCornerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return roundedCornerImage;
}

#pragma mark - 提示信息相关
void ShowWaringAlertHUD(NSString *message, id toView)
{
    if (message && [message length] > 0) {
        if (toView) {
            [toView makeToast:message duration:1.5f position:CSToastPositionCenter];
        }
        else {
            [[[UIApplication sharedApplication].delegate window] makeToast:message duration:1.5f position:CSToastPositionCenter];
        }
    }
}

void ShowProgressHUD(BOOL isShow,id toView)
{
    ShowProgressHUDWithText(isShow, toView, nil);
}

void ShowProgressHUDWithText(BOOL isShow,id toView,NSString *text)
{
    UIView *view = toView ? toView : [[UIApplication sharedApplication].delegate window];
    
    if (!isShow) {
        [MBProgressHUD hideHUDForView:view];
    }else {
        if (JudgeContainerCountIsNull(text)) {
            [MBProgressHUD showHUDAddedTo:view animated:YES];
        }else {
            [MBProgressHUD showMessage:text toView:view];
        }
    }
}

/*!
 *  @brief  显示操作成功的提示
 *
 *  @param message 提示信息
 *  @param toView  应用到的地方
 */
void ShowSucceedAlertHUD(NSString *message,id toView)
{
    if (message && [message length] > 0)
    {
        if (toView)
        {
            MBProgressHUD *hud = [MBProgressHUD showSuccess:message toView:toView];
            hud.bezelView.color = [UIColor colorWithHexRGB:@"333333"];
        }else
        {
            MBProgressHUD *hud = [MBProgressHUD showSuccess:message toView:[UIApplication sharedApplication].keyWindow];
            hud.bezelView.color = [UIColor colorWithHexRGB:@"333333"];
        }
    }
}

/*!
 *  @brief  显示
 *
 *  @param message 提示信息
 *  @param toView  应用到的地方
 */
void ShowFailedAlertHUD(NSString *message, id toView)
{
    if (message && [message length] > 0)
    {
        if (toView)
        {
            [MBProgressHUD showError:message toView:toView];
        }else
        {
            [MBProgressHUD showError:message toView:[UIApplication sharedApplication].keyWindow];
        }
    }
}
