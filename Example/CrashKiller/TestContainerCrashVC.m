//
//  TestContainerCrashVC.m
//  CrashKiller_Example
//
//  Created by 龙章辉 on 2021/4/2.
//  Copyright © 2021 fengyang0329. All rights reserved.
//

#import "TestContainerCrashVC.h"

@interface TestContainerCrashVC ()

@end

@implementation TestContainerCrashVC
{
    NSArray *_titleArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupDataSource];
    //https://github.com/jasenhuang/NSObjectSafe/blob/master/NSObjectSafe/NSObjectSafe.m
}

- (void)setupDataSource {

    self.titleArray = @[
        @{
            @"title" : @"NSDictionary Crash",
            @"class" : @"TestDictionaryCrashVC"
        },
        @{
            @"title" : @"NSArray Crash",
            @"class" : @"TestArrayCrashVC"
        },
        @{
            @"title" : @"NSString Crash",
            @"class" : @"TestStringCrashVC"
        },
        @{
            @"title" : @"NSSet Crash",
            @"class" : @"TestSetCrashVC"
        },
        @{
            @"title" : @"NSURL Crash",
            @"class" : @"TestUrlCrashVC"
        }
    ];
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
