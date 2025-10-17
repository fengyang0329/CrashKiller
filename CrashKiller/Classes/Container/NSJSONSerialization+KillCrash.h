//
//  NSJSONSerialization+KillCrash.h
//  CrashKiller
//
//  Created by 龙章辉 on 2021/8/5.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSJSONSerialization (KillCrash)

+ (void)registerKillJSONSerialization;

@end

NS_ASSUME_NONNULL_END
