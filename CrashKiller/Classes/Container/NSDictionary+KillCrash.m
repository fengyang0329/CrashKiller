//
//  NSDictionary+KillCrash.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/4/2.
//

#import "NSDictionary+KillCrash.h"
#import "NSObject+CrashKillerMethodSwizzling.h"

@implementation NSDictionary (KillCrash)

+ (void)registerKillDictionary
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithObjects:forKeys:) withMethod:@selector(crashKiller_initWithObjects:forKeys:) withClass:[NSDictionary class]];

        /* 占位字典 NSDictionary *dic = [NSDictionary dictionary];*/
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithObjects:forKeys:count:) withMethod:@selector(crashKiller_initWithObjects:forKeys:count:) withClass:objc_getClass("__NSPlaceholderDictionary")];

        /*可变字典*/
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(setObject:forKey:) withMethod:@selector(crashKiller_setObject:forKey:) withClass:objc_getClass("__NSDictionaryM")];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(removeObjectForKey:) withMethod:@selector(crashKiller_removeObjectForKey:) withClass:objc_getClass("__NSDictionaryM")];
    });
}
- (instancetype)crashKiller_initWithObjects:(NSArray<id> *)objects forKeys:(NSArray<id <NSCopying>> *)keys
{
    NSString *func;
    NSString * reason;
    if (objects.count != keys.count) {

        /*
         reason: '*** -[NSDictionary initWithObjects:forKeys:]: count of objects (2) differs from count of keys (1)'
         */
        func = @"[NSDictionary initWithObjects:forKeys:]";
        reason = [NSString stringWithFormat:@"count of objects (%zi) differs from count of keys (%zi)",objects.count,keys.count];
        [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        return nil;
    }
    return [self crashKiller_initWithObjects:objects forKeys:keys];
}

- (instancetype)crashKiller_initWithObjects:(const id _Nonnull [_Nullable])objects forKeys:(const id _Nonnull [_Nullable])keys count:(NSUInteger)cnt
{
    BOOL hasNilObject = NO;
    for (NSUInteger i = 0; i < cnt; i++) {

        /*
         reason: '*** -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[0]'
         */
        if (keys[i]==nil || objects[i] == nil) {
            hasNilObject = YES;
            NSString *func = @"[__NSPlaceholderDictionary initWithObjects:forKeys:count:]";
            NSString *reason = [NSString stringWithFormat:@"attempt to insert nil object from objects[%zi]",i];
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            break;
        }
    }
    BOOL resultIsNil = YES;
    if (hasNilObject) {
        id  newObjects[cnt];
        id newKeys[cnt];
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; ++i) {
            if (objects[i] != nil && keys[i] != nil) {

                newKeys[index] = keys[i];
                newObjects[index] = objects[i];
                index++;
                resultIsNil = NO;
            }
        }
        if (resultIsNil) {

            return  nil;
        }
        return [self crashKiller_initWithObjects:newObjects forKeys:newKeys count:index];;
    }
    return [self crashKiller_initWithObjects:objects forKeys:keys count:cnt];
}

#pragma mark 可变字典
- (void)crashKiller_setObject:(id)anObject forKey:(id <NSCopying>)aKey
{

    @synchronized (self) {

        NSString *func = @"[__NSDictionaryM setObject:forKey:]";
        NSString *reason;
        if (!anObject) {

            /*
             reason: '*** -[__NSDictionaryM setObject:forKey:]: object cannot be nil (key: ff)'
             */
            reason = [NSString stringWithFormat:@"object cannot be nil (key: %@)",aKey];
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return;
        }
        if (!aKey) {

            /*
             reason: '*** -[__NSDictionaryM setObject:forKey:]: key cannot be nil'
             */
            reason = @"key cannot be nil";
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return;
        }
        [self crashKiller_setObject:anObject forKey:aKey];
    }
}

- (void)crashKiller_removeObjectForKey:(id)aKey
{
    @synchronized (self) {

        NSString *func = @"[__NSDictionaryM removeObjectForKey:]";
        if (!aKey) {

            /*
             reason: '*** -[__NSDictionaryM removeObjectForKey:]: key cannot be nil'
             */
            NSString *reason = @"key cannot be nil";
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return;
        }
        [self crashKiller_removeObjectForKey:aKey];
    }
}

@end
