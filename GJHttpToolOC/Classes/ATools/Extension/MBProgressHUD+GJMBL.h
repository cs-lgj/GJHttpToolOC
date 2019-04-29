//
//  MBProgressHUD+GJMBL.h
//  LGJ
//
//  Created by LGJ on 2018/3/17.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (GJMBL)

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (MBProgressHUD *)showSuccess:(NSString *)success toView:(UIView *)view;
+ (MBProgressHUD *)showError:(NSString *)error toView:(UIView *)view;
+ (void)showWarning:(NSString *)warning toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (void)showWarning:(NSString *)warning;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
