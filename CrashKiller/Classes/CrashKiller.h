//
//  CrashKiller.h
//  CrashKiller
//
//  Created by 龙章辉 on 2021/3/29.
//

#import <Foundation/Foundation.h>

/*
 闪退杀手防护类型,
 默认CrashKillerDefendAll
 */
typedef NS_OPTIONS(NSUInteger, CrashKillerDefendCrashType) {

    CrashKillerDefendUnrecognizedSelector = 1 << 1,
    CrashKillerDefendKVC = 1 << 2,
    CrashKillerDefendKVO = 1 << 3,
    CrashKillerDefendNSTimer = 1 << 4,
    CrashKillerDefendDictionaryContainer = 1 << 4,
    CrashKillerDefendArrayContainer = 1 << 5,
    CrashKillerDefendStringContainer = 1 << 6,
    CrashKillerDefendAll = CrashKillerDefendUnrecognizedSelector | CrashKillerDefendKVC | CrashKillerDefendKVO | CrashKillerDefendNSTimer | CrashKillerDefendDictionaryContainer | CrashKillerDefendArrayContainer | CrashKillerDefendStringContainer
};

@protocol CrashKillerLogDelegate <NSObject>
@optional
- (void)onLog:(NSString*)log callStackSymbols:(NSArray <NSString *> *)callStackSymbols;

@end

@interface CrashKiller : NSObject

/**
 如果terminateWhenException设置为YES,发生异常时将终止应用程序
 如果terminateWhenException设置为NO，则该异常只显示在控制台上，不会停止应用程序
 Default value:NO
 */
@property(class,nonatomic,readwrite,assign)BOOL terminateWhenException;

/**是否打印崩溃日志
    YES:打印日志
    NO:不打印日志
    默认YES
 **/
@property(class,nonatomic,readwrite,assign)BOOL debugLog;

/*
 添加需要添加闪退防护的类型,默认CrashKillerDefendAll
 需要在startWihtLogDelegate方法前调用才会生效
 */
+ (void)configDefendCrashType:(CrashKillerDefendCrashType)type;

//开启崩溃防护
+ (void)startWihtLogDelegate:(id<CrashKillerLogDelegate>)logDelegate;

//关闭崩溃防护
+ (void)stop;

@end

