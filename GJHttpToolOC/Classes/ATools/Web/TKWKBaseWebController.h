//
//  TKWKBaseWebController.h
//  LGJ
//
//  Created by LGJ on 2017/8/10.
//  Copyright © 2017年 LGJ. All rights reserved.
//

#import "GJBaseViewController.h"
#import <WebKit/WebKit.h>

@interface TKWKBaseWebController : GJBaseViewController
@property (strong,nonatomic) WKWebView *webView;
@property (strong,nonatomic) NSString *url;
@end
