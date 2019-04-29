//
//  GJUserDefaults.h
//  ZHYK
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GJUserDefaults : NSObject

+ (void)saveObject:(id)object key:(NSString *)key;
+ (id)loadObjectWithKey:(NSString *)key;
+ (void)removeValueBy:(NSString *)key;

+ (void)appendingCountObjectForKey:(NSString *)key;
+ (void)appendingCountObjectForKey:(NSString *)key withDefaultValue:(int)value;

@end
