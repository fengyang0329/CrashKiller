//
//  NSJSONSerialization+KillCrash.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/8/5.
//

#import "NSJSONSerialization+KillCrash.h"
#import "NSObject+CrashKillerMethodSwizzling.h"

@implementation NSJSONSerialization (KillCrash)

+ (void)registerKillJSONSerialization
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSJSONSerialization = NSClassFromString(@"NSJSONSerialization");
        [NSObject crashKillerMethodSwizzlingClassMethod:@selector(dataWithJSONObject:options:error:) withMethod:@selector(crashKiller_dataWithJSONObject:options:error:) withClass:__NSJSONSerialization];
        [NSObject crashKillerMethodSwizzlingClassMethod:@selector(JSONObjectWithData:options:error:) withMethod:@selector(crashKiller_JSONObjectWithData:options:error:) withClass:__NSJSONSerialization];
    });
}

+ (nullable NSData *)crashKiller_dataWithJSONObject:(id)obj options:(NSJSONWritingOptions)opt error:(NSError **)error
{
    id result = nil;
    @try {
        result = [self crashKiller_dataWithJSONObject:obj options:opt error:error];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return result;
    }
}

+ (nullable id)crashKiller_JSONObjectWithData:(NSData *)data options:(NSJSONReadingOptions)opt error:(NSError **)error
{
    id result = nil;
    @try {
        result = [self crashKiller_JSONObjectWithData:data options:opt error:error];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return result;
    }
}
@end
