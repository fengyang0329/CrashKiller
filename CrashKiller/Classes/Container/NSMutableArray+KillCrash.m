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

    /* 可变数组 NSMutableArray*/
    [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(removeObject:inRange:) withMethod:@selector(crashKiller_removeObject:inRange:) withClass:__NSMutableArray];
    [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(removeObjectsAtIndexes:) withMethod:@selector(crashKiller_removeObjectsAtIndexes:) withClass:__NSMutableArray];
}

- (void)crashKiller_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    @synchronized (self) {
        NSString *func = @"[__NSArrayM insertObject:atIndex:]";
        NSString *reason;
        if (anObject == nil) {

            /*
             reason: '*** -[__NSArrayM insertObject:atIndex:]: object cannot be nil'
             */
            reason = @"object cannot be nil";
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        }
        else if (index > self.count) {

            /*
             reason: '*** -[__NSArrayM insertObject:atIndex:]: index 6 beyond bounds [0 .. 2]'
             */
            reason = [NSString stringWithFormat:@"index %zi beyond bounds [0 .. %zi]",index,self.count];
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        }
        else {
            [self crashKiller_insertObject:anObject atIndex:index];
        }
    }
}

- (void)crashKiller_removeObjectsInRange:(NSRange)range
{
    @synchronized (self) {
        NSString *func = @"[__NSArrayM removeObjectsInRange:]";
        NSString *reason;
        if (self.count == 0) {

            /*
             reason: '*** -[__NSArrayM removeObjectsInRange:]: range {5, 1} extends beyond bounds for empty array'
             */
            reason = [NSString stringWithFormat:@"range {%zi, %zi} extends beyond bounds for empty array",range.location,range.length];
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return;
        }
        if (range.length <=0 || self.count < range.location+range.length) {

            /*
             reason: '*** -[__NSArrayM removeObjectsInRange:]: range {5, 1} extends beyond bounds [0 .. 1]'
             */
            reason = [NSString stringWithFormat:@"range {%zi, %zi} extends beyond bounds [0..%zi]",range.location,range.length,self.count];
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return;
        }
        return [self crashKiller_removeObjectsInRange:range];
    }
}

- (void)crashKiller_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    @synchronized (self) {
        NSString *func = @"[__NSArrayM replaceObjectAtIndex:withObject:]";
        NSString *reason;
        if (!anObject) {

            /*
             reason: '*** -[__NSArrayM replaceObjectAtIndex:withObject:]: object cannot be nil'
             */
            reason = @"object cannot be nil";
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return;
        }
        if (index > self.count) {

            /*
             reason: '*** -[__NSArrayM replaceObjectAtIndex:withObject:]: index 4 beyond bounds [0 .. 0]'
             */
            reason = [NSString stringWithFormat:@"index %zi beyond bounds [0 .. %zi]",index,self.count];
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return;
        }
        [self crashKiller_replaceObjectAtIndex:index withObject:anObject];
    }
}

- (instancetype)crashKiller_objectAtIndex:(NSUInteger)index
{
    @synchronized (self) {
        if ([self crashWhenObjectAtIndex:index function:@"[__NSArrayM objectAtIndex:]"]) {

            return nil;
        }
        return [self crashKiller_objectAtIndex:index];
    }
}

- (BOOL)crashWhenObjectAtIndex:(NSUInteger)index function:(NSString *)func
{
    NSString *reason;
    if (self.count == 0) {

        reason = [NSString stringWithFormat:@"index %zi beyond bounds for empty NSArray",index];
        [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        return YES;
    }
    if (index > self.count) {

        reason = [NSString stringWithFormat:@"__boundsFail: index %zi beyond bounds [0 .. %zi]",index,self.count];
        [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        return YES;
    }
    return NO;
}


- (void)crashKiller_removeObject:(id)anObject  inRange:(NSRange)range
{
    @synchronized (self) {
        NSString *func = @"[NSMutableArray removeObject:inRange:]";
        NSString *reason;
        if (self.count == 0) {

            /*
             reason: '*** -[NSMutableArray removeObject:inRange:]: range {5, 8} extends beyond bounds for empty array'
             */
            reason = [NSString stringWithFormat:@"range {%zi, %zi} extends beyond bounds for empty array",range.location,range.length];
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return;
        }
        if (self.count < range.location+range.length) {

            /*
             reason: '*** -[NSMutableArray removeObject:inRange:]: range {0, 5} extends beyond bounds [0 .. 1]'
             */
            reason = [NSString stringWithFormat:@"range {%zi, %zi} extends beyond bounds [0 .. %zi]",range.location,range.length,self.count];
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return;
        }
        [self crashKiller_removeObject:anObject inRange:range];
    }
}

- (void)crashKiller_removeObjectsAtIndexes:(NSIndexSet *)indexes
{
    @synchronized (self) {
        NSString *func = @"[NSMutableArray removeObjectsAtIndexes:]";
        NSString *reason;
        if (self.count == 0) {

            /*
             reason: '*** -[NSMutableArray removeObjectsAtIndexes:]: index 10 in index set beyond bounds for empty array'
             */
            reason = [NSString stringWithFormat:@"index %zi in index set beyond bounds for empty array",indexes.firstIndex];
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return;
        }
        if (!indexes) {

            /*
             reason: '*** -[NSMutableArray removeObjectsAtIndexes:]: index set cannot be nil'
             */
            reason = @"index set cannot be nil";
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return ;
        }
        if (indexes.count && indexes.lastIndex >= self.count) {

            /*
             reason: '*** -[NSMutableArray removeObjectsAtIndexes:]: index 99 in index set beyond bounds [0 .. 1]'
             */
            reason = [NSString stringWithFormat:@"index %zi in index set beyond bounds [0 .. %zi]",indexes.lastIndex,self.count];
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return ;
        }
        [self crashKiller_removeObjectsAtIndexes:indexes];
    }
}
@end
