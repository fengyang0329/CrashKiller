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
    SEL forwarding_sel = @selector(forwardingTargetForSelector:);

    // 获取 NSObject 的消息转发方法
    Method root_forwarding_method = class_getClassMethod([NSObject class], forwarding_sel);
    // 获取 当前类 的消息转发方法
    Method current_forwarding_method = class_getClassMethod([self class], forwarding_sel);
    // 判断当前类本身是否实现第二步:消息接受者重定向
    BOOL realize = method_getImplementation(current_forwarding_method) != method_getImplementation(root_forwarding_method);
    // 如果没有实现第二步:消息接受者重定向
    if (!realize) {
        // 判断有没有实现第三步:消息重定向
        SEL methodSignature_sel = @selector(methodSignatureForSelector:);
        Method root_methodSignature_method = class_getClassMethod([NSObject class], methodSignature_sel);

        Method current_methodSignature_method = class_getClassMethod([self class], methodSignature_sel);
        realize = method_getImplementation(current_methodSignature_method) != method_getImplementation(root_methodSignature_method);

        // 如果没有实现第三步:消息重定向
        if (!realize) {
            // 创建一个新类
            NSString *errClassName = NSStringFromClass([self class]);
            NSString *errSel = NSStringFromSelector(aSelector);

            NSString *func = [NSString stringWithFormat:@"[%@ %@]",errClassName,errSel];
            NSString *reason = [NSString stringWithFormat:@"unrecognized selector sent to class %p",self];
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];

            NSString *className = @"CrachClass";
            Class cls = NSClassFromString(className);

            // 如果类不存在 动态创建一个类
            if (!cls) {
                Class superClsss = [NSObject class];
                cls = objc_allocateClassPair(superClsss, className.UTF8String, 0);
                // 注册类
                objc_registerClassPair(cls);
            }
            // 如果类没有对应的方法，则动态添加一个
            if (!class_getInstanceMethod(NSClassFromString(className), aSelector)) {
                class_addMethod(cls, aSelector, (IMP)CrashIMP, "@@:@");
            }
            // 把消息转发到当前动态生成类的实例对象上
            return [[cls alloc] init];
        }
    }
    return [self crashKiller_forwardingTargetForSelector:aSelector];
}

- (id)crashKiller_forwardingTargetForSelector:(SEL)aSelector {

    SEL forwarding_sel = @selector(forwardingTargetForSelector:);
    // 获取 NSObject 的消息转发方法
    Method root_forwarding_method = class_getInstanceMethod([NSObject class], forwarding_sel);
    // 获取 当前类 的消息转发方法
    Method current_forwarding_method = class_getInstanceMethod([self class], forwarding_sel);
    // 判断当前类本身是否实现第二步:消息接受者重定向
    BOOL realize = method_getImplementation(current_forwarding_method) != method_getImplementation(root_forwarding_method);

    // 如果没有实现第二步:消息接受者重定向
    if (!realize) {
        // 判断有没有实现第三步:消息重定向
        SEL methodSignature_sel = @selector(methodSignatureForSelector:);
        Method root_methodSignature_method = class_getInstanceMethod([NSObject class], methodSignature_sel);

        Method current_methodSignature_method = class_getInstanceMethod([self class], methodSignature_sel);
        realize = method_getImplementation(current_methodSignature_method) != method_getImplementation(root_methodSignature_method);

        // 如果没有实现第三步:消息重定向
        if (!realize) {
            // 创建一个新类
            NSString *errClassName = NSStringFromClass([self class]);
            NSString *errSel = NSStringFromSelector(aSelector);
            
            NSString *func = [NSString stringWithFormat:@"[%@ %@]",errClassName,errSel];
            NSString *reason = [NSString stringWithFormat:@"unrecognized selector sent to instance %p",self];
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];


            NSString *className = @"CrachClass";
            Class cls = NSClassFromString(className);
            // 如果类不存在 动态创建一个类
            if (!cls) {
                Class superClsss = [NSObject class];
                cls = objc_allocateClassPair(superClsss, className.UTF8String, 0);
                // 注册类
                objc_registerClassPair(cls);
            }
            // 如果类没有对应的方法，则动态添加一个
            if (!class_getInstanceMethod(NSClassFromString(className), aSelector)) {
                class_addMethod(cls, aSelector, (IMP)CrashIMP, "@@:@");
            }
            // 把消息转发到当前动态生成类的实例对象上
            return [[cls alloc] init];
        }
    }
    return [self crashKiller_forwardingTargetForSelector:aSelector];
}

// 动态添加的方法实现
static int CrashIMP(id slf, SEL selector) {
    return 0;
}
@end
