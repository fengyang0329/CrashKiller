//
//  NSSet+KillCrash.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/7/8.
//

#import "NSSet+KillCrash.h"
#import "NSObject+CrashKillerMethodSwizzling.h"

@implementation NSSet (KillCrash)

+ (void)registerKillSet
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        /**
         __NSSingleObjectSetI 只有一个元素的集合      ( NSSet *set3 =  [[NSSet alloc]initWithObjects: @"1",nil]; )
         __NSPlaceholderSet 占位集合                ( NSSet *set2 =  [NSSet alloc]; )
         __NSSetI 初始化后的不可变集合                ( NSSet *set1 = [[NSSet alloc] init]; )
         */
        Class __NSPlaceholderSet = objc_getClass("__NSPlaceholderSet");
        Class __NSSet = objc_getClass("NSSet");

        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithObjects:count:) withMethod:@selector(crashKiller_initWithObjects:count:) withClass:__NSPlaceholderSet];

        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(setWithObject:) withMethod:@selector(crashKiller_setWithObject:) withClass:__NSSet];

    });
}

- (instancetype)crashKiller_initWithObjects:(const id _Nonnull [_Nullable])objects count:(NSUInteger)cnt
{
    /*
     reason: '*** -[__NSPlaceholderSet initWithObjects:count:]: attempt to insert nil object from objects[0]'*/
    id instance = nil;
    @try {
        instance = [self crashKiller_initWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {

        [[CrashKillerManager shareManager] printLogWithException:exception];
        //以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
        NSInteger newObjsIndex = 0;
        id   newObjects[cnt];
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self crashKiller_initWithObjects:newObjects count:newObjsIndex];
    }
    @finally {

        return instance;
    }
}

+ (instancetype)crashKiller_setWithObject:(id)object
{
    id set = nil;
    @try
    {
        set = [self crashKiller_setWithObject:object];
    }
    @catch (NSException *exception)
    {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    }
    @finally
    {
        return set;
    }
}


@end
