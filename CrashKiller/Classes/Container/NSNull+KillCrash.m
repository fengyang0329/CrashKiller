//
//  NSNull+KillCrash.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/4/2.
//

#import "NSNull+KillCrash.h"

@implementation NSNull (KillCrash)

- (NSInteger)integerValue
{
    return 0;
}
- (int)intValue
{
    return 0;
}
- (float)floatValue
{
    return 0.0;
}
- (double)doubleValue
{
    return 0.00;
}
- (BOOL)boolValue
{
    return NO;
}
- (long long) longLongValue
{
    return 0;
}

- (NSUInteger)length
{
    return 0;
}
- (BOOL)isEqualToString:(NSString *)aString
{
    return NO;
}
- (BOOL)hasPrefix:(NSString *)str
{
    return NO;
}
- (BOOL)hasSuffix:(NSString *)str
{
    return NO;
}
- (NSUInteger)count
{
    return 0;
}
- (NSArray *)allKeys
{
    return nil;
}
- (NSArray *)allValues
{
    return nil;
}
@end
