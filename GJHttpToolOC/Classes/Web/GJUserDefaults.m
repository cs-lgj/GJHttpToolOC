//
//  GJUserDefaults.m
//  ZHYK
//
//  Created by hsrd on 2018/3/29.
//  Copyright © 2018年 HSRD. All rights reserved.
//

#import "GJUserDefaults.h"

@implementation GJUserDefaults

+ (void)removeValueBy:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)saveObject:(id)object key:(NSString *)key {
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:encodedObject forKey:key];
    [defaults synchronize];
}

+ (id)loadObjectWithKey:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *encodedObject = [defaults objectForKey:key];
    id object = [NSKeyedUnarchiver unarchiveObjectWithData:encodedObject];
    return object;
}

+ (void)appendingCountObjectForKey:(NSString *)key withDefaultValue:(int)value
{
    if (![self loadObjectWithKey:key]) {
        [self saveObject:@(value) key:key];
    } else {
        int i = [[self loadObjectWithKey:key] intValue];
        i++;
        [self saveObject:@(i) key:key];
    }
}

+ (void)appendingCountObjectForKey:(NSString *)key
{
    [self appendingCountObjectForKey:key withDefaultValue:0];
}

@end
