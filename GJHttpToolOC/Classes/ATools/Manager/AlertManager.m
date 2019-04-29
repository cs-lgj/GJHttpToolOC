//
//  AlertManager.m
//  LGJ
//
//  Created by LGJ on 2018/3/17.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "AlertManager.h"
#import "GJFunctionManager.h"

@implementation AlertManager

+ (void)showAlertTitle:(NSString *)title content:(NSString *)content viecontroller:(UIViewController *)vc cancel:(NSString *)cancelTitle cancelHandle:(void (^)(void))cancelBlock {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle) {
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock();
            }
        }];
        [alertVc addAction:cancleAction];
    }
    
    vc = vc ? vc : [GJFunctionManager CurrentTopViewcontroller];
    dispatch_async(dispatch_get_main_queue(), ^{
        [vc presentViewController:alertVc animated:YES completion:nil];
    });
}

+ (void)showAlertTitle:(NSString *)title content:(NSString *)content viecontroller:(UIViewController *)vc cancel:(NSString *)cancelTitle sure:(NSString *)sureTitle  cancelHandle:(void (^)(void))cancelBlock sureHandle:(void (^)(void))sureBlock {
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:title message:content preferredStyle:UIAlertControllerStyleAlert];
   
    if (cancelTitle) {
        UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock();
            }
        }];
        [alertVc addAction:cancleAction];
    }
    
    if (sureTitle) {
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (sureBlock) {
                sureBlock();
            }
        }];
        [alertVc addAction:sureAction];
    }
    
    if (!cancelTitle && !sureTitle) {
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertVc addAction:sureAction];
    }
    
    vc = vc ? vc : [GJFunctionManager CurrentTopViewcontroller];
    dispatch_async(dispatch_get_main_queue(), ^{
        [vc presentViewController:alertVc animated:YES completion:nil];
    });
}

+ (void)showAcctionSheetMessage:(NSString *)message chooseTakePhoto:(void(^)(void))takePhototBlock album:(void(^)(void))albumBlock {
     UIAlertController *sheet = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (takePhototBlock) {
            takePhototBlock();
        }
    }];
    [sheet addAction:photo];
    
    UIAlertAction *album = [UIAlertAction actionWithTitle:@"用户相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (albumBlock) {
            albumBlock();
        }
    }];
    [sheet addAction:album];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    [sheet addAction:cancel];
    
    UIViewController *vc = [GJFunctionManager CurrentTopViewcontroller];
    dispatch_async(dispatch_get_main_queue(), ^{
        [vc presentViewController:sheet animated:YES completion:nil];
    });
}

+ (void)showActionSheetMessage:(NSString *)message firstTitle:(NSString *)firstTitle secondTitle:(NSString *)secondTitle chooseFirst:(void(^)(void))chooseFirstBlock chooseSecond:(void(^)(void))chooseSecondBlock {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *fist = [UIAlertAction actionWithTitle:firstTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (chooseFirstBlock) {
            chooseFirstBlock();
        }
    }];
    [sheet addAction:fist];
    
    UIAlertAction *second = [UIAlertAction actionWithTitle:secondTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (chooseSecondBlock) {
            chooseSecondBlock();
        }
    }];
    [sheet addAction:second];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [sheet addAction:cancel];
    
    UIViewController *vc = [GJFunctionManager CurrentTopViewcontroller];
    dispatch_async(dispatch_get_main_queue(), ^{
        [vc presentViewController:sheet animated:YES completion:nil];
    });
}

+ (void)showActionSheetMessage:(NSString *)message titleArr:(NSArray<NSString *> *)titles chooseIndex:(void (^)(NSInteger))chooseBlock {
    UIAlertController *sheet = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIAlertAction *aa = [UIAlertAction actionWithTitle:titles[idx] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (chooseBlock) {
                chooseBlock(idx);
            }
        }];
        [sheet addAction:aa];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [sheet addAction:cancel];
    
    UIViewController *vc = [GJFunctionManager CurrentTopViewcontroller];
    dispatch_async(dispatch_get_main_queue(), ^{
        [vc presentViewController:sheet animated:YES completion:nil];
    });
}

@end
