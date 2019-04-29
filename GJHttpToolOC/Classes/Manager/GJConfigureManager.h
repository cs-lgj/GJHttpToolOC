//
//  GJConfigureManager.h
//  LGJ
//
//  Created by LGJ on 2018/3/16.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GJAppConfigure.h"

#define APP_CONFIG [GJConfigureManager sharedManager].config

@interface GJConfigureManager : NSObject

@property (nonatomic, strong) GJAppConfigure * config;  ///< 项目基本配置
@property (nonatomic,assign) BOOL isFirstLaunchAPP;     ///< 是否是第一次启动App
@property (strong,nonatomic) NSDictionary *pushInfo;     ///< 推动信息 走后台唤醒时会获取用于通知的判断

+ (GJConfigureManager *)sharedManager;

@end
