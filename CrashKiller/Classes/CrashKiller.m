//
//  CrashKiller.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/3/29.
//

#import "CrashKiller.h"
#import "CrashKillerManager.h"
#import "NSObject+KillSelector.h"


@implementation CrashKiller

+ (BOOL)terminateWhenException
{
    return [CrashKillerManager shareManager].terminateWhenException;
}
+ (void)setTerminateWhenException:(BOOL)terminateWhenException
{
    [CrashKillerManager shareManager].terminateWhenException = terminateWhenException;
}

+ (void)configDefendCrashType:(CrashKillerDefendCrashType)type
{
    [CrashKillerManager shareManager].defendCrashType = type;
}

//开启崩溃防护
+ (void)start
{
    [CrashKillerManager shareManager].isStart = YES;
    [[CrashKillerManager shareManager] registerExceptionDefend];
}

//关闭崩溃防护
+ (void)stop
{
    /*暂无好的全局关闭方法，只能在所有交换方法做前置判断，如果没有开启防护，则不进行方法交换
     后续优化
     */
    [CrashKillerManager shareManager].isStart = NO;
}

+ (void)handleCrashLog:(id<CrashKillerLogDelegate>)logDelegate
{
    [CrashKillerManager shareManager].logDelegate = (id <CrashKillerLogDelegate>)logDelegate;
}

+ (void)setDebugLog:(BOOL)debugLog
{
    crashKillerDebugLog = debugLog;
}


@end
