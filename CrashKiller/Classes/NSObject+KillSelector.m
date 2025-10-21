//
//  NSObject+KillSelector.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/3/29.
//

#import "NSObject+KillSelector.h"
#import "NSObject+CrashKillerMethodSwizzling.h"

@implementation NSObject (KillSelector)

+ (void)registerKillSelector
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 拦截 `+forwardingTargetForSelector:` 方法，替换自定义实现
        [NSObject crashKillerMethodSwizzlingClassMethod:@selector(forwardingTargetForSelector:)
                                             withMethod:@selector(crashKiller_forwardingTargetForSelector:)
                                              withClass:[NSObject class]];
        
        // 拦截 `-forwardingTargetForSelector:` 方法，替换自定义实现
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(forwardingTargetForSelector:)
                                                withMethod:@selector(crashKiller_forwardingTargetForSelector:)
                                                 withClass:[NSObject class]];
    });
}


+ (id)crashKiller_forwardingTargetForSelector:(SEL)aSelector {
    
    if (isSystemClass([self class])) {
        return [self crashKiller_forwardingTargetForSelector:aSelector];
    }
    // 白名单
    if ([[CrashKillerManager shareManager].selectorClassWhiteList containsObject:[self class]]) {
        return [self crashKiller_forwardingTargetForSelector:aSelector];
    }
    
    // 创建一个新类
    NSString *errClassName = NSStringFromClass([self class]);
    NSString *errSel = NSStringFromSelector(aSelector);
    
    NSString *reason = [NSString stringWithFormat:@"-[%@ %@]: unrecognized selector sent to class %p",errClassName,errSel,self];
    [[CrashKillerManager shareManager] throwExceptionWithName:@"NSInvalidArgumentException" reason:reason];
    
    NSString *className = @"CrashClass";
    Class crashCls = NSClassFromString(className);
    
    // 如果类不存在 动态创建一个类
    if (!crashCls) {
        crashCls = objc_allocateClassPair([NSObject class], className.UTF8String, 0);
        // 注册类
        objc_registerClassPair(crashCls);
    }
    
    // 动态添加方法到 meta-class
    Class metaCls = object_getClass(crashCls);
    if (!class_getInstanceMethod(metaCls, aSelector)) {
        class_addMethod(metaCls, aSelector, (IMP)CrashIMP, "@@:@");
    }
    // 把消息转发到当前动态生成类的实例对象上
    return [[crashCls alloc] init];
}


- (id)crashKiller_forwardingTargetForSelector:(SEL)aSelector {
    
    if (isSystemClass([self class])) {
        return [self crashKiller_forwardingTargetForSelector:aSelector];
    }
    if ([[CrashKillerManager shareManager].selectorClassWhiteList containsObject:[self class]]) {
        return [self crashKiller_forwardingTargetForSelector:aSelector];
    }

    // 创建一个新类
    NSString *errClassName = NSStringFromClass([self class]);
    NSString *errSel = NSStringFromSelector(aSelector);
    
    NSString *reason = [NSString stringWithFormat:@"-[%@ %@]: unrecognized selector sent to instance %p",errClassName,errSel,self];
    [[CrashKillerManager shareManager] throwExceptionWithName:@"NSInvalidArgumentException" reason:reason];
    
    NSString *className = @"CrashClass";
    Class crashCls = NSClassFromString(className);
    // 如果类不存在 动态创建一个类
    if (!crashCls) {
        crashCls = objc_allocateClassPair([NSObject class], className.UTF8String, 0);
        // 注册类
        objc_registerClassPair(crashCls);
    }
    // 如果类没有对应的方法，则动态添加一个
    if (!class_getInstanceMethod(crashCls, aSelector)) {
        class_addMethod(crashCls, aSelector, (IMP)CrashIMP, "@@:@");
    }
    // 把消息转发到当前动态生成类的实例对象上
    return [[crashCls alloc] init];
}

// 动态添加的方法实现
static int CrashIMP(id slf, SEL selector) {
    return 0;
}
@end
