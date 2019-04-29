//
//  UIColor+Extension.h
//  LGJ
//
//  Created by LGJ on 2018/3/16.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

+ (UIColor *)colorWithHexRGB:(NSString *)hex;
+ (UIColor *)colorWithHexRGB:(NSString *)hex alpha:(CGFloat)alpha;
+ (UIImage *)colorImageWithColor:(UIColor *)color;
+ (UIColor *)colorWithRGB:(CGFloat)r g:(CGFloat)g b:(CGFloat)b;
+ (UIColor *)colorWithRGBHex:(int)rgbValue;

@end
