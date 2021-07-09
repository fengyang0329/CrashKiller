//
//  TestUrlCrashVC.m
//  CrashKiller_Example
//
//  Created by 龙章辉 on 2021/7/9.
//  Copyright © 2021 fengyang0329. All rights reserved.
//

#import "TestUrlCrashVC.h"

@interface TestUrlCrashVC ()

@end

@implementation TestUrlCrashVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.didSelectRowWithEvent = YES;
//    NSURL *url = [NSURL URLWithString:@"ff"];
//    [[UIApplication sharedApplication] openURL:url];
//    self.titleArray = @[
//        @{
//            @"title":@"initWithObjectsAndCountWithNil",
//            @"detail":@"[NSSet setWithObjects:nil];"
//        },
//        @{
//            @"title":@"addObjectWithNil",
//            @"detail":@"NSMutableSet *set = [[NSMutableSet alloc] initWithObjects:nil, nil];\n[set addObject:nil];"
//        },
//        @{
//            @"title":@"removeObjectWithNil",
//            @"detail":@"NSMutableSet *set = [[NSMutableSet alloc] initWithObjects:nil, nil];\n[set removeObject:nil];"
//        },
//        @{
//            @"title":@"setWithObjectWithNil",
//            @"detail":@"[NSSet setWithObject:nil];"
//        }
//    ];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
