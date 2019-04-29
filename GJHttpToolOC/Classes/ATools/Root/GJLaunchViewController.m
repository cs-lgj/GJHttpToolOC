//
//  GJLaunchViewController.m
//  LGJ
//
//  Created by LGJ on 2018/3/16.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "GJLaunchViewController.h"

@interface GJLaunchViewController ()
@property (nonatomic, strong)  UIImageView *loadingView;
@property (nonatomic, strong) NSTimer *endTimer;
@end

@implementation GJLaunchViewController

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    _loadingView.frame = self.view.bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.loadingView = [[UIImageView alloc] init];
    self.loadingView.image = [self getLaunchImage];
    [self.view addSubview:self.loadingView];
    
    [self startTimer];
}

- (UIImage *)getLaunchImage {
    CGSize viewSize  =[UIScreen mainScreen].bounds.size;
    NSString * viewOrientation = @"Portrait";
    NSString * launchImage = nil;
    NSArray * imageDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary  * dict in imageDict) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    UIImage *image = [UIImage imageNamed:launchImage];
    return image;
}

- (void)startTimer {
    _endTimer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(countDown) userInfo:nil repeats:NO];
}

- (void)countDown {
    [_endTimer invalidate];
    _endTimer = nil;
    if(_finishBlock) _finishBlock();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
