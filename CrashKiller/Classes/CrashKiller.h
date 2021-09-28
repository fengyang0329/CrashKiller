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
    CrashKillerDefendDictionaryContainer = 1 << 5,
    CrashKillerDefendArrayContainer = 1 << 6,
    CrashKillerDefendStringContainer = 1 << 7,
    CrashKillerDefendSetContainer = 1 << 8,
    CrashKillerDefendJSONSerialization = 1 << 9,
    CrashKillerDefendNSFileManager = 1 << 10,
    CrashKillerDefendNSFileHandle = 1 << 11,
    CrashKillerDefendDataContainer = 1 << 12,
    CrashKillerDefendAll = CrashKillerDefendUnrecognizedSelector | CrashKillerDefendKVC | CrashKillerDefendKVO | CrashKillerDefendNSTimer | CrashKillerDefendDictionaryContainer | CrashKillerDefendArrayContainer | CrashKillerDefendStringContainer | CrashKillerDefendSetContainer | CrashKillerDefendJSONSerialization | CrashKillerDefendNSFileManager | CrashKillerDefendNSFileHandle | CrashKillerDefendDataContainer
};

@protocol CrashKillerLogDelegate <NSObject>
@optional
- (void)onLog:(NSException *)exception;

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

/*
 类名白名单
 白名单里的类中方法不做处理，相当于这个类关闭了CrashKillerDefendUnrecognizedSelector防护功能
 [CrashKiller addSelectorClassWhiteList:@[NSClassFromString(@"MAUserLocation")]];
 */
+ (void)addSelectorClassWhiteList:(NSArray*)objects;

/*开启崩溃防护
 已经开启的情况下，再次调用直接return
*/
+ (void)start;


/*
 打印log的回调代理
 建议在start方法前调用，否则可能会有部分日志缺失
 */
+ (void)handleCrashLog:(id<CrashKillerLogDelegate>)logDelegate;


@end

