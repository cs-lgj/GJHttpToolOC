//
//  HeaderConstant.h
//  LGJ
//
//  Created by LGJ on 2018/3/16.
//  Copyright © 2018年 LGJ. All rights reserved.
//

#ifndef HeaderConstant_h
#define HeaderConstant_h

// APP settings
#define SCREEN_W                [[UIScreen mainScreen] bounds].size.width
#define SCREEN_H                [[UIScreen mainScreen] bounds].size.height
#define NavBar_H                (44 + [UIApplication sharedApplication].statusBarFrame.size.height)
#define AdaptatSize(width)      (SCREEN_W*width/375.0f)
#define IPHONE_X                SCREEN_H >= 812.0

#undef  BLOCK_SAFE
#define BLOCK_SAFE(block)       if(block)block

#endif /* HeaderConstant_h */
