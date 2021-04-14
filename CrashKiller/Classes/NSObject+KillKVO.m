//
//  NSObject+KillKVO.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/4/1.
//

#import "NSObject+KillKVO.h"
#import "NSObject+CrashKillerMethodSwizzling.h"


@interface CrashKillerKVOProxy : NSObject

- (NSArray *)getAllKeyPaths;

@end

@implementation CrashKillerKVOProxy
{
    // 关系数据表结构：{keypath : [observer1, observer2 , ...](NSHashTable)}
@private
    NSMutableDictionary<NSString *, NSHashTable<NSObject *> *> *_kvoInfoMap;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _kvoInfoMap = [NSMutableDictionary dictionary];
    }
    return self;
}

// 添加 KVO 信息操作, 添加成功返回 YES
- (BOOL)addInfoToMapWithObserver:(NSObject *)observer
                      forKeyPath:(NSString *)keyPath
                         options:(NSKeyValueObservingOptions)options
                         context:(void *)context {

    @synchronized (self) {
        if (!observer || !keyPath ||
            ([keyPath isKindOfClass:[NSString class]] && keyPath.length <= 0)) {
            return NO;
        }

        NSHashTable<NSObject *> *info = _kvoInfoMap[keyPath];
        if (info.count == 0) {
            info = [[NSHashTable alloc] initWithOptions:(NSPointerFunctionsWeakMemory) capacity:0];
            [info addObject:observer];

            _kvoInfoMap[keyPath] = info;

            return YES;
        }

        if (![info containsObject:observer]) {
            [info addObject:observer];
        }

        return NO;
    }
}

// 移除 KVO 信息操作, 添加成功返回 YES
- (BOOL)removeInfoInMapWithObserver:(NSObject *)observer
                         forKeyPath:(NSString *)keyPath {

    @synchronized (self) {
        if (!observer || !keyPath ||
            ([keyPath isKindOfClass:[NSString class]] && keyPath.length <= 0)) {
            return NO;
        }

        NSHashTable<NSObject *> *info = _kvoInfoMap[keyPath];

        if (info.count == 0) {
            return NO;
        }

        [info removeObject:observer];

        if (info.count == 0) {
            [_kvoInfoMap removeObjectForKey:keyPath];

            return YES;
        }

        return NO;
    }
}

// 添加 KVO 信息操作, 添加成功返回 YES
- (BOOL)removeInfoInMapWithObserver:(NSObject *)observer
                         forKeyPath:(NSString *)keyPath
                            context:(void *)context {
    @synchronized (self) {
        if (!observer || !keyPath ||
            ([keyPath isKindOfClass:[NSString class]] && keyPath.length <= 0)) {
            return NO;
        }

        NSHashTable<NSObject *> *info = _kvoInfoMap[keyPath];

        if (info.count == 0) {
            return NO;
        }

        [info removeObject:observer];

        if (info.count == 0) {
            [_kvoInfoMap removeObjectForKey:keyPath];

            return YES;
        }

        return NO;
    }
}

// 实际观察者 yscKVOProxy 进行监听，并分发
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {

    NSHashTable<NSObject *> *info = _kvoInfoMap[keyPath];
    for (NSObject *observer in info) {
        @try {
            [observer observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        } @catch (NSException *exception) {

            /*
             reason: '<CrashObject: 0x600002871680>: An -observeValueForKeyPath:ofObject:change:context: message was received but not handled.
             Key path: title
             Observed object: <TestKVOCrashVC: 0x7fbb9500f830>
             Change: {
                 kind = 1;
                 new = 111;
             }
             Context: 0x0'
             */
            [[CrashKillerManager shareManager] printLogWithFunction:nil reason:[exception description] callStackSymbols:[NSThread callStackSymbols]];
        }
    }
}

// 获取所有被观察的 keypaths
- (NSArray *)getAllKeyPaths {
    NSArray <NSString *>*keyPaths = _kvoInfoMap.allKeys;
    return keyPaths;
}
@end


@implementation NSObject (KillKVO)

+ (void)registerKillKVO
{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        // 拦截 `addObserver:forKeyPath:options:context:` 方法，替换自定义实现
        [NSObject crashKillerMethodSwizzlingInstanceMethod: @selector(addObserver:forKeyPath:options:context:)
                                                withMethod: @selector(crashKiller_addObserver:forKeyPath:options:context:)
                                                 withClass: [NSObject class]];

//        // 拦截 `removeObserver:forKeyPath:` 方法，替换自定义实现
        [NSObject crashKillerMethodSwizzlingInstanceMethod: @selector(removeObserver:forKeyPath:)
                                                withMethod: @selector(crashKiller_removeObserver:forKeyPath:)
                                                 withClass: [NSObject class]];
//
        // 拦截 `removeObserver:forKeyPath:context:` 方法，替换自定义实现
        [NSObject crashKillerMethodSwizzlingInstanceMethod: @selector(removeObserver:forKeyPath:context:)
                                                withMethod: @selector(crashKiller_removeObserver:forKeyPath:context:)
                                                 withClass: [NSObject class]];
//
//        // 拦截 `dealloc` 方法，替换自定义实现
        [NSObject crashKillerMethodSwizzlingInstanceMethod: NSSelectorFromString(@"dealloc")
                                                withMethod: @selector(crashKiller_kvodealloc)
                                                 withClass: [NSObject class]];
    });
}

static void *CrashKillerKVOProxyKey = &CrashKillerKVOProxyKey;
static NSString *const CrashKillerKVODefenderValue = @"CrashKiller_KVODefender";
static void *CrashKillerKVODefenderKey = &CrashKillerKVODefenderKey;

