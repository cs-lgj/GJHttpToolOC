//
//  UIViewController+Extension.h
//  LGJ
//
//  Created by LGJ on 2018/3/17.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)

- (BOOL)shouldPopback;
- (void)addSubview:(UIView *)aView;
- (void)addDismissButtonForNavigationItem;
- (void)dismissNavigationViewController;
- (void)removeNavigationChildControllerAtIndex:(NSInteger)index;

@end
