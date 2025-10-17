//
//  KILLAppDelegate.m
//  CrashKiller
//
//  Created by fengyang0329 on 03/29/2021.
//  Copyright (c) 2021 fengyang0329. All rights reserved.
//

#import "KILLAppDelegate.h"
#import <CrashKiller.h>
#import "KILLViewController.h"

KILLViewController *vc;

@implementation KILLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
//    [CrashKiller handleCrashLog:(id<CrashKillerLogDelegate>)self];
//    [CrashKiller configDefendCrashType:CrashKillerDefendAll];
//    [CrashKiller start];
//    //验证多次开启
//    [CrashKiller start];
//    [CrashKiller start];

//    CrashKiller.terminateWhenException = YES;
    CrashKiller.debugLog = NO;
    
    vc = [[KILLViewController alloc] init];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navigation;
    [self.window makeKeyAndVisible];

    return YES;
}


- (void)onLog:(NSException *)exception
{
    [vc alertWithTitle:exception.name message:[NSString stringWithFormat:@"\n%@\n*** First throw call stack:%@",exception.reason,exception.callStackSymbols] completionHandler:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
