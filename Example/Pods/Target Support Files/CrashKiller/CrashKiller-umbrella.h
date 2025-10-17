#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSNull+KillCrash.h"
#import "CrashKiller.h"
#import "CrashKillerManager.h"
#import "NSObject+CrashKillerMethodSwizzling.h"
#import "NSObject+KillKVC.h"
#import "NSObject+KillKVO.h"
#import "NSObject+KillSelector.h"
#import "NSTimer+KillCrash.h"

FOUNDATION_EXPORT double CrashKillerVersionNumber;
FOUNDATION_EXPORT const unsigned char CrashKillerVersionString[];

