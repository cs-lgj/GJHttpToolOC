//
//  UIColor+Extension.m
//  LGJ
//
//  Created by LGJ on 2018/3/16.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

+ (UIColor *)colorWithHexRGB:(NSString *)hex alpha:(CGFloat)alpha{
    if(hex.length == 0) return [UIColor redColor];
    if([[hex substringToIndex:1] isEqualToString:@"#"]){
        hex = [hex substringFromIndex:1];
    }
    if(hex.length != 6) return [UIColor redColor];
    int i = 0;
    NSString *rstr = [hex substringWithRange:NSMakeRange(i, 2)]; i+=2;
    NSString *gstr = [hex substringWithRange:NSMakeRange(i, 2)]; i+=2;
    NSString *bstr = [hex substringWithRange:NSMakeRange(i, 2)]; i+=2;
    
    
    NSScanner *scanner;
    
    unsigned int red;
    scanner = [NSScanner scannerWithString:rstr];
    if(![scanner scanHexInt:&red]){
        return [UIColor redColor];
    }
    
    unsigned int green;
    scanner = [NSScanner scannerWithString:gstr];
    if(![scanner scanHexInt:&green]){
        return [UIColor redColor];
    }
    
    unsigned int blue;
    scanner = [NSScanner scannerWithString:bstr];
    if(![scanner scanHexInt:&blue]){
        return [UIColor redColor];
    }
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

+ (UIColor *)colorWithHexRGB:(NSString *)hex
{
    return [self colorWithHexRGB:hex alpha:1];
}

+ (UIImage *)colorImageWithColor:(UIColor *)color {
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIColor *)colorWithRGB:(CGFloat)r g:(CGFloat)g b:(CGFloat)b {
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1.0];
}

+ (UIColor *)colorWithRGBHex:(int)rgbValue {
    return [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];
}

@end
