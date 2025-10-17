//
//  NSFileHandle+KillCrash.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/9/10.
//

#import "NSFileHandle+KillCrash.h"
#import "NSObject+CrashKillerMethodSwizzling.h"

@implementation NSFileHandle (KillCrash)

+ (void)registerKillFileHandle
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSConcreteFileHandle = NSClassFromString(@"NSConcreteFileHandle");
        //手机内存不足时，调用writeData会闪退
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(writeData:)  withMethod:@selector(crashKiller_writeData:) withClass:__NSConcreteFileHandle];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(writeData:error:)  withMethod:@selector(crashKiller_writeData:error:) withClass:__NSConcreteFileHandle];
    });
}
- (BOOL)crashKiller_writeData:(NSData *)data
{
    BOOL result = NO;
    @try {
        result = [self crashKiller_writeData:data];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return result;
    }
}
- (BOOL)crashKiller_writeData:(NSData *)data error:(out NSError **)error
{
    BOOL result = NO;
    @try {
        result = [self crashKiller_writeData:data error:error];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return result;
    }
}

@end
