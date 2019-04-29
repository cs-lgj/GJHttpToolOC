//
//  TKWebMedia.h
//  LGJ
//
//  Created by LGJ on 2017/7/23.
//  Copyright © 2017年 LGJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKWebMedia : NSObject

/**
 用常用的WebView 容器打开

 @param url 地址
 @param title title
 @param controller 介质容器
 */
+(void)commonWebViewJumpUrl:(NSString *)url  title:(NSString *)title controller:(UIViewController *)controller;
+(void)customPresentWebViewJumpUrl:(NSString *)url  title:(NSString *)title controller:(UIViewController *)controller;

+(void)openWKWebWithJumpUrl:(NSString *)url title:(NSString *)title controller:(UIViewController *)controller;

@end
