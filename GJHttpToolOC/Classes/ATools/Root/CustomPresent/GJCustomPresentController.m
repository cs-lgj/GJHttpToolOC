//
//  GJCustomPresentController.m
//  LGJ
//
//  Created by LGJ on 2018/3/26.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "GJCustomPresentController.h"
#import "GJDismissTransitionAnimated.h"
#import "GJPresentTransitionAnimated.h"

@interface GJCustomPresentController () <UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIPercentDrivenInteractiveTransition * percentDrivenTransition;
@end

@implementation GJCustomPresentController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self allowBack];
    if (self.interactivePopDisabled) return ;
    [self addScreenLeftEdgePanGestureRecognizer:self.view];
}

- (void)pushPageWith:(UIViewController *)context {
    UINavigationController *presentNav = [[UINavigationController alloc] initWithRootViewController:self];
    presentNav.transitioningDelegate = self;
    [context presentViewController:presentNav animated:YES completion:nil];
}

#pragma mark - 添加手势的方法
- (void)addScreenLeftEdgePanGestureRecognizer:(UIView *)view {
    UIScreenEdgePanGestureRecognizer * edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)]; //手势由self来管理
    edgePan.edges = UIRectEdgeLeft;
    [view addGestureRecognizer:edgePan];
}

#pragma mark - 手势的监听方法
- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)edgePan{
    CGFloat progress = fabs([edgePan translationInView:[UIApplication sharedApplication].keyWindow].x / [UIApplication sharedApplication].keyWindow.bounds.size.width);
    
    if(edgePan.state == UIGestureRecognizerStateBegan){
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        if(edgePan.edges == UIRectEdgeLeft){
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }else if(edgePan.state == UIGestureRecognizerStateChanged){
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    }else if(edgePan.state == UIGestureRecognizerStateCancelled || edgePan.state == UIGestureRecognizerStateEnded){
        if(progress > 0.5){
            [_percentDrivenTransition finishInteractiveTransition];
        }else{
            [_percentDrivenTransition cancelInteractiveTransition];
        }
        _percentDrivenTransition = nil;
    }
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[GJPresentTransitionAnimated alloc] init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[GJDismissTransitionAnimated alloc] init];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _percentDrivenTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _percentDrivenTransition;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

