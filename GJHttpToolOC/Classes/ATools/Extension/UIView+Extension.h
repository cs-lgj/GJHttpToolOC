//
//  UIView+Extension.h
//  LGJ
//
//  Created by LGJ on 2018/3/16.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GJLoadingView.h"

typedef NS_ENUM(NSInteger, LGJViewBorder) {
    LGJViewBorderTop = 1<<1,
    LGJViewBorderLeft = 1<<2,
    LGJViewBorderBottom = 1<<3,
    LGJViewBorderRight = 1<<4,
};

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGPoint boundsCenter;
@property (nonatomic, assign, readonly) CGFloat maxY;
@property (nonatomic, assign, readonly) CGFloat maxX;
@property (nonatomic, assign, readonly) UIEdgeInsets spaceInset;

// single border of view
@property (nonatomic, assign) LGJViewBorder borderWhich;
@property (nonatomic, assign, readonly) CGRect bottomSeparatorLineRect;
@property (nonatomic, assign, readonly) CGFloat bottomSeparatorHeight;

@property (nonatomic, strong) GJLoadingView *loadingView;

+ (UIView *)separatorLineViewWithColor:(UIColor *)color;
- (UIView *)border:(UIColor *)color width:(CGFloat)width radius:(CGFloat)radius;
@end
