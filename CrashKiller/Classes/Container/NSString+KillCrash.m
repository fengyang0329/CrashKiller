//
//  NSString+KillCrash.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/4/2.
//

#import "NSString+KillCrash.h"
#import "NSObject+CrashKillerMethodSwizzling.h"

@implementation NSString (KillCrash)

+ (void)registerKillString
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        /* init方法 */
        Class NSPlaceholderString = NSClassFromString(@"NSPlaceholderString");
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithString:) withMethod:@selector(crashKiller_initWithString:) withClass:NSPlaceholderString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithUTF8String:) withMethod:@selector(crashKiller_initWithUTF8String:) withClass:NSPlaceholderString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithCString:encoding:) withMethod:@selector(crashKiller_initWithCString:encoding:) withClass:NSPlaceholderString];


        /* _NSCFConstantString */
        Class __NSCFConstantString = NSClassFromString(@"__NSCFConstantString");
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringFromIndex:) withMethod:@selector(crashKiller_substringFromIndex:) withClass:__NSCFConstantString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringToIndex:) withMethod:@selector(crashKiller_substringToIndex:) withClass:__NSCFConstantString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringWithRange:) withMethod:@selector(crashKiller_substringWithRange:) withClass:__NSCFConstantString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(characterAtIndex:) withMethod:@selector(crashKiller_characterAtIndex:) withClass:__NSCFConstantString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(stringByAppendingString:) withMethod:@selector(crashKiller_stringByAppendingString:) withClass:__NSCFConstantString];


        /* NSTaggedPointerString
         例如：
         NSString *str = [NSString stringWithFormat:@"%@",@(100)];
         [str substringFromIndex:10];
         */
        Class NSTaggedPointerString = NSClassFromString(@"NSTaggedPointerString");
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringFromIndex:) withMethod:@selector(crashKiller_taggedPointer_substringFromIndex:) withClass:NSTaggedPointerString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringToIndex:) withMethod:@selector(crashKiller_taggedPointer_substringToIndex:) withClass:NSTaggedPointerString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringWithRange:) withMethod:@selector(crashKiller_taggedPointer_substringWithRange:) withClass:NSTaggedPointerString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(stringByAppendingString:) withMethod:@selector(crashKiller_taggedPointer_stringByAppendingString:) withClass:NSTaggedPointerString];

    });
}
- (instancetype)crashKiller_initWithString:(NSString *)aString
{
    /*
     reason: '*** -[NSPlaceholderString initWithString:]: nil argument'
     */
    if (aString){
        return [self crashKiller_initWithString:aString];
    }
    NSString *func = @"[NSPlaceholderString initWithString:]";
    NSString *reason = @"nil argument";
    [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
    return nil;
}
- (nullable instancetype)crashKiller_initWithUTF8String:(const char *)nullTerminatedCString;
{
    /*
     reason: '*** -[NSPlaceholderString initWithUTF8String:]: NULL cString'
     */
    if (NULL != nullTerminatedCString) {
        return [self crashKiller_initWithUTF8String:nullTerminatedCString];
    }
    NSString *func = @"[NSPlaceholderString initWithUTF8String:]";
    NSString *reason = @"NULL cString";
    [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
    return nil;
}

- (nullable instancetype)crashKiller_initWithCString:(const char *)nullTerminatedCString encoding:(NSStringEncoding)encoding
{
    /*
     reason: '*** -[NSPlaceholderString initWithCString:encoding:]: nil argument'
     */
    if (NULL != nullTerminatedCString){
        return [self crashKiller_initWithCString:nullTerminatedCString encoding:encoding];
    }
    NSString *func = @"[NSPlaceholderString initWithCString:encoding:]";
    NSString *reason = @"nil argument";
    [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
    return nil;
}


- (NSString *)crashKiller_substringFromIndex:(NSUInteger)from
{
    /*
     reason: '*** -[__NSCFConstantString substringFromIndex:]: Index 100 out of bounds; string length 2'
     */
    @synchronized (self) {
        if (from <= self.length) {
            return [self crashKiller_substringFromIndex:from];
        }
        NSString *func = @"[__NSCFConstantString substringFromIndex:]";
        NSString *reason = [NSString stringWithFormat:@"Index %zi out of bounds; string length %zi",from,self.length];
        [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        return nil;
    }
}
- (NSString *)crashKiller_taggedPointer_substringFromIndex:(NSUInteger)from
{
    /*
     reason: '*** -[NSTaggedPointerString substringFromIndex:]: Index 10 out of bounds; string length 3'
     */
    @synchronized (self) {
        if (from <= self.length) {
            return [self crashKiller_taggedPointer_substringFromIndex:from];
        }
        NSString *func = @"[NSTaggedPointerString substringFromIndex:]";
        NSString *reason = [NSString stringWithFormat:@"Index %zi out of bounds; string length %zi",from,self.length];
        [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        return nil;
    }
}


- (NSString *)crashKiller_substringToIndex:(NSUInteger)to
{
    /*
     reason: '*** -[__NSCFConstantString substringToIndex:]: Index 100 out of bounds; string length 2'
     */
    @synchronized (self) {
        if (to <= self.length) {
            return [self crashKiller_substringToIndex:to];
        }
        NSString *func = @"[__NSCFConstantString substringToIndex:]";
        NSString *reason = [NSString stringWithFormat:@"Index %zi out of bounds; string length %zi",to,self.length];
        [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        return self;
    }
}

- (NSString *)crashKiller_taggedPointer_substringToIndex:(NSUInteger)to
{
    /*
     reason: '*** -[NSTaggedPointerString substringToIndex:]: Index 10 out of bounds; string length 3'
     */
    @synchronized (self) {
        if (to <= self.length) {
            return [self crashKiller_taggedPointer_substringToIndex:to];
        }
        NSString *func = @"[NSTaggedPointerString substringToIndex:]";
        NSString *reason = [NSString stringWithFormat:@"Index %zi out of bounds; string length %zi",to,self.length];
        [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        return self;
    }
}

- (NSString *)crashKiller_substringWithRange:(NSRange)range
{
    /*
     reason: '-[__NSCFConstantString substringWithRange:]: Range {100, 100} out of bounds; string length 2'
     */
    @synchronized (self) {
        if (CrashKillerSafeMaxRange(range) <= self.length) {
            return [self crashKiller_substringWithRange:range];
        }else if (range.location < self.length){
            return [self crashKiller_substringWithRange:NSMakeRange(range.location, self.length-range.location)];
        }
        NSString *func = @"[__NSCFConstantString substringWithRange:]";
        NSString *reason = [NSString stringWithFormat:@"Range {%zi, %zi} out of bounds; string length %zi",range.length,range.length,self.length];
        [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        return nil;
    }
}
- (NSString *)crashKiller_taggedPointer_substringWithRange:(NSRange)range
{
    /*
     reason: '-[NSTaggedPointerString substringWithRange:]: Range {100, 100} out of bounds; string length 2'
     */
    @synchronized (self) {
        if (CrashKillerSafeMaxRange(range) <= self.length) {
            return [self crashKiller_taggedPointer_substringWithRange:range];
        }else if (range.location < self.length){
            return [self crashKiller_taggedPointer_substringWithRange:NSMakeRange(range.location, self.length-range.location)];
        }
        NSString *func = @"[NSTaggedPointerString substringWithRange:]";
        NSString *reason = [NSString stringWithFormat:@"Range {%zi, %zi} out of bounds; string length %zi",range.length,range.length,self.length];
        [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        return nil;
    }
}

- (unichar)crashKiller_characterAtIndex:(NSUInteger)index
{
    /*
     reason: '-[__NSCFConstantString characterAtIndex:]: Range or index out of bounds'
     */
    @synchronized (self) {
        if (index < self.length) {

            return [self crashKiller_characterAtIndex:index];
        }
        NSString *func = @"[__NSCFConstantString characterAtIndex:]";
        NSString *reason = @"Range or index out of bounds";
        [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        return nil;
    }
}

- (NSString *)crashKiller_stringByAppendingString:(NSString *)aString
{
    /*
     reason: '*** -[__NSCFConstantString stringByAppendingString:]: nil argument'
     */
    @synchronized (self) {
        if (aString){
            return [self crashKiller_stringByAppendingString:aString];
        }
        NSString *func = @"[__NSCFConstantString stringByAppendingString:]";
        NSString *reason = @"nil argument";
        [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        return self;
    }
}

- (NSString *)crashKiller_taggedPointer_stringByAppendingString:(NSString *)aString
{
    /*
     reason: '*** -[NSTaggedPointerString stringByAppendingString:]: nil argument'
     */
    @synchronized (self) {
        if (aString){
            return [self crashKiller_taggedPointer_stringByAppendingString:aString];
        }
        NSString *func = @"[NSTaggedPointerString stringByAppendingString:]";
        NSString *reason = @"nil argument";
        [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        return self;
    }
}


//- (NSRange)crashKiller_rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)range locale:(nullable NSLocale *)locale
//{
//    @synchronized (self) {
//        if (searchString){
//            if (NSSafeMaxRange(range) <= self.length) {
//                return [self crashKiller_rangeOfString:searchString options:mask range:range locale:locale];
//            }else if (range.location < self.length){
//                return [self crashKiller_rangeOfString:searchString options:mask range:NSMakeRange(range.location, self.length-range.location) locale:locale];
//            }
//            return NSMakeRange(NSNotFound, 0);
//        }else{
////            SFAssert(NO, @"hookRangeOfString:options:range:locale: searchString is nil");
//            return NSMakeRange(NSNotFound, 0);
//        }
//    }
//}

@end
