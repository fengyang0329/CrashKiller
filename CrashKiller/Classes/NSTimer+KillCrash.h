//
//  NSTimer+KillCrash.h
//  CrashKiller
//
//  Created by 龙章辉 on 2021/4/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (KillCrash)

+ (void)registerKillTimer;

@end

NS_ASSUME_NONNULL_END
