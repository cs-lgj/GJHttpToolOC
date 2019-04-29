//
//  GJBaseNavigationController.m
//  LGJ
//
//  Created by LGJ on 2018/3/16.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "GJBaseNavigationController.h"

@interface GJBaseNavigationController () <UINavigationControllerDelegate>

@end

@implementation GJBaseNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        self.delegate = self;
    }
    return self;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    if (viewController != self.viewControllers[0] && !viewController.navigationItem.hidesBackButton) {
        UIBarButtonItem * back = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"arrow_left_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
        viewController.navigationItem.leftBarButtonItem = back;
    }
}

- (void)back {
    if ([self.topViewController respondsToSelector:@selector(shouldPopback)]) {
        if (![self.topViewController shouldPopback]) {
            return;
        }
    }
    [self popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController != self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.enabled = YES;
        self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)viewController;
    } else{
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

@end
