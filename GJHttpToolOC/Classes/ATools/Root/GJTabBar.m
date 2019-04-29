//
//  GJTabBar.m
//  LGJ
//
//  Created by LGJ on 2018/3/16.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "GJTabBar.h"
#import "Masonry.h"
#import "GJHttpConstant.h"

@interface GJTabBar ()

@end

@implementation GJTabBar

- (void)layoutSubviews {
    [super layoutSubviews];
    [_centerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(37);
        make.centerX.equalTo(self.superview);
        if (IPHONE_X) {
            make.bottom.equalTo(self.superview).with.offset(-40);
        }else {
            make.bottom.equalTo(self.superview).with.offset(-6);
        }
    }];
    [self bringSubviewToFront:_centerButton];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _centerButton = [[UIButton alloc] init];
        [_centerButton setImage:[UIImage imageNamed:@"tabbar_add"] forState:UIControlStateNormal];
        _centerButton.userInteractionEnabled = NO;
        _centerButton.backgroundColor = [UIColor whiteColor];
        [self addSubview:_centerButton];
    }
    return self;
}

@end
