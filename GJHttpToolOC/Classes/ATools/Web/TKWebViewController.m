
//  TKWebViewController.m
//  LGJ
//
//  Created by LGJ on 2017/6/28.
//  Copyright © 2017年 LGJ. All rights reserved.
//

#import "TKWebViewController.h"
#import "TKWebJSContent.h"
#import "UIView+Extension.h"
#import "GJHttpConstant.h"

#define JSCONTENT         @"documentView.webView.mainFrame.javaScriptContext"
#define JS                @"if(!window.TKApp){window.TKApp={};window.TK_inApp=true};window.TKApp.wb_scan = function(data){}"

@interface TKWebViewController ()<UIWebViewDelegate>
{
    
    NJKWebViewProgress *_progressProxy;
}

@property (strong,nonatomic) TKWebJSContent *webJS;
@end

@implementation TKWebViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _webView.frame = self.view.bounds;
    _webProgressView.origin = CGPointMake(0, 0);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    [self.view addSubview:_webProgressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_webProgressView removeFromSuperview];
}


#pragma mark - Getter
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.scalesPageToFit = YES;
    }
    return _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.scrollView.bounces = NO;
   [self.view addSubview:self.webView];
   NSURLRequest *request =  [NSURLRequest requestWithURL:[NSURL URLWithString:_webUrl]];
    
    _webView.delegate = self;
    [_webView loadRequest:request];
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, SCREEN_W, progressBarHeight);
    _webProgressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    
    [self.webView.loadingView startAnimation];
    
    UIBarButtonItem * back = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"arrow_left_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    UIBarButtonItem * close = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"close"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(closeAction)];
    close.imageInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    self.navigationItem.leftBarButtonItems = @[back];
    
}

- (void)backAction {
//    if ([self.webView canGoBack]) {
//        [self.webView goBack];
//        return;
//    }
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else{
        //present方式
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)closeAction {
    NSArray *viewcontrollers=self.navigationController.viewControllers;
    if (viewcontrollers.count>1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1]==self) {
            //push方式
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
    }
    else{
        //present方式
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self didFailLoadWithError:error];
    [self.webView.loadingView stopAnimation];
    //ShowWaringAlertHUD(@"网络开小差～", self.webView);
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self webViewDidStartLoadHandel];
    [_webView stringByEvaluatingJavaScriptFromString:JS];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    if (!_isSetTitle) {
        self.navigationItem.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
    
    [_webView stringByEvaluatingJavaScriptFromString:JS];
   
    self.context = [webView valueForKeyPath:JSCONTENT];
    self.webJS = [[TKWebJSContent alloc] initWith:self.context];
    [self.webJS configJsContentByController:self webView:self.webView];
    [self webViewDidFinishLoadHandel];
    [_webProgressView setProgress:1.0 animated:YES];
    
    [self.webView.loadingView stopAnimation];
   [self.webView stringByEvaluatingJavaScriptFromString:@"document.dispatchEvent(new CustomEvent('appReady', {detail: 0,bubbles: true,cancelable: true}))"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_webProgressView setProgress:progress animated:YES];
    if (!_isSetTitle) {
        self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }
}

- (void)webViewDidFinishLoadHandel {}
- (void)webViewDidStartLoadHandel {}
- (void)didFailLoadWithError:(NSError *)error {
  
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_webView loadHTMLString:@"" baseURL:nil];
    [_webView stopLoading];
    [_webView removeFromSuperview];
    _webView = nil;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [[NSURLCache sharedURLCache] setDiskCapacity:0];
    [[NSURLCache sharedURLCache] setMemoryCapacity:0];
}

@end
