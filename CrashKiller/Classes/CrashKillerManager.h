//
//  CrashKillerManager.h
//  CrashKiller
//
//  Created by 龙章辉 on 2021/3/29.
//

#import <Foundation/Foundation.h>
#import <CrashKiller/CrashKiller.h>

//#define SLOG(fmt, ...) if (crashKillerDebugLog) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define CrashKillerLOG(fmt, ...) if (crashKillerDebugLog) NSLog((fmt), ##__VA_ARGS__)

extern BOOL crashKillerDebugLog;

@interface CrashKillerManager : NSObject

/**
 如果terminateWhenException设置为YES,发生异常时将终止应用程序
 如果terminateWhenException设置为NO，则该异常只显示在控制台上，不会停止应用程序
 Default value:NO
 */
@property(nonatomic,assign)BOOL terminateWhenException;


@property(nonatomic,assign)BOOL isStart;
@property(nonatomic,weak)id <CrashKillerLogDelegate> logDelegate;
@property(nonatomic,assign)CrashKillerDefendCrashType defendCrashType;

+(instancetype)shareManager;
- (void)registerExceptionDefend;


- (void)printLogWithFunction:(NSString *)func reason:(NSString *)reason callStackSymbols:(NSArray <NSString *> *)callStackSymbols;
@end

