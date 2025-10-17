//
//  NSObject+KillSelector.h
//  CrashKiller
//
//  Created by 龙章辉 on 2021/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KillSelector)

+ (void)registerKillSelector;
@end

NS_ASSUME_NONNULL_END
