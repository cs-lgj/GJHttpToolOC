//
//  GJAppConfigure.h
//  LGJ
//
//  Created by LGJ on 2018/3/16.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJAppConfigure : NSObject

#pragma mark Environment
@property (nonatomic, strong) UIColor * appBackgroundColor;
@property (nonatomic, strong) UIColor * appMainColor;
@property (nonatomic, strong) UIColor * appMainRedColor;
@property (nonatomic, strong) UIColor * separatorLineColor;
@property (strong, nonatomic) UIColor * appEnableColor;
@property (strong, nonatomic) UIColor * appGrayBackgoundColor;

#pragma mark NavigationBar
@property (nonatomic, strong) UIColor * navigationBarBackgroundColor;
@property (nonatomic, strong) UIColor * naviagtionBarTintColor;
@property (nonatomic, strong) NSDictionary * navigationBarTitleTextAttributes;

#pragma mark TabBar
@property (nonatomic, strong) UIColor * tabBarBackgroundColor;
@property (nonatomic, strong) UIColor * tabBarTintColor;
@property (nonatomic, strong) NSDictionary * tabBarTitleTextAttributes;

#pragma mark Unify


#pragma Colors
- (void)setupAppMainColor;
- (void)customColors;

#pragma Fonts
- (UIFont *)appArtBoldFontOfSize:(CGFloat)size;
- (UIFont *)appArtLightFontOfSize:(CGFloat)size;
- (UIFont *)appLightFontOfSize:(CGFloat)size;
- (UIFont *)appFontOfSize:(CGFloat)size;
- (UIFont *)appAdaptFontOfSize:(CGFloat)size;
- (UIFont *)appBoldFontOfSize:(CGFloat)size;
- (UIFont *)appAdaptBoldFontOfSize:(CGFloat)size;
- (UIFont *)appExtraLightFontOfSize:(CGFloat)size;
- (UIFont *)appBahnschriftSemiBoldFontOfSize:(CGFloat)size;
- (UIFont *)appBahnschriftSemiFontOfSize:(CGFloat)size;

- (UIFont *)appUniqueFontOfSize:(CGFloat)size;

- (UIColor *)darkTextColor;
- (UIColor *)grayTextColor;
- (UIColor *)lightTextColor;
- (UIColor *)whiteGrayColor;
- (UIColor *)blackTextColor;
- (UIColor *)partnerMainColor;

#pragma mark - PlaceImage
- (UIColor *)placeColor;
- (UIImage *)placeUserHeard;
- (UIImage *)placeRectImg; ///< 方形站位图
- (UIImage *)placeNormal;

@end
