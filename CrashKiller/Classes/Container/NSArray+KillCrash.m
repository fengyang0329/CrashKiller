//
//  NSArray+KillCrash.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/4/2.
//

#import "NSArray+KillCrash.h"
#import "NSObject+CrashKillerMethodSwizzling.h"

@implementation NSArray (KillCrash)

+ (void)registerKillArray
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        /**
         __NSArray0 仅仅初始化后不含有元素的数组          ( NSArray *arr2 =  [[NSArray alloc]init]; )
         __NSSingleObjectArrayI 只有一个元素的数组      ( NSArray *arr3 =  [[NSArray alloc]initWithObjects: @"1",nil]; )
         __NSPlaceholderArray 占位数组                ( NSArray *arr4 =  [NSArray alloc]; )
         __NSArrayI 初始化后的不可变数组                ( NSArray *arr1 =  @[@"1",@"2"]; )
         */
        Class __NSArray = objc_getClass("NSArray");
        Class __NSArrayI = objc_getClass("__NSArrayI");
        Class __NSArray0 = objc_getClass("__NSArray0");
        Class __NSPlaceholderArray = objc_getClass("__NSPlaceholderArray");
        Class __NSSingleObjectArrayI = objc_getClass("__NSSingleObjectArrayI");


        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithObjects:count:) withMethod:@selector(crashKiller_initWithObjects:count:) withClass:__NSPlaceholderArray];
        /* 数组为空 */
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(objectAtIndex:) withMethod:@selector(crashKiller_NSArray0ObjectAtIndex:) withClass:__NSArray0];
        /* 数组count == 1 */
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(objectAtIndex:) withMethod:@selector(crashKiller_SingleIObjectAtIndex:) withClass:__NSSingleObjectArrayI];
        /* 数组count >= 2 */
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(objectAtIndex:) withMethod:@selector(crashKiller_NSArrayIObjectAtIndex:) withClass:__NSArrayI];

        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(arrayByAddingObject:) withMethod:@selector(crashKiller_arrayByAddingObject:) withClass:__NSArray];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(subarrayWithRange:) withMethod:@selector(crashKiller_subarrayWithRange:) withClass:__NSArray];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(objectsAtIndexes:) withMethod:@selector(crashKiller_objectsAtIndexes:) withClass:__NSArray];
    });
}

- (instancetype)crashKiller_initWithObjects:(const id  _Nonnull  __unsafe_unretained *)objects count:(NSUInteger)cnt
{
    id instance = nil;
    @try {
        instance = [self crashKiller_initWithObjects:objects count:cnt];
    } @catch (NSException *exception) {

        [[CrashKillerManager shareManager] printLogWithException:exception];
        //过滤掉值为nil的元素
        id __unsafe_unretained newObjects[cnt];
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; ++i) {
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
            }
        }
        instance = [self crashKiller_initWithObjects:newObjects count:index];
    } @finally {
        return instance;
    }
}

- (instancetype)crashKiller_NSArray0ObjectAtIndex:(NSUInteger)index
{
    id instance = nil;
    @try {
        instance = [self crashKiller_NSArray0ObjectAtIndex:index];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}

- (instancetype)crashKiller_NSArrayIObjectAtIndex:(NSUInteger)index
{
    id instance = nil;
    @try {
        instance = [self crashKiller_NSArrayIObjectAtIndex:index];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}

- (instancetype)crashKiller_SingleIObjectAtIndex:(NSUInteger)index
{
    id instance = nil;
    @try {
        instance = [self crashKiller_SingleIObjectAtIndex:index];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}

- (instancetype)crashKiller_arrayByAddingObject:(id)anObject
{
    id instance = nil;
    @try {
        instance = [self crashKiller_arrayByAddingObject:anObject];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}

- (instancetype)crashKiller_subarrayWithRange:(NSRange)range
{
    id instance = nil;
    @try {
        instance = [self crashKiller_subarrayWithRange:range];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}


- (instancetype)crashKiller_objectsAtIndexes:(NSIndexSet *)indexes
{
    id instance = nil;
    @try {
        instance = [self crashKiller_objectsAtIndexes:indexes];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}


@end
