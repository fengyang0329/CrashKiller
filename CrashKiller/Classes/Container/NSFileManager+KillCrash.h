//
//  NSFileManager+KillCrash.h
//  CrashKiller
//
//  Created by 龙章辉 on 2021/9/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (KillCrash)

+ (void)registerKillFileManager;

@end

NS_ASSUME_NONNULL_END
