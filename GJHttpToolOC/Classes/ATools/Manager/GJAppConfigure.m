//
//  GJAppConfigure.m
//  LGJ
//
//  Created by LGJ on 2018/3/16.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "GJAppConfigure.h"
#import "UIColor+Extension.h"
#import "GJFunctionManager.h"

@implementation GJAppConfigure

- (instancetype)init
{
    if (self = [super init]) {
        [self setupAppMainColor];
        
        _appBackgroundColor = [UIColor colorWithHexRGB:@"#f3f7f7"];
        _appMainRedColor = [UIColor colorWithHexRGB:@"#ff3939"];
        _separatorLineColor = [UIColor colorWithHexRGB:@"#e8eeee"];
        _appEnableColor = [UIColor colorWithHexRGB:@"#cbccd3"];
        _appGrayBackgoundColor = [UIColor colorWithHexRGB:@"#eeeeee"];
        _navigationBarBackgroundColor = [UIColor colorWithHexRGB:@"#f3f7f7"]; //导航颜色
        _naviagtionBarTintColor = [UIColor colorWithHexRGB:@"#ffffff"];
        UIFont *naviBarFont = [self appBoldFontOfSize:18];
        _navigationBarTitleTextAttributes = @{NSFontAttributeName: naviBarFont, NSForegroundColorAttributeName: _naviagtionBarTintColor};
        _tabBarBackgroundColor = [UIColor colorWithHexRGB:@"19151E"];
        _tabBarTitleTextAttributes = @{NSFontAttributeName: [self appBoldFontOfSize:11]};
        _tabBarTintColor = [UIColor colorWithHexRGB:@"#01B0BB"];
        [self customColors];
    }
    return self;
}

- (void)setupAppMainColor
{
    _appMainColor = [UIColor colorWithRGB:243 g:220 b:57];
}

- (void)customColors {
    
}


#pragma Fonts
- (UIFont *)appArtBoldFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Baskerville-SemiBoldItalic" size:size];
}

- (UIFont *)appArtLightFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Baskerville-Italic" size:size];
}

- (UIFont *)appLightFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Avenir-Book" size:size];
}

- (UIFont *)appFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Avenir-Roman" size:size];
}

- (UIFont *)appAdaptFontOfSize:(CGFloat)size
{
    return AdapFont([self appFontOfSize:size]);
}

- (UIFont *)appBoldFontOfSize:(CGFloat)size
{
    return [UIFont fontWithName:@"Avenir-Medium" size:size];
}

- (UIFont *)appAdaptBoldFontOfSize:(CGFloat)size
{
    return AdapFont([self appBoldFontOfSize:size]);
}

- (UIFont *)appExtraLightFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Avenir-Light" size:size];
}

- (UIFont *)appBahnschriftSemiBoldFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Bahnschrift_SemiBold" size:size];
}

- (UIFont *)appBahnschriftSemiFontOfSize:(CGFloat)size {
    return [UIFont fontWithName:@"Bahnschrift_SemiLight" size:size];
}

- (UIFont *)appUniqueFontOfSize:(CGFloat)size
{
    return [self appFontOfSize:size];
}

- (UIColor *)partnerMainColor {
    return [UIColor colorWithHexRGB:@"#c69c6d"];
}

- (UIColor *)blackTextColor {
    return [UIColor colorWithHexRGB:@"#333333"];
}

- (UIColor *)darkTextColor {
    return [UIColor colorWithHexRGB:@"#555555"];
}


- (UIColor *)grayTextColor {
    return [UIColor colorWithHexRGB:@"#999999"];
}

- (UIColor *)lightTextColor {
    return [UIColor colorWithHexRGB:@"#dbdbdb"];
}

- (UIColor *)whiteGrayColor {
    return [UIColor colorWithHexRGB:@"#ffffff"];
}

- (UIColor *)placeColor {
    return [UIColor colorWithHexRGB:@"#f7f7f7"];
}

- (UIImage *)placeUserHeard {
    return [UIImage imageNamed:@"AppIcon"];
}


- (UIImage *)placeRectImg {
    return [UIImage imageNamed:@"AppIcon"];
}

- (UIImage *)placeNormal {
    return [UIImage imageNamed:@"AppIcon"];
}

@end
