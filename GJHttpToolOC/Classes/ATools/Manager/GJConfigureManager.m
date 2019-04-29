//
//  GJConfigureManager.m
//  LGJ
//
//  Created by LGJ on 2018/3/16.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#import "GJConfigureManager.h"

@implementation GJConfigureManager

static GJConfigureManager * sharedManager = nil;
+ (GJConfigureManager *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[GJConfigureManager alloc] init];
    });
    return sharedManager;
}

@end
