//
//  NSMutableArray+KillCrash.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/4/14.
//

#import "NSMutableArray+KillCrash.h"
#import "NSObject+CrashKillerMethodSwizzling.h"


@implementation NSMutableArray (KillCrash)

+ (void)registerKillMutableArray
{
    /* 可变数组 */
    Class __NSArrayM = objc_getClass("__NSArrayM");
    Class __NSMutableArray = objc_getClass("NSMutableArray");
    /* 可变数组 __NSArrayM*/
    [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(insertObject:atIndex:) withMethod:@selector(crashKiller_insertObject:atIndex:) withClass:__NSArrayM];
    [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(removeObjectsInRange:) withMethod:@selector(crashKiller_removeObjectsInRange:) withClass:__NSArrayM];
    [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(replaceObjectAtIndex:withObject:) withMethod:@selector(crashKiller_replaceObjectAtIndex:withObject:) withClass:__NSArrayM];
    [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(objectAtIndex:) withMethod:@selector(crashKiller_objectAtIndex:) withClass:__NSArrayM];
    [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(objectAtIndexedSubscript:) withMethod:@selector(crashKiller_objectAtIndexedSubscript:) withClass:__NSArrayM];


    /* 可变数组 NSMutableArray*/
    [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(removeObject:inRange:) withMethod:@selector(crashKiller_removeObject:inRange:) withClass:__NSMutableArray];
    [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(removeObjectsAtIndexes:) withMethod:@selector(crashKiller_removeObjectsAtIndexes:) withClass:__NSMutableArray];
}

- (void)crashKiller_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    @try {
        [self crashKiller_insertObject:anObject atIndex:index];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    }
}

- (void)crashKiller_removeObjectsInRange:(NSRange)range
{
    @try {
        [self crashKiller_removeObjectsInRange:range];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    }
}

- (void)crashKiller_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    @try {
        [self crashKiller_replaceObjectAtIndex:index withObject:anObject];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    }
}

- (instancetype)crashKiller_objectAtIndex:(NSUInteger)index
{
    id instance = nil;
    @try {
        instance = [self crashKiller_objectAtIndex:index];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}

- (id)crashKiller_objectAtIndexedSubscript:(NSUInteger)idx
{
    id instance = nil;
    @try {
        instance = [self crashKiller_objectAtIndexedSubscript:idx];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    } @finally {
        return instance;
    }
}

- (void)crashKiller_removeObject:(id)anObject  inRange:(NSRange)range
{
    @try {
        [self crashKiller_removeObject:anObject inRange:range];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    }
}

- (void)crashKiller_removeObjectsAtIndexes:(NSIndexSet *)indexes
{
    @try {
        [self crashKiller_removeObjectsAtIndexes:indexes];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    }
}

@end
