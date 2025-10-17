//
//  NSMutableString+KillCrash.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/4/2.
//

#import "NSMutableString+KillCrash.h"
#import "NSObject+CrashKillerMethodSwizzling.h"

@implementation NSMutableString (KillCrash)

+ (void)registerKillMutableString
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        Class NSPlaceholderMutableString = NSClassFromString(@"NSPlaceholderMutableString");
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithString:) withMethod:@selector(crashKiller_initWithString:) withClass:NSPlaceholderMutableString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithUTF8String:) withMethod:@selector(crashKiller_initWithUTF8String:) withClass:NSPlaceholderMutableString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithCString:encoding:) withMethod:@selector(crashKiller_initWithCString:encoding:) withClass:NSPlaceholderMutableString];

        Class __NSCFString = NSClassFromString(@"__NSCFString");
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(stringByAppendingString:) withMethod:@selector(crashKiller_stringByAppendingString:) withClass:__NSCFString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(appendString:) withMethod:@selector(crashKiller_appendString:) withClass:__NSCFString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(insertString:atIndex:) withMethod:@selector(crashKiller_insertString:atIndex:) withClass:__NSCFString];

        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(deleteCharactersInRange:) withMethod:@selector(crashKiller_deleteCharactersInRange:) withClass:__NSCFString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringFromIndex:) withMethod:@selector(crashKiller_substringFromIndex:) withClass:__NSCFString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringToIndex:) withMethod:@selector(crashKiller_substringToIndex:) withClass:__NSCFString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringWithRange:) withMethod:@selector(crashKiller_substringWithRange:) withClass:__NSCFString];
    });
}

- (instancetype)crashKiller_initWithString:(NSString *)aString
{
    id instance = nil;
    @try {
        instance = [self crashKiller_initWithString:aString];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}
- (nullable instancetype)crashKiller_initWithUTF8String:(const char *)nullTerminatedCString;
{
    id instance = nil;
    @try {
        instance = [self crashKiller_initWithUTF8String:nullTerminatedCString];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}

- (nullable instancetype)crashKiller_initWithCString:(const char *)nullTerminatedCString encoding:(NSStringEncoding)encoding
{
    id instance = nil;
    @try {
        instance = [self crashKiller_initWithCString:nullTerminatedCString encoding:encoding];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}

- (NSString *)crashKiller_stringByAppendingString:(NSString *)aString
{
    id instance = nil;
    @try {
        instance = [self crashKiller_stringByAppendingString:aString];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}

- (void)crashKiller_appendString:(NSString *)aString
{

    @try {
        [self crashKiller_appendString:aString];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    }
}

- (void)crashKiller_insertString:(NSString *)aString atIndex:(NSUInteger)loc
{

    @try {
        [self crashKiller_insertString:aString atIndex:loc];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    }
}

- (void)crashKiller_deleteCharactersInRange:(NSRange)range
{
    @try {
        [self crashKiller_deleteCharactersInRange:range];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    }
}


- (NSString *)crashKiller_substringFromIndex:(NSUInteger)from
{
    NSString *instance = nil;
    @try {
        instance = [self crashKiller_substringFromIndex:from];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}

- (NSString *)crashKiller_substringToIndex:(NSUInteger)to
{
    NSString *instance = nil;
    @try {
        instance = [self crashKiller_substringToIndex:to];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}

- (NSString *)crashKiller_substringWithRange:(NSRange)range
{
    NSString *instance = nil;
    @try {
        instance = [self crashKiller_substringWithRange:range];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}




@end
