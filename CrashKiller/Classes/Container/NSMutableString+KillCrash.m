//
//  NSMutableString+KillCrash.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/4/2.
//

#import "NSMutableString+KillCrash.h"
#import "NSObject+CrashKillerMethodSwizzling.h"

@implementation NSMutableString (KillCrash)

+ (void)registerKillMutableString
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        Class NSPlaceholderMutableString = NSClassFromString(@"NSPlaceholderMutableString");
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithString:) withMethod:@selector(crashKiller_initWithString:) withClass:NSPlaceholderMutableString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithUTF8String:) withMethod:@selector(crashKiller_initWithUTF8String:) withClass:NSPlaceholderMutableString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithCString:encoding:) withMethod:@selector(crashKiller_initWithCString:encoding:) withClass:NSPlaceholderMutableString];

        Class __NSCFString = NSClassFromString(@"__NSCFString");
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(stringByAppendingString:) withMethod:@selector(crashKiller_stringByAppendingString:) withClass:__NSCFString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(appendString:) withMethod:@selector(crashKiller_appendString:) withClass:__NSCFString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(insertString:atIndex:) withMethod:@selector(crashKiller_insertString:atIndex:) withClass:__NSCFString];

        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(deleteCharactersInRange:) withMethod:@selector(crashKiller_deleteCharactersInRange:) withClass:__NSCFString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringFromIndex:) withMethod:@selector(crashKiller_substringFromIndex:) withClass:__NSCFString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringToIndex:) withMethod:@selector(crashKiller_substringToIndex:) withClass:__NSCFString];
        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(substringWithRange:) withMethod:@selector(crashKiller_substringWithRange:) withClass:__NSCFString];
    });
}

- (instancetype)crashKiller_initWithString:(NSString *)aString
{
    /*
     reason: '*** -[NSPlaceholderMutableString initWithString:]: nil argument'
     */
    if (aString){
        return [self crashKiller_initWithString:aString];
    }
    NSString *func = @"[NSPlaceholderMutableString initWithString:]";
    NSString *reason = @"nil argument";
    [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
    return nil;
}
- (nullable instancetype)crashKiller_initWithUTF8String:(const char *)nullTerminatedCString;
{
    /*
     reason: '*** -[NSPlaceholderMutableString initWithUTF8String:]: NULL cString'
     */
    if (NULL != nullTerminatedCString) {
        return [self crashKiller_initWithUTF8String:nullTerminatedCString];
    }
    NSString *func = @"[NSPlaceholderMutableString initWithUTF8String:]";
    NSString *reason = @"NULL cString";
    [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
    return nil;
}

- (nullable instancetype)crashKiller_initWithCString:(const char *)nullTerminatedCString encoding:(NSStringEncoding)encoding
{
    /*
     reason: '*** -[NSPlaceholderMutableString initWithCString:encoding:]: nil argument'
     */
    if (NULL != nullTerminatedCString){
        return [self crashKiller_initWithCString:nullTerminatedCString encoding:encoding];
    }
    NSString *func = @"[NSPlaceholderMutableString initWithCString:encoding:]";
    NSString *reason = @"nil argument";
    [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
    return nil;
}

- (NSString *)crashKiller_stringByAppendingString:(NSString *)aString
{
    /*
     reason: '*** -[__NSCFString stringByAppendingString:]: nil argument'
     */
    @synchronized (self) {
        if (aString){
            return [self crashKiller_stringByAppendingString:aString];
        }
        NSString *func = @"[__NSCFString stringByAppendingString:]";
        NSString *reason = @"nil argument";
        [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        return self;
    }
}

- (void)crashKiller_appendString:(NSString *)aString
{
    /*
     reason: '-[__NSCFString appendString:]: nil argument'
     */
    @synchronized (self) {
        if (aString){
            [self crashKiller_appendString:aString];
        }else{

            NSString *func = @"[__NSCFString appendString:]";
            NSString *reason = @"nil argument";
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        }
    }
}

- (void)crashKiller_insertString:(NSString *)aString atIndex:(NSUInteger)loc
{
    /*
     reason: '-[__NSCFString insertString:atIndex:]: nil argument'
     */
    @synchronized (self) {
        if (aString && loc <= self.length) {
            [self crashKiller_insertString:aString atIndex:loc];
        }else if(!aString){

            NSString *func = @"[__NSCFString insertString:atIndex:]";
            NSString *reason = @"nil argument";
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        }else if (loc > self.length){

            /*
             reason: '-[__NSCFString insertString:atIndex:]: Range or index out of bounds'
             */
            NSString *func = @"[__NSCFString insertString:atIndex:]";
            NSString *reason = @"Range or index out of bounds";
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        }
    }
}

- (void)crashKiller_deleteCharactersInRange:(NSRange)range
{
    /*
     reason: '-[__NSCFString deleteCharactersInRange:]: Range or index out of bounds'
     */
    @synchronized (self) {
        if (CrashKillerSafeMaxRange(range) <= self.length){
            [self crashKiller_deleteCharactersInRange:range];
        }else{

            NSString *func = @"[__NSCFString deleteCharactersInRange:]";
            NSString *reason = @"Range or index out of bounds";
            [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        }
    }
}


- (NSString *)crashKiller_substringFromIndex:(NSUInteger)from
{
    /*
     reason: '*** -[__NSCFString substringFromIndex:]: Index 18446744073709551516 out of bounds; string length 6'
     */
    @synchronized (self) {
        if (from <= self.length) {
            return [self crashKiller_substringFromIndex:from];
        }
        NSString *func = @"[__NSCFString substringFromIndex:]";
        NSString *reason =[NSString stringWithFormat:@"Index %zi out of bounds; string length %zi",from,self.length];
        [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        return nil;
    }
}
- (NSString *)crashKiller_substringToIndex:(NSUInteger)to
{
    /*
     reason: '*** -[__NSCFString substringToIndex:]: Index 100 out of bounds; string length 6'
     */
    @synchronized (self) {
        if (to <= self.length) {
            return [self crashKiller_substringToIndex:to];
        }
        NSString *func = @"[__NSCFString substringToIndex:]";
        NSString *reason =[NSString stringWithFormat:@"Index %zi out of bounds; string length %zi",to,self.length];
        [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        return self;
    }
}

- (NSString *)crashKiller_substringWithRange:(NSRange)range
{
    /*
     reason: '-[__NSCFString substringWithRange:]: Range {100, 100} out of bounds; string length 6'
     */
    @synchronized (self) {
        if (CrashKillerSafeMaxRange(range) <= self.length) {
            return [self crashKiller_substringWithRange:range];
        }else if (range.location < self.length){
            return [self crashKiller_substringWithRange:NSMakeRange(range.location, self.length-range.location)];
        }
        NSString *func = @"[__NSCFString substringWithRange:]";
        NSString *reason =[NSString stringWithFormat:@"Range {%zi, %zi} out of bounds; string length %zi",range.location,range.length,self.length];
        [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        return nil;
    }
}




@end
