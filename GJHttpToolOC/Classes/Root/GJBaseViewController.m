//
//  GJBaseViewController.m
//  LGJ
//
//  Created by LGJ on 2018/3/16.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "GJBaseViewController.h"
#import "GJFunctionManager.h"
#import "UIColor+Extension.h"
#import "GJConfigureManager.h"

@interface GJBaseViewController ()

@end

@implementation GJBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    UINavigationBar *bar = self.navigationController.navigationBar;
    [bar setBackgroundImage:CreatImageWithColor([UIColor whiteColor])
             forBarPosition:UIBarPositionAny
                 barMetrics:UIBarMetricsDefault];
    [bar setShadowImage:CreatImageWithColor([UIColor colorWithRGB:220 g:220 b:220])];
}

- (void)allowBack {
    [self allowBackWithImage:@"arrow_left_back"];
//    [self allowBackWithImage:@"back1"];
}

- (void)allowBackWithImage:(NSString *)image {
    UIBarButtonItem * back = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    self.navigationItem.leftBarButtonItem = back;
}

- (void)backAction {
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count > 1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1] == self) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else{
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)showShadorOnNaviBar:(BOOL)show {
    UINavigationBar *bar = self.navigationController.navigationBar;
    if (show) {
        bar.layer.shadowColor = [UIColor lightGrayColor].CGColor;
        bar.layer.shadowOpacity = 1;
        bar.layer.shadowRadius = 8.f;
        bar.layer.shadowOffset = CGSizeMake(0,0);
        [bar setBackgroundImage:CreatImageWithColor([UIColor whiteColor])
                 forBarPosition:UIBarPositionAny
                     barMetrics:UIBarMetricsDefault];
        [bar setShadowImage:[UIImage new]];
    }else {
        bar.layer.shadowColor = [UIColor whiteColor].CGColor;
        bar.layer.shadowOpacity = 0;
        bar.layer.shadowRadius = 0.f;
        bar.layer.shadowOffset = CGSizeMake(0,0);
        [bar setBackgroundImage:CreatImageWithColor([UIColor whiteColor])
                 forBarPosition:UIBarPositionAny
                     barMetrics:UIBarMetricsDefault];
        [bar setShadowImage:[UIImage new]];
    }
}

- (void)setStatusBarLight:(BOOL)is {
    if (is) {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }else {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

- (void)topRightButtonTitle:(NSString *)title action:(SEL)action {
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, APP_CONFIG.darkTextColor,NSForegroundColorAttributeName, nil];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attributes forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:attributes forState:UIControlStateHighlighted];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
