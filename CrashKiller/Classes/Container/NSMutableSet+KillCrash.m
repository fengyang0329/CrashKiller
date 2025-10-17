//
//  NSMutableSet+KillCrash.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/7/8.
//

#import "NSMutableSet+KillCrash.h"
#import "NSObject+CrashKillerMethodSwizzling.h"

@implementation NSMutableSet (KillCrash)


+ (void)registerKillNSMutableSet
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSSetM = NSClassFromString(@"__NSSetM");
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(addObject:) withMethod:@selector(crashKiller_addObject:) withClass:__NSSetM];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(removeObject:) withMethod:@selector(crashKiller_removeObject:) withClass:__NSSetM];
    });
}

- (void)crashKiller_addObject:(id)object
{
    @try {
        [self crashKiller_addObject:object];
    }
    @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    }
}

- (void)crashKiller_removeObject:(id)object
{
    @try {
        [self crashKiller_removeObject:object];
    }
    @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    }
}

@end
