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

    @try {
        [self crashKiller_setValue:value forKey:key];
    } @catch (NSException *exception) {
        [[CrashKillerManager shareManager] printLogWithException:exception];
    }
}

- (void)setNilValueForKey:(NSString *)key {

    NSString *reason = [NSString stringWithFormat:@"[<%@ %p> setValue:forUndefinedKey:]: could not set nil as the value for the key %@. ***",NSStringFromClass([self class]),self,key];
    [[CrashKillerManager shareManager] throwExceptionWithName:@"NSUnknownKeyException" reason:reason];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {

    NSString *reason = [NSString stringWithFormat:@"[<%@ %p> valueForUndefinedKey:]: this class is not key value coding-compliant for the key %@.",NSStringFromClass([self class]),self,key];
    [[CrashKillerManager shareManager] throwExceptionWithName:@"NSUnknownKeyException" reason:reason];
}

- (nullable id)valueForUndefinedKey:(NSString *)key {

    NSString *reason = [NSString stringWithFormat:@"[<%@ %p> valueForUndefinedKey:]: this class is not key value coding-compliant for the key %@.",NSStringFromClass([self class]),self,key];
    [[CrashKillerManager shareManager] throwExceptionWithName:@"NSUnknownKeyException" reason:reason];
    return self;
}

@end
