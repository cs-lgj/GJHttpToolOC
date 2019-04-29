//
//  TKWebJSContent.m
//  LGJ
//
//  Created by LGJ on 2017/7/21.
//  Copyright © 2017年 LGJ. All rights reserved.
//

#import "TKWebJSContent.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "TKWebMedia.h"
#import "AlertManager.h"
#import "UIViewController+Extension.h"
#import "GJFunctionManager.h"
#import "GJUserDefaults.h"

@interface TKWebJSContent ()
//@property (strong, nonatomic) GJSystemHelper *systemHelper;

@end

@implementation TKWebJSContent
-(id)initWith:(JSContext *)context {
    self = [super init];
    if (self) {
//        self.systemHelper = [GJSystemHelper system];
        self.context = context;
    }
    return self;
}

- (void)configJsContentByController:(UIViewController *)controller webView:(UIWebView *)webView {
    
    __weak typeof(self)weakSelf = self;
    
    self.byController = controller;
    
    /******************* 通用公共 **********************/
    self.context[@"TKApp"][@"wb_gettingUserId"] = ^{
        
    };
    
    self.context[@"TKApp"][@"wb_isLogin"] = ^{
        
//        return APP_USER.isLoginStatus;
    };
    
    self.context[@"TKApp"][@"wb_moblieType"] = ^{
        return 1; // 1 iOS 2,Android
    };
    
    self.context[@"TKApp"][@"wb_getDeviceId"] = ^{
        return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    };
    
    // 设置title
    self.context[@"TKApp"][@"wb_setDocumentTitle"] = ^(NSString *title) {
        dispatch_async(dispatch_get_main_queue(), ^{
            // To do UI
            controller.title = title;
        });
    };
    
    self.context[@"TKApp"][@"wb_openNewWebView"] = ^(NSInteger webStatus,NSString *url){
        if (webStatus == 1) {
            [TKWebMedia commonWebViewJumpUrl:url title:nil controller:controller];
        }
        // 没头
        if (webStatus == 2) {
            
        }
    };
    
    // 获取ID
    self.context[@"TKApp"][@"wb_getId"] = ^{
       NSString *appId = [GJUserDefaults loadObjectWithKey:HTTP_SESSION_ID];
        return JudgeContainerCountIsNull(appId) ? @"" : appId;
    };
    
    // 弹出登录
    self.context[@"TKApp"][@"wb_gotoLogin"] = ^{
//        [GJLoginController logOutPresentLoginControllerByVC:controller loginSucessBlcok:^{
//            [webView stringByEvaluatingJavaScriptFromString:@"window.H5.appLoginSuccess()"];
//        }];
    };
    
    // 拍照相册选择 
    self.context[@"TKApp"][@"wb_selectPicture"] = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            // To do UI
            [AlertManager showAcctionSheetMessage:@"" chooseTakePhoto:^{
                [weakSelf chooseTakePhotoByController:controller webView:webView];
            } album:^{
                [weakSelf chooseAlbumByController:controller webView:webView];
            }];
        });
    };
    
    // 直接分享
    self.context[@"TKApp"][@"wb_serviceShare"] = ^(NSString *jsonStr){
//        NSDictionary *json = [jsonStr stringTrasformJSONObjectData];
//        NSString *content = json[@"content"];
//        NSString *title = json[@"title"];
//        NSString *picUrl = json[@"picUrl"];
//        NSString *jumpUrl = json[@"jumpUrl"];
        dispatch_async(dispatch_get_main_queue(), ^{
            ShowProgressHUD(YES, nil);
        });
//        __block UIImage *image;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
            // To do background task
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:picUrl]];
//            UIImage *urlImage = [UIImage imageWithData:imageData];
//            image = [UIImage imageWithData:[UIImage imageObjectToData:urlImage andCompressionQuality:0.5 andMaxSize:200]];
            dispatch_async(dispatch_get_main_queue(), ^{
                ShowProgressHUD(NO, nil);
//                [controller popShareViewID:@"" type:0 title:title desc:content urlStr:jumpUrl icon:image];
            });
        });
    };

    
    /******************* 用户信息 **********************/
    // 电话号码
    self.context[@"TKApp"][@"wb_telePhone"] = ^(){
//        if (APP_USER.isLoginStatus) {
//            return APP_USER.userInfo.phone;
//        }else {
//            return @"";
//        }
    };
    
    // 用户信息
    self.context[@"TKApp"][@"wb_getUserInfo"] = ^(){
        
        return @"";
    };
    
    self.context[@"TKApp"][@"wb_selectLocation"] = ^() {
//        return APP_USER.selectLocation.cityId ? APP_USER.selectLocation.cityId  : @"" ;
    };
    
    /******关闭*******/
    self.context[@"TKApp"][@"wb_closeWindow"] = ^{
        [controller dismissNavigationViewController];
    };
}

#pragma mark - 分享
- (void)shareAction:(UIBarButtonItem *)item {
    ShowProgressHUD(YES, nil);
//    __block UIImage *image;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        // To do background task
//        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:_picUrl]];
//        UIImage *urlImage = [UIImage imageWithData:imageData];
//        image = [UIImage imageWithData:[UIImage imageObjectToData:urlImage andCompressionQuality:0.5 andMaxSize:200]];
        dispatch_async(dispatch_get_main_queue(), ^{
            ShowProgressHUD(NO, nil);
//            [[GJFunctionManager CurrentTopViewcontroller] popShareViewID:nil type:0 title:_title desc:_content urlStr:_jumpUrl icon:image];
        });
    });
}

#pragma mark - 相册资源
- (void)chooseTakePhotoByController:(UIViewController *)vc webView:(UIWebView *)webView {
//    __weak typeof(self)weakSelf = self;
//    [_systemHelper vistiSystemTakePhoto:^(UIImage *image) {
//        [weakSelf upDateImage:image webView:webView];
//    } failure:^{
//    } presentController:vc];
}

- (void)chooseAlbumByController:(UIViewController *)vc webView:(UIWebView *)webView {
//    __weak typeof(self)weakSelf = self;
//    [_systemHelper vistiSystemAlbum:^(UIImage *image) {
//        [weakSelf upDateImage:image webView:webView];
//    } failure:^{} presentController:vc];
}

- (void)upDateImage:(UIImage *)image webView:(UIWebView *)webView{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        // To do background task
//        NSData *scaleImgData = [UIImage imageObjectToData:image];
//        NSString *sta = [scaleImgData base64Encoding];
//        NSString *js = [NSString stringWithFormat:@"window.H5.setPicture('%@')",sta];
//          [webView stringByEvaluatingJavaScriptFromString:js];
        dispatch_async(dispatch_get_main_queue(), ^{
            // To do UI
          
        });
    });
}

@end
