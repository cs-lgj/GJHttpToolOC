//
//  GJLoadingView.m
//  LGJ
//
//  Created by LGJ on 2018/4/13.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "GJLoadingView.h"
#import "UIView+Extension.h"
#import "GJConfigureManager.h"

@interface GJLoadingView ()
@property (nonatomic, strong) CAShapeLayer * indicator;
@property (nonatomic, strong) CAAnimationGroup * animation;
@property (nonatomic, strong) CAReplicatorLayer *reaplicator;
@property (nonatomic, strong) CALayer *showlayer;
@property (assign,nonatomic) BOOL maskBackground;
@end

@implementation GJLoadingView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        _indicator = [CAShapeLayer layer];
        _indicator.frame = CGRectMake(0, 0, 40, 40);
        _indicator.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(20, 20) radius:20 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
        _indicator.fillColor = [UIColor clearColor].CGColor;
        _indicator.strokeColor = [UIColor darkGrayColor].CGColor;
        _indicator.lineWidth = 4.f;
        _indicator.lineCap = kCALineCapRound;
        _indicator.strokeEnd = 1;
        [self.layer addSublayer:self.reaplicator];
        self.alpha = 0;
        self.hidden = YES;
    }
    return self;
}

- (CAAnimationGroup *)animation
{
    if (!_animation) {
        CABasicAnimation * strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        strokeEndAnimation.fromValue = @(0);
        strokeEndAnimation.toValue = @(1);
        strokeEndAnimation.duration = 0.8;
        
        CABasicAnimation * strokeStarAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
        strokeStarAnimation.fromValue = @(0);
        strokeStarAnimation.toValue = @(0.999999);
        strokeStarAnimation.duration = 1.5;
        
        CABasicAnimation * rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.fromValue = @(0);
        rotationAnimation.toValue = @(M_PI*2);
        rotationAnimation.duration = 1.5;
        
        CABasicAnimation * colorAnimation = [CABasicAnimation animationWithKeyPath:@"strokeColor"];
        colorAnimation.fromValue = (id)[UIColor darkGrayColor].CGColor;
        colorAnimation.toValue = (id)APP_CONFIG.appMainColor.CGColor;
        colorAnimation.duration = 1.5;
        
        CAAnimationGroup * group = [CAAnimationGroup new];
        group.animations = @[strokeEndAnimation, strokeStarAnimation, rotationAnimation, colorAnimation];
        group.duration = 1.5;
        group.repeatCount = HUGE_VAL;
        
        _animation = group;
        _animation.removedOnCompletion = NO;
    }
    return _animation;
}

- (void)didMoveToSuperview
{
    self.frame = self.superview.bounds;
}

- (void)layoutSubviews
{
    self.backgroundColor =  self.maskBackground ? [UIColor whiteColor] : [UIColor colorWithWhite:1 alpha:0];
    self.frame = self.superview.bounds;
    _indicator.position = self.boundsCenter;
    _reaplicator.position = self.boundsCenter;
}

- (void)startAnimation
{
    self.maskBackground = NO;
    [self beginLoadingAniamtion];
}

- (void)beginLoadingAniamtion {
    self.hidden = NO;
    self.alpha = 1;
    [self.superview bringSubviewToFront:self];
    [self setNeedsLayout];
    [self.showlayer addAnimation:[self rotationAnimation] forKey:@"anmation"];
}

- (void)stopAnimation
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self.showlayer removeAnimationForKey:@"anmation"];
    }];
}

- (void)startLoadingAimationWithMaskBackground {
    self.maskBackground = YES;
    [self beginLoadingAniamtion];
}

- (CABasicAnimation *)rotationAnimation {
    CABasicAnimation *animaiton = [CABasicAnimation animation];
    animaiton.keyPath = @"transform.scale";
    animaiton.fromValue = @(1);
    animaiton.toValue = @(0.1);
    animaiton.duration = 0.8;
    animaiton.fillMode = kCAFillModeForwards;
    animaiton.removedOnCompletion = NO;
    animaiton.repeatCount = INT_MAX;
    return animaiton;
}

- (CAReplicatorLayer *)reaplicator{
    if (!_reaplicator) {
        int numofInstance = 10;
        CGFloat duration = 0.8;
        CAReplicatorLayer *repelicator = [CAReplicatorLayer layer];
        repelicator.bounds = CGRectMake(0, 0, 50, 50);
        repelicator.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        repelicator.instanceCount = numofInstance;
        repelicator.instanceDelay = duration / numofInstance;
        repelicator.instanceTransform = CATransform3DMakeRotation(M_PI * 2 / numofInstance, 0, 0, 1);
        
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, 8, 8);
        CGPoint point = [repelicator convertPoint:repelicator.position fromLayer:self.layer];
        layer.position = CGPointMake(point.x, point.y - 20);
        layer.backgroundColor = [APP_CONFIG appMainColor].CGColor;
        
        layer.cornerRadius = 5;
        layer.transform = CATransform3DMakeScale(0.01, 0.01, 1);
        _showlayer = layer;
        [repelicator addSublayer:layer];
        _reaplicator = repelicator;
    }
    return _reaplicator;
}

@end
