//
//  NSFileManager+KillCrash.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/9/10.
//

#import "NSFileManager+KillCrash.h"
#import "NSObject+CrashKillerMethodSwizzling.h"

@implementation NSFileManager (KillCrash)

+ (void)registerKillFileManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSFileManager = NSClassFromString(@"NSFileManager");
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(fileExistsAtPath:)  withMethod:@selector(crashKiller_fileExistsAtPath:) withClass:__NSFileManager];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(fileExistsAtPath:isDirectory:)  withMethod:@selector(crashKiller_fileExistsAtPath:isDirectory:) withClass:__NSFileManager];

        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(moveItemAtPath:toPath:error:)  withMethod:@selector(crashKiller_moveItemAtPath:toPath:error:) withClass:__NSFileManager];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(moveItemAtURL:toURL:error:)  withMethod:@selector(crashKiller_moveItemAtURL:toURL:error:) withClass:__NSFileManager];

        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(copyItemAtPath:toPath:error:)  withMethod:@selector(crashKiller_copyItemAtPath:toPath:error:) withClass:__NSFileManager];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(copyItemAtURL:toURL:error:)  withMethod:@selector(crashKiller_copyItemAtURL:toURL:error:) withClass:__NSFileManager];
    });
}

- (BOOL)crashKiller_fileExistsAtPath:(NSString *)path
{
    BOOL result = NO;
    @try {
        result = [self crashKiller_fileExistsAtPath:path];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return result;
    }
}
- (BOOL)crashKiller_fileExistsAtPath:(NSString *)path isDirectory:(nullable BOOL *)isDirectory
{
    BOOL result = NO;
    @try {
        result = [self crashKiller_fileExistsAtPath:path isDirectory:isDirectory];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return result;
    }
}
- (BOOL)crashKiller_moveItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error
{
    BOOL result = NO;
    @try {
        result = [self crashKiller_moveItemAtPath:srcPath toPath:dstPath error:error];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return result;
    }
}
- (BOOL)crashKiller_copyItemAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error
{
    BOOL result = NO;
    @try {
        result = [self crashKiller_copyItemAtPath:srcPath toPath:dstPath error:error];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return result;
    }
}

- (BOOL)crashKiller_copyItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL error:(NSError **)error
{
    BOOL result = NO;
    @try {
        result = [self crashKiller_copyItemAtURL:srcURL toURL:dstURL error:error];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return result;
    }
}

- (BOOL)crashKiller_moveItemAtURL:(NSURL *)srcURL toURL:(NSURL *)dstURL error:(NSError **)error
{
    BOOL result = NO;
    @try {
        result = [self crashKiller_moveItemAtURL:srcURL toURL:dstURL error:error];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return result;
    }
}

@end
