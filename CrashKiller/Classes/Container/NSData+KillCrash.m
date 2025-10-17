//
//  NSData+KillCrash.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/9/10.
//

#import "NSData+KillCrash.h"
#import "NSObject+CrashKillerMethodSwizzling.h"

@implementation NSData (KillCrash)

+ (void)registerKillData
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSZeroData = NSClassFromString(@"_NSZeroData");
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(subdataWithRange:)  withMethod:@selector(crashKiller_ZeroDataSubdataWithRange:) withClass:__NSZeroData];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(rangeOfData:options:range:)  withMethod:@selector(crashKiller_ZeroDataRangeOfData:options:range:) withClass:__NSZeroData];

        Class __NSConcreteMutableData = NSClassFromString(@"NSConcreteMutableData");
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(subdataWithRange:)  withMethod:@selector(crashKiller_subdataWithRange:) withClass:__NSConcreteMutableData];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(rangeOfData:options:range:)  withMethod:@selector(crashKiller_rangeOfData:options:range:) withClass:__NSConcreteMutableData];

        Class ___NSPlaceholderData = NSClassFromString(@"_NSPlaceholderData");
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithBase64EncodedString:options:)  withMethod:@selector(crashKiller_initWithBase64EncodedString:options:) withClass:___NSPlaceholderData];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithBase64EncodedData:options:)  withMethod:@selector(crashKiller_initWithBase64EncodedData:options:) withClass:___NSPlaceholderData];
    });
}
- (NSData *)crashKiller_ZeroDataSubdataWithRange:(NSRange)range
{
    id result = nil;
    @try {
        result = [self crashKiller_ZeroDataSubdataWithRange:range];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return result;
    }
}
- (NSRange)crashKiller_ZeroDataRangeOfData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange
{
    NSRange result = NSMakeRange(NSNotFound, 0);
    @try {
        result = [self crashKiller_ZeroDataRangeOfData:dataToFind options:mask range:searchRange];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return result;
    }
}

- (NSData *)crashKiller_subdataWithRange:(NSRange)range
{
    id result = nil;
    @try {
        result = [self crashKiller_subdataWithRange:range];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return result;
    }
}
- (NSRange)crashKiller_rangeOfData:(NSData *)dataToFind options:(NSDataSearchOptions)mask range:(NSRange)searchRange
{
    NSRange result = NSMakeRange(NSNotFound, 0);
    @try {
        result = [self crashKiller_rangeOfData:dataToFind options:mask range:searchRange];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return result;
    }
}


- (nullable instancetype)crashKiller_initWithBase64EncodedString:(NSString *)base64String options:(NSDataBase64DecodingOptions)options
{
    id result = nil;
    @try {
        result = [self crashKiller_initWithBase64EncodedString:base64String options:options];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return result;
    }
}
- (nullable instancetype)crashKiller_initWithBase64EncodedData:(NSData *)base64Data options:(NSDataBase64DecodingOptions)options
{
    id result = nil;
    @try {
        result = [self crashKiller_initWithBase64EncodedData:base64Data options:options];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return result;
    }
}
@end
