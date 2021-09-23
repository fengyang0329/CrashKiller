//
//  NSFileHandle+KillCrash.h
//  CrashKiller
//
//  Created by 龙章辉 on 2021/9/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileHandle (KillCrash)

+ (void)registerKillFileHandle;

@end

NS_ASSUME_NONNULL_END
