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
    /*
     reason: '*** -[__NSPlaceholderArray initWithObjects:count:]: attempt to insert nil object from objects[0]'*/
    BOOL resultIsNil = YES;
    BOOL hasNilObject = NO;
    for (NSUInteger i = 0; i < cnt; i++) {

        if (objects[i] == nil) {
            hasNilObject = YES;
            NSString *func = @"[__NSPlaceholderArray initWithObjects:count:]";
            NSString *reason = [NSString stringWithFormat:@"attempt to insert nil object from objects[%zi]",i];
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            break;
        }
    }
    //过滤掉值为nil的元素
    if (hasNilObject) {
        id __unsafe_unretained newObjects[cnt];
        NSUInteger index = 0;
        for (NSUInteger i = 0; i < cnt; ++i) {
            if (objects[i] != nil) {
                newObjects[index++] = objects[i];
                resultIsNil = NO;
            }
        }
        if (resultIsNil) {
            return nil;
        }
        return [self crashKiller_initWithObjects:newObjects count:index];
    }
    return [self crashKiller_initWithObjects:objects count:cnt];
}

- (instancetype)crashKiller_NSArray0ObjectAtIndex:(NSUInteger)index
{
    /*
     reason: '*** -[__NSArray0 objectAtIndex:]: index 3 beyond bounds for empty NSArray'
     */
    @synchronized (self) {
        if ([self crashWhenObjectAtIndex:index function:@"[__NSArray0 objectAtIndex:]"]) {

            return nil;
        }
        return [self crashKiller_NSArray0ObjectAtIndex:index];
    }
}

- (instancetype)crashKiller_NSArrayIObjectAtIndex:(NSUInteger)index
{
    /*
     reason: '*** __boundsFail: index 3 beyond bounds [0 .. 1]'
     */
    @synchronized (self) {
        if ([self crashWhenObjectAtIndex:index function:@"[__NSArrayI objectAtIndex:]"]) {

            return nil;
        }
        return [self crashKiller_NSArrayIObjectAtIndex:index];
    }
}

- (instancetype)crashKiller_SingleIObjectAtIndex:(NSUInteger)index
{
    /*
     reason: '*** -[__NSSingleObjectArrayI objectAtIndex:]: index 3 beyond bounds [0 .. 0]'
     */
    @synchronized (self) {
        if ([self crashWhenObjectAtIndex:index function:@"[__NSSingleObjectArrayI objectAtIndex:]"]) {

            return nil;
        }
        return [self crashKiller_SingleIObjectAtIndex:index];
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

- (instancetype)crashKiller_arrayByAddingObject:(id)anObject
{
    /*
     reason: '*** -[NSArray arrayByAddingObject:]: object cannot be nil'
     */
    @synchronized (self) {

        if (!anObject) {

            [[CrashKillerManager shareManager] printLogWithFunction:@"[NSArray arrayByAddingObject:]" reason:[NSString stringWithFormat:@"object cannot be nil"] callStackSymbols:[NSThread callStackSymbols]];

            return nil;
        }
        return  [self crashKiller_arrayByAddingObject:anObject];
    }
}
- (instancetype)crashKiller_subarrayWithRange:(NSRange)range
{
    @synchronized (self) {

        NSString *func = @"[NSArray subarrayWithRange:]";
        NSString *reason;
        if (self.count == 0) {

            /*
             reason: '*** -[NSArray subarrayWithRange:]: range {2, 2} extends beyond bounds for empty array'
             */
            reason = [NSString stringWithFormat:@"range {%zi, %zi} extends beyond boundsfor empty array",range.location,range.length];
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return nil;
        }
        if (range.length <=0 || self.count < range.location+range.length) {

            /*
             reason: '*** -[NSArray subarrayWithRange:]: range {2, 2} extends beyond bounds [0 .. 0]'
             */
            reason = [NSString stringWithFormat:@"range {%zi, %zi} extends beyond bounds [0..%zi]",range.location,range.length,self.count];
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return nil;
        }
        return [self crashKiller_subarrayWithRange:range];
    }
}


- (instancetype)crashKiller_objectsAtIndexes:(NSIndexSet *)indexes
{
    @synchronized (self) {

        NSString *func = @"[NSArray objectsAtIndexes:]";
        NSString *reason;
        if (!indexes) {

            /*
             reason: '*** -[NSArray objectsAtIndexes:]: index set cannot be nil'
             */
            NSLog(@"***** %s : index set cannot be nil",__FUNCTION__);
            reason = @"index set cannot be nil";
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return nil;
        }
        if (self.count == 0) {

            /*
             reason: '*** -[NSArray objectsAtIndexes:]: index 2 in index set beyond bounds for empty array'
             */
            reason = [NSString stringWithFormat:@"index %zi in index set beyond bounds for empty array",indexes.count];
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return nil;
        }
        if (indexes.count && indexes.lastIndex >= self.count) {

            /*
             reason: '*** -[NSArray objectsAtIndexes:]: index 2 in index set beyond bounds [0 .. 0]'
             */
            reason = [NSString stringWithFormat:@"index %zi in index set beyond bounds [0 .. %zi]",indexes.lastIndex,self.count];
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
            return nil;
        }
        return [self crashKiller_objectsAtIndexes:indexes];
    }
}


@end
