//
//  NSObject+KillKVC.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/4/1.
//

#import "NSObject+KillKVC.h"
#import "NSObject+CrashKillerMethodSwizzling.h"

@implementation NSObject (KillKVC)

+ (void)registerKillKVC
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(setValue:forKey:)
                                       withMethod:@selector(crashKiller_setValue:forKey:)
                                        withClass:[NSObject class]];
    });
}

- (void)crashKiller_setValue:(id)value forKey:(NSString *)key {

    /*
     reason: '*** -[CrashObject setValue:forKey:]: attempt to set a value for a nil key'
     */
    if (key == nil) {

        NSString *func = [NSString stringWithFormat:@"[<%@ %p> setValue:forKey:]",NSStringFromClass([self class]),self];
        NSString *reason = @"attempt to set a value for a nil key";
        [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
        return;
    }
    [self crashKiller_setValue:value forKey:key];
}

- (void)setNilValueForKey:(NSString *)key {

    NSString *func = [NSString stringWithFormat:@"[<%@ %p> setValue:forUndefinedKey:]",NSStringFromClass([self class]),self];
    NSString *reason = [NSString stringWithFormat:@"could not set nil as the value for the key %@. ***",key];
    [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    /*
     reason: '[<CrashObject 0x600000315e70> setValue:forUndefinedKey:]: this class is not key value coding-compliant for the key address.'
     */
    NSString *func = [NSString stringWithFormat:@"[<%@ %p> setValue:forUndefinedKey:]",NSStringFromClass([self class]),self];
    NSString *reason = @"this class is not key value coding-compliant for the key address.";
    [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
}

- (nullable id)valueForUndefinedKey:(NSString *)key {

    /*
     reason: '[<CrashObject 0x6000021705f0> valueForUndefinedKey:]: this class is not key value coding-compliant for the key address.'
     */
    NSString *func = [NSString stringWithFormat:@"[<%@ %p> valueForUndefinedKey:]",NSStringFromClass([self class]),self];
    NSString *reason = @"this class is not key value coding-compliant for the key address.";
    [[CrashKillerManager shareManager] printLogWithFunction:func reason:reason callStackSymbols:[NSThread callStackSymbols]];
    return self;
}

@end
