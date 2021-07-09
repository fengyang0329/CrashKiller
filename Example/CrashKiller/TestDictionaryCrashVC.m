//
//  TestDictionaryCrashVC.m
//  CrashKiller_Example
//
//  Created by 龙章辉 on 2021/4/2.
//  Copyright © 2021 fengyang0329. All rights reserved.
//

#import "TestDictionaryCrashVC.h"

@interface TestDictionaryCrashVC ()

@end

@implementation TestDictionaryCrashVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];

    self.didSelectRowWithEvent = YES;
    self.titleArray = @[
        @{
            @"title" : @"testinitWithObjectsWithArgNotArray",
            @"detail" : @"NSDictionary *dic2 = [[NSDictionary alloc] initWithObjects:@\"ff\" forKeys:nil];"
         },
        @{
            @"title" : @"testinitWithObjectsKeysNil",
            @"detail": @"NSDictionary *dic2 = [[NSDictionary alloc] initWithObjects:@[@\"ff\"] forKeys:nil];"
         },
        @{
            @"title" : @"testInitObjectsWithNil",
            @"detail" : @"NSString *nilStr = nil;\nNSDictionary *dic = @{nilStr:@\"keyNil\",@\"valueNil\":nilStr,@\"key1\":@\"value not nil\"};"
         },
        @{
            @"title" : @"testInitObjectsCountNotEqualKeysCount",
            @"detail": @"id dd = nil;\nNSDictionary *dic = [NSDictionary dictionaryWithObjects:@[@\"FF\",@\"fff\"] forKeys:@[dd,@\"F\"]];"
         },
        @{
            @"title" : @"testSetObjectWithNil",
            @"detail": @"NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:nil];\n[mutDic setObject:nil forKey:@\"ff\"];"
         },
        @{
            @"title" : @"testSetObjectWithNilKey",
            @"detail": @"NSMutableDictionary *mutDic=[NSMutableDictionary dictionaryWithDictionary:nil];\n[mutDic setObject:@\"fff\" forKey:nil];"
         },
        @{
            @"title" : @"testRemoveObjectWithNilKey",
            @"detail": @"NSMutableDictionary *mutDic=[NSMutableDictionary dictionaryWithObject:@\"gg\" forKey:@\"ff\"];\n[mutDic removeObjectForKey:nil];"
         }
    ];
}


- (void)testinitWithObjectsWithArgNotArray
{
    NSDictionary *dic2 = [[NSDictionary alloc] initWithObjects:@"ff" forKeys:nil];
}
- (void)testinitWithObjectsKeysNil
{
    NSDictionary *dic2 = [[NSDictionary alloc] initWithObjects:@[@"ff"] forKeys:nil];
}
- (void)testInitObjectsWithNil
{
    NSString *nilStr = nil;
    NSDictionary *dic = @{nilStr:@"keyNil",@"valueNil":nilStr,@"key1":@"value not nil"};
}
- (void)testInitObjectsCountNotEqualKeysCount
{
    id dd = nil;
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[@"FF",@"fff"] forKeys:@[dd,@"F"]];
}

- (void)testSetObjectWithNil
{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:nil];
    [mutDic setObject:nil forKey:@"ff"];
}

- (void)testSetObjectWithNilKey
{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:nil];
    [mutDic setObject:@"fff" forKey:nil];
}

- (void)testRemoveObjectWithNilKey
{
    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithObject:@"gg" forKey:@"ff"];
    [mutDic removeObjectForKey:nil];
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
