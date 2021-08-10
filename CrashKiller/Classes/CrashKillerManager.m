//
//  CrashKillerManager.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/3/29.
//

#import "CrashKillerManager.h"
#import "NSObject+KillSelector.h"
#import "NSObject+KillKVO.h"
#import "NSObject+KillKVC.h"
#import "NSTimer+KillCrash.h"
#import "NSArray+KillCrash.h"
#import "NSMutableArray+KillCrash.h"
#import "NSDictionary+KillCrash.h"
#import "NSString+KillCrash.h"
#import "NSMutableString+KillCrash.h"
#import "NSSet+KillCrash.h"
#import "NSMutableSet+KillCrash.h"
#import "NSJSONSerialization+KillCrash.h"

#if DEBUG
BOOL crashKillerDebugLog = YES;
#else
BOOL crashKillerDebugLog = NO;
#endif

@implementation CrashKillerManager

+(instancetype)shareManager{
    static dispatch_once_t onceToken;
    static CrashKillerManager *_manager;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc] init];
    });
    return _manager;
}

- (instancetype)init{
    self = [super init];
    if (self) {

        _terminateWhenException = NO;
        _defendCrashType = CrashKillerDefendAll;
        _selectorClassWhiteList = [NSMutableSet set];
    }
    return self;
}
- (void)registerExceptionDefend
{
    CrashKillerDefendCrashType defendType = [CrashKillerManager shareManager].defendCrashType;
    if (defendType & CrashKillerDefendUnrecognizedSelector) {

        CrashKillerLOG(@"添加unrecognized selector类型防护");
        [NSObject registerKillSelector];
    }
    if (defendType & CrashKillerDefendKVC) {

        CrashKillerLOG(@"添加kvc类型防护");
        [NSObject registerKillKVC];
    }
    if (defendType & CrashKillerDefendKVO) {

        CrashKillerLOG(@"添加kvo类型防护");
        [NSObject registerKillKVO];
    }
    if (defendType & CrashKillerDefendNSTimer) {

        CrashKillerLOG(@"添加NSTimer类型防护");
        [NSTimer registerKillTimer];
    }
    if (defendType & CrashKillerDefendDictionaryContainer) {

        CrashKillerLOG(@"添加NSDictionary Container类型防护");
        [NSDictionary registerKillDictionary];
    }
    if (defendType & CrashKillerDefendArrayContainer) {

        CrashKillerLOG(@"添加NSArray Container类型防护");
        [NSArray registerKillArray];
        [NSMutableArray registerKillMutableArray];
    }
    if (defendType & CrashKillerDefendStringContainer) {

        CrashKillerLOG(@"添加NSString Container类型防护");
        [NSString registerKillString];
        [NSMutableString registerKillMutableString];
    }
    if (defendType & CrashKillerDefendSetContainer) {

        CrashKillerLOG(@"添加NSSet Container类型防护");
        [NSSet registerKillSet];
        [NSMutableSet registerKillNSMutableSet];
    }
    if (defendType & CrashKillerDefendJSONSerialization) {

        CrashKillerLOG(@"添加NSJSONSerialization类型防护");
        [NSJSONSerialization registerKillJSONSerialization];
    }
}


- (void)printLogWithException:(NSException *)exception
{
    CrashKillerLOG(@"%@",exception);
    //如果外部注册了logDelegate，则将log给出
    if (self.logDelegate && [self.logDelegate respondsToSelector:@selector(onLog:)])
    {
        [self.logDelegate onLog:exception];
    }
    if (self.terminateWhenException) {

        assert(0);
    }
}
- (void)throwExceptionWithName:(NSString *)name reason:(NSString *)reason
{
    @try {
        NSException *exce = [[NSException alloc] initWithName:name reason:reason userInfo:nil];
        [exce raise];

    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    }
}


@end
