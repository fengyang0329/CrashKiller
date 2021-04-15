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


BOOL crashKillerDebugLog = YES;

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
}



- (void)printLogWithFunction:(NSString *)func reason:(NSString *)reason callStackSymbols:(NSArray <NSString *> *)callStackSymbols
{
    NSString *log = [NSString stringWithFormat:@"**** crash reason: '*** -%@: %@'",func,reason];
    if (func.length == 0) {

        log = [NSString stringWithFormat:@"**** crash reason: '%@'",reason];
    }
    NSString *detailLog = [log stringByAppendingFormat:@"\n   *** First throw call stack:%@",callStackSymbols];
    CrashKillerLOG(@"%@",detailLog);
    //如果外部注册了logDelegate，则将log给出
    if (self.logDelegate && [self.logDelegate respondsToSelector:@selector(onLog:callStackSymbols:)])
    {
        [self.logDelegate onLog:log callStackSymbols:callStackSymbols];
    }
    if (self.terminateWhenException) {
        
//        NSException *excp = [NSException exceptionWithName:@"Error" reasonlog userInfo:nil];
//        [excp raise];
        NSAssert(NO, log);
    }
}

@end