- (void)setCrashKillerKVOProxy:(CrashKillerKVOProxy *)kvoProxy
{
    objc_setAssociatedObject(self, CrashKillerKVOProxyKey, kvoProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (CrashKillerKVOProxy *)crashKillerKVOProxy
{
    id crashKillerKVOProxy = objc_getAssociatedObject(self, CrashKillerKVOProxyKey);
    if (crashKillerKVOProxy == nil) {
        crashKillerKVOProxy = [[CrashKillerKVOProxy alloc] init];
        self.crashKillerKVOProxy = crashKillerKVOProxy;
        }
    return crashKillerKVOProxy;
}



// 自定义 addObserver:forKeyPath:options:context: 实现方法
- (void)crashKiller_addObserver:(NSObject *)observer
                     forKeyPath:(NSString *)keyPath
                        options:(NSKeyValueObservingOptions)options
                        context:(void *)context {

    if (!isSystemClass(self.class)) {
        objc_setAssociatedObject(self, CrashKillerKVODefenderKey, CrashKillerKVODefenderValue, OBJC_ASSOCIATION_RETAIN);
        if ([self.crashKillerKVOProxy addInfoToMapWithObserver:observer forKeyPath:keyPath options:options context:context]) {
            // 如果添加 KVO 信息操作成功，则调用系统添加方法
            [self crashKiller_addObserver:self.crashKillerKVOProxy forKeyPath:keyPath options:options context:context];
        } else {
            // 添加 KVO 信息操作失败：重复添加
            NSString *reason = [NSString stringWithFormat:@"KVO Warning : Repeated additions to the observer:%@ for the key path:'%@' from %@",
                                observer, keyPath, self];
            if (!observer || !keyPath ||
                ([keyPath isKindOfClass:[NSString class]] && keyPath.length <= 0)) {

                reason = [NSString stringWithFormat:@"*** Crash Message: Cannot add an observer:%@ for the key path:'%@' from %@",
                          observer, keyPath, self];
            }
            [[CrashKillerManager shareManager] printLogWithFunction:nil reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return;
        }
    } else {
        [self crashKiller_addObserver:observer forKeyPath:keyPath options:options context:context];
    }
}

// 自定义 removeObserver:forKeyPath:context: 实现方法
- (void)crashKiller_removeObserver:(NSObject *)observer
                        forKeyPath:(NSString *)keyPath
                           context:(void *)context {

    if (!isSystemClass(self.class)) {
        if ([self.crashKillerKVOProxy removeInfoInMapWithObserver:observer forKeyPath:keyPath context:context]) {
            // 如果移除 KVO 信息操作成功，则调用系统移除方法
            [self crashKiller_removeObserver:self.crashKillerKVOProxy forKeyPath:keyPath context:context];
        } else {
            // 移除 KVO 信息操作失败：移除了未注册的观察者
            NSString *reason = [NSString stringWithFormat:@"Cannot remove an observer %@ for the key path '%@' from %@ because it is not registered as an observer.",observer,keyPath,self];
            [[CrashKillerManager shareManager] printLogWithFunction:nil reason:reason callStackSymbols:[NSThread callStackSymbols]];
        }
    } else {
        [self crashKiller_removeObserver:observer forKeyPath:keyPath context:context];
    }
}

// 自定义 removeObserver:forKeyPath: 实现方法
- (void)crashKiller_removeObserver:(NSObject *)observer
                        forKeyPath:(NSString *)keyPath {

    if (!isSystemClass(self.class)) {
        if ([self.crashKillerKVOProxy removeInfoInMapWithObserver:observer forKeyPath:keyPath]) {
            // 如果移除 KVO 信息操作成功，则调用系统移除方法
            [self crashKiller_removeObserver:self.crashKillerKVOProxy forKeyPath:keyPath];
        } else {
            // 移除 KVO 信息操作失败：移除了未注册的观察者
            /*
             reason: 'Cannot remove an observer <TestKVOCrashVC 0x7f8ac370cd90> for the key path "name" from <CrashObject 0x600000b84fe0> because it is not registered as an observer.'
             */
            NSString *reason = [NSString stringWithFormat:@"Cannot remove an observer %@ for the key path '%@' from %@ because it is not registered as an observer.",observer,keyPath,self];
            [[CrashKillerManager shareManager] printLogWithFunction:nil reason:reason callStackSymbols:[NSThread callStackSymbols]];
        }
    } else {
        [self crashKiller_removeObserver:observer forKeyPath:keyPath];
    }

}

// 自定义 dealloc 实现方法
- (void)crashKiller_kvodealloc {
    @autoreleasepool {
        if (!isSystemClass(self.class)) {
            NSString *value = (NSString *)objc_getAssociatedObject(self, CrashKillerKVODefenderKey);
            if ([value isEqualToString:CrashKillerKVODefenderValue]) {
                NSArray *keyPaths =  [self.crashKillerKVOProxy getAllKeyPaths];
                // 被观察者在 dealloc 时仍然注册着 KVO
                if (keyPaths.count > 0) {
                    NSString *reason = [NSString stringWithFormat:@"An instance %@ was deallocated while key value observers were still registered with it. The Keypaths is:'%@' ***", self, [keyPaths componentsJoinedByString:@","]];
                    [[CrashKillerManager shareManager] printLogWithFunction:nil reason:reason callStackSymbols:[NSThread callStackSymbols]];
                }
                // 移除多余的观察者
                for (NSString *keyPath in keyPaths) {
                    [self crashKiller_removeObserver:self.crashKillerKVOProxy forKeyPath:keyPath];
                }
            }
        }
    }
    [self crashKiller_kvodealloc];
}


@end


