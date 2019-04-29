//
//  GJBaseViewController.h
//  LGJ
//
//  Created by LGJ on 2018/3/16.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GJBaseViewController : UIViewController

- (void)allowBack;
- (void)allowBackWithImage:(NSString *)image;
- (void)showShadorOnNaviBar:(BOOL)show;
- (void)backAction;
- (void)setStatusBarLight:(BOOL)is;
- (void)topRightButtonTitle:(NSString *)title action:(SEL)action;

@end
