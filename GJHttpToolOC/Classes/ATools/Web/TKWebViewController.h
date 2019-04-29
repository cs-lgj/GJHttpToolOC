//
//  TKWebViewController.h
//  LGJ
//
//  Created by LGJ on 2017/6/28.
//  Copyright © 2017年 LGJ. All rights reserved.
//

#import "GJCustomPresentController.h"
#import "NJKWebViewProgress.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "NJKWebViewProgressView.h"

@interface TKWebViewController : GJCustomPresentController<NJKWebViewProgressDelegate>
@property (strong,nonatomic) NSString *webUrl;
@property (strong, nonatomic)  UIWebView *webView;
@property (strong,nonatomic)  JSContext *context;
@property (assign,nonatomic)  BOOL isSetTitle;
@property (strong,nonatomic,readonly) NJKWebViewProgressView *webProgressView;

- (void)webViewDidFinishLoadHandel;
- (void)webViewDidStartLoadHandel;
- (void)didFailLoadWithError:(NSError *)error;
- (void)closeAction;
@end
