//
//  GJRootViewController.m
//  LGJ
//
//  Created by LGJ on 2018/3/16.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "GJRootViewController.h"
#import "GJLaunchViewController.h"
#import "GJTabBarController.h"

@interface GJRootViewController ()
@property (nonatomic, strong) GJLaunchViewController *launchVC;
@end

@implementation GJRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setInterfaceAppearence];
    [self setLauncher];
}

- (void)setInterfaceAppearence {
    
}

- (void)setLauncher {
    __weak typeof(self)weakSelf = self;
    _launchVC = [[GJLaunchViewController alloc] init];
    
    [self addChildViewController:_launchVC];
    [self.view addSubview:_launchVC.view];
    
    _launchVC.finishBlock = ^{
        GJTabBarController *tabbarVC = [[GJTabBarController alloc] init];
        [weakSelf showController:tabbarVC dismiss:weakSelf.launchVC index:4];
    };
}

- (void)showController:(UIViewController *)showVC dismiss:(UIViewController *)dismissVC index:(NSUInteger)idx {
    [showVC didMoveToParentViewController:self];
    [self addChildViewController:showVC];
    [self.view addSubview:showVC.view];
    showVC.view.alpha = 0;
    if ([showVC isKindOfClass:UITabBarController.class]) {
        UITabBarController *tab = (UITabBarController *)showVC;
        tab.selectedIndex = idx;
    }
    [UIView animateWithDuration:0.7 animations:^{
        showVC.view.alpha = 1;
    } completion:^(BOOL finished) {
        [dismissVC.view removeFromSuperview];
        [dismissVC removeFromParentViewController];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
