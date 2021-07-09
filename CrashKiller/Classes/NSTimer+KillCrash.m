//
//  NSTimer+KillCrash.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/4/2.
//

#import "NSTimer+KillCrash.h"
#import "NSObject+CrashKillerMethodSwizzling.h"

/**
 Copy the NSTimer Info
 */
@interface StubTimerObject : NSObject

@property(nonatomic,readwrite,assign)NSTimeInterval time;

/**
 weak reference target
 */
@property(nonatomic,readwrite,weak)id target;

@property(nonatomic,readwrite,assign)SEL selector;

@property(nonatomic,readwrite,assign)id userInfo;

/**
 TimerObject Associated NSTimer
 */
@property(nonatomic,readwrite,weak)NSTimer* timer;

/**
 Record the target class name
 */
@property(nonatomic,readwrite,copy)NSString* targetClassName;

/**
 Record the target method name
 */
@property(nonatomic,readwrite,copy)NSString* targetMethodName;

@end


@implementation StubTimerObject

- (void)fireTimer{
    if (!self.target) {
        [self.timer invalidate];
        self.timer = nil;
        NSString *reason = [NSString stringWithFormat:@"Need invalidate timer from target:%@ method:%@",self.targetClassName,self.targetMethodName];
        [[CrashKillerManager shareManager] throwExceptionWithName:@"NSInvalidArgumentException" reason:reason];
        return;
    }
    if ([self.target respondsToSelector:self.selector]) {
        // Fix performSelector maybe some memmory leak or return object crash
        NSMethodSignature* signature = [self.target methodSignatureForSelector:self.selector];
        if (!signature) {
            return;
        }
        NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.target = self.target;
        invocation.selector = self.selector;
        if (signature.numberOfArguments > 2) {
            [invocation setArgument:&_timer atIndex:2];
        }
        [invocation retainArguments];
        [invocation invoke];
    }
}

@end


@implementation NSTimer (KillCrash)

+ (void)registerKillTimer
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [NSObject crashKillerMethodSwizzlingClassMethod:@selector(scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:)
                                             withMethod:@selector(crashKiller_scheduledTimerWithTimeInterval:target:selector:userInfo:repeats:)
                                              withClass:[NSTimer class]];
    });

}

+ (NSTimer*)crashKiller_scheduledTimerWithTimeInterval:(NSTimeInterval)time target:(id)aTarget selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)yesOrNo{

    if (!yesOrNo) {
        return [self crashKiller_scheduledTimerWithTimeInterval:time target:aTarget selector:aSelector userInfo:userInfo repeats:yesOrNo];
    }
    StubTimerObject* timerObject = [StubTimerObject new];
    timerObject.time = time;
    timerObject.target = aTarget;
    timerObject.selector = aSelector;
    timerObject.userInfo = userInfo;
    if (aTarget) {
        timerObject.targetClassName = [NSString stringWithCString:object_getClassName(aTarget) encoding:NSASCIIStringEncoding];
    }
    timerObject.targetMethodName = NSStringFromSelector(aSelector);
    NSTimer* timer = [NSTimer crashKiller_scheduledTimerWithTimeInterval:time target:timerObject selector:@selector(fireTimer) userInfo:userInfo repeats:yesOrNo];
    timerObject.timer = timer;

    return timer;

}

@end
