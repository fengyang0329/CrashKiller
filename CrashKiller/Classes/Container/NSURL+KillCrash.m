//
//  NSURL+KillCrash.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/7/9.
//

#import "NSURL+KillCrash.h"
#import "NSObject+CrashKillerMethodSwizzling.h"

@implementation NSURL (KillCrash)

+ (void)registerKillNSURL
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        /**
         __NSSingleObjectSetI 只有一个元素的集合      ( NSSet *set3 =  [[NSSet alloc]initWithObjects: @"1",nil]; )
         __NSPlaceholderSet 占位集合                ( NSSet *set2 =  [NSSet alloc]; )
         __NSSetI 初始化后的不可变集合                ( NSSet *set1 = [[NSSet alloc] init]; )
         */
//        Class __NSPlaceholderSet = objc_getClass("__NSPlaceholderSet");
//        Class __NSSet = objc_getClass("NSSet");
//
//        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(initWithObjects:count:) withMethod:@selector(crashKiller_initWithObjects:count:) withClass:__NSPlaceholderSet];
//
//        [NSObject crashKillerMethodSwizzlingInstanceMethod:@selector(setWithObject:) withMethod:@selector(crashKiller_setWithObject:) withClass:__NSSet];

    });
}

@end
