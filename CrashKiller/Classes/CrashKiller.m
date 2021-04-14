//
//  CrashKiller.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/3/29.
//

#import "CrashKiller.h"
#import "CrashKillerManager.h"


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
+ (void)startWihtLogDelegate:(id<CrashKillerLogDelegate>)logDelegate
{
    [CrashKillerManager shareManager].isStart = YES;
    [CrashKillerManager shareManager].logDelegate = (id <CrashKillerLogDelegate>)logDelegate;
    [[CrashKillerManager shareManager] registerExceptionDefend];
}

//关闭崩溃防护
+ (void)stop
{
    [CrashKillerManager shareManager].isStart = NO;
}

+ (void)setDebugLog:(BOOL)debugLog
{
    crashKillerDebugLog = debugLog;
}


@end
