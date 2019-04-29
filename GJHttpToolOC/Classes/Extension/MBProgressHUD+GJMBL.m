//
//  MBProgressHUD+GJMBL.m
//  LGJ
//
//  Created by LGJ on 2018/3/17.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "MBProgressHUD+GJMBL.h"

#define MBShow_Time 1.5

@implementation MBProgressHUD (GJMBL)

#pragma mark -
+ (MBProgressHUD *)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view {
    
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = text;
    hud.label.numberOfLines = 0;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:MBShow_Time];
    
    hud.bezelView.backgroundColor = [UIColor blackColor];
    hud.label.textColor = [UIColor whiteColor];
    return hud;
}

#pragma mark - Show to view
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    
    if (view == nil) view = [[UIApplication sharedApplication] keyWindow];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text = message;
    hud.label.numberOfLines = 0;
    hud.removeFromSuperViewOnHide = YES;
    
    //#pragma clang diagnostic push
    //#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    //    hud.activityIndicatorColor = [UIColor whiteColor];
    //#pragma clang diagnostic pop
    //    hud.bezelView.backgroundColor = [APP_CONFIG appMainColor];
    //    hud.label.textColor = [UIColor whiteColor];
    //    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    //    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    
    hud.userInteractionEnabled = NO;
    
    return hud;
}

+ (MBProgressHUD *)showSuccess:(NSString *)success toView:(UIView *)view {
    return  [self show:success icon:@"success" view:view];
}

+ (MBProgressHUD *)showError:(NSString *)error toView:(UIView *)view {
    return  [self show:error icon:@"error" view:view];
}

+ (void)showWarning:(NSString *)warning toView:(UIView *)view {
    [self show:warning icon:@"warning" view:view];
}

#pragma mark - Show
+ (MBProgressHUD *)showMessage:(NSString *)message {
    return [self showMessage:message toView:nil];
}

+ (void)showSuccess:(NSString *)success {
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error {
    [self showError:error toView:nil];
}

+ (void)showWarning:(NSString *)warning {
    [self showWarning:warning toView:nil];
}

#pragma mark - Hide
+ (void)hideHUDForView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication] keyWindow];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD {
    [self hideHUDForView:nil];
}

@end
