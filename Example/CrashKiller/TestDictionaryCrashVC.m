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
    [self testInitObjectsWithNil];
    [self testInitObjectsCountNotEqualKeysCount];
    [self testSetObjectWithNil];
    [self testSetObjectWithNilKey];
    [self testRemoveObjectWithNilKey];
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
