//
//  NSString+KillCrash.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/4/2.
//

#import "NSString+KillCrash.h"
#import "NSObject+CrashKillerMethodSwizzling.h"

@implementation NSString (KillCrash)

+ (void)registerKillString
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        /* init方法 */
        Class NSPlaceholderString = NSClassFromString(@"NSPlaceholderString");
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithString:) withMethod:@selector(crashKiller_initWithString:) withClass:NSPlaceholderString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithUTF8String:) withMethod:@selector(crashKiller_initWithUTF8String:) withClass:NSPlaceholderString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithCString:encoding:) withMethod:@selector(crashKiller_initWithCString:encoding:) withClass:NSPlaceholderString];


        /* _NSCFConstantString */
        Class __NSCFConstantString = NSClassFromString(@"__NSCFConstantString");
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringFromIndex:) withMethod:@selector(crashKiller_substringFromIndex:) withClass:__NSCFConstantString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringToIndex:) withMethod:@selector(crashKiller_substringToIndex:) withClass:__NSCFConstantString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringWithRange:) withMethod:@selector(crashKiller_substringWithRange:) withClass:__NSCFConstantString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(characterAtIndex:) withMethod:@selector(crashKiller_characterAtIndex:) withClass:__NSCFConstantString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(stringByAppendingString:) withMethod:@selector(crashKiller_stringByAppendingString:) withClass:__NSCFConstantString];


        /* NSTaggedPointerString
         例如：
         NSString *str = [NSString stringWithFormat:@"%@",@(100)];
         [str substringFromIndex:10];
         */
        Class NSTaggedPointerString = NSClassFromString(@"NSTaggedPointerString");
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringFromIndex:) withMethod:@selector(crashKiller_taggedPointer_substringFromIndex:) withClass:NSTaggedPointerString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringToIndex:) withMethod:@selector(crashKiller_taggedPointer_substringToIndex:) withClass:NSTaggedPointerString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringWithRange:) withMethod:@selector(crashKiller_taggedPointer_substringWithRange:) withClass:NSTaggedPointerString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(stringByAppendingString:) withMethod:@selector(crashKiller_taggedPointer_stringByAppendingString:) withClass:NSTaggedPointerString];

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
        if (NULL != nullTerminatedCString) {
            instance = [self crashKiller_initWithCString:nullTerminatedCString encoding:encoding];
        }else{

            NSException *exce = [[NSException alloc] initWithName:@"NSInvalidArgumentException" reason:@"*** -[NSPlaceholderString crashKiller_initWithCString:encoding:]: NULL cString" userInfo:nil];
            [exce raise];
        }
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}


- (NSString *)crashKiller_substringFromIndex:(NSUInteger)from
{

    id instance = nil;
    @try {
        instance = [self crashKiller_substringFromIndex:from];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}

- (NSString *)crashKiller_taggedPointer_substringFromIndex:(NSUInteger)from
{
    id instance = nil;
    @try {
        instance = [self crashKiller_taggedPointer_substringFromIndex:from];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}


- (NSString *)crashKiller_substringToIndex:(NSUInteger)to
{
    id instance = nil;
    @try {
        instance = [self crashKiller_substringToIndex:to];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}

- (NSString *)crashKiller_taggedPointer_substringToIndex:(NSUInteger)to
{
    id instance = nil;
    @try {
        instance = [self crashKiller_taggedPointer_substringToIndex:to];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}

- (NSString *)crashKiller_substringWithRange:(NSRange)range
{
    id instance = nil;
    @try {
        instance = [self crashKiller_substringWithRange:range];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}

- (NSString *)crashKiller_taggedPointer_substringWithRange:(NSRange)range
{

    id instance = nil;
    @try {
        instance = [self crashKiller_taggedPointer_substringWithRange:range];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}

- (unichar)crashKiller_characterAtIndex:(NSUInteger)index
{
    unichar instance;
    @try {
        instance = [self crashKiller_characterAtIndex:index];
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

- (NSString *)crashKiller_taggedPointer_stringByAppendingString:(NSString *)aString
{
    id instance = nil;
    @try {
        instance = [self crashKiller_taggedPointer_stringByAppendingString:aString];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}



@end
