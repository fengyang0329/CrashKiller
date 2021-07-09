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
    id instance = nil;
    @try {
        instance = [self crashKiller_initWithObjects:objects forKeys:keys];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}

- (instancetype)crashKiller_initWithObjects:(const id _Nonnull [_Nullable])objects forKeys:(const id _Nonnull [_Nullable])keys count:(NSUInteger)cnt
{

    id instance = nil;
    @try {
        instance = [self crashKiller_initWithObjects:objects forKeys:keys count:cnt];
    } @catch (NSException *exception) {

        [[CrashKillerManager shareManager] printLogWithException:exception];
        //以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
        id  newObjects[cnt];
        id newKeys[cnt];
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; ++i) {
            if (objects[i] != nil && keys[i] != nil) {

                newKeys[index] = keys[i];
                newObjects[index] = objects[i];
                index++;
            }
        }
        instance = [self crashKiller_initWithObjects:newObjects forKeys:newKeys count:index];

    } @finally {
        return instance;
    }
}

#pragma mark 可变字典
- (void)crashKiller_setObject:(id)anObject forKey:(id <NSCopying>)aKey
{
    @try {
        [self crashKiller_setObject:anObject forKey:aKey];
    } @catch (NSException *exception) {

        [[CrashKillerManager shareManager] printLogWithException:exception];
    }
}

- (void)crashKiller_removeObjectForKey:(id)aKey
{
    @try {
        [self crashKiller_removeObjectForKey:aKey];
    } @catch (NSException *exception) {

        [[CrashKillerManager shareManager] printLogWithException:exception];
    }
}

@end
