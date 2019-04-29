//
//  AlertManager.h
//  LGJ
//
//  Created by LGJ on 2018/3/17.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertManager : NSObject

+(void)showAlertTitle:(NSString *)title content:(NSString *)content viecontroller:(UIViewController *)vc cancel:(NSString *)cancelTitle cancelHandle:(void (^)(void))cancelBlock;

+(void)showAlertTitle:(NSString *)title content:(NSString *)content viecontroller:(UIViewController *)vc cancel:(NSString *)cancelTitle sure:(NSString *)sureTitle  cancelHandle:(void (^)(void))cancelBlock sureHandle:(void (^)(void))sureBlock;

// 弹出图片选择
+ (void)showAcctionSheetMessage:(NSString *)message chooseTakePhoto:(void(^)(void))takePhototBlock album:(void(^)(void))albumBlock;

/**
 ActionSheet
 */
+ (void)showActionSheetMessage:(NSString *)message firstTitle:(NSString *)firstTitle secondTitle:(NSString *)secondTitle chooseFirst:(void(^)(void))chooseFirstBlock chooseSecond:(void(^)(void))chooseSecondBlock;

+ (void)showActionSheetMessage:(NSString *)message titleArr:(NSArray <NSString *> *)titles chooseIndex:(void(^)(NSInteger idx))chooseBlock;

@end
