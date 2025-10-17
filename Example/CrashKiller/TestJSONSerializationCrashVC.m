//
//  TestJSONSerializationCrashVC.m
//  CrashKiller_Example
//
//  Created by 龙章辉 on 2021/8/5.
//  Copyright © 2021 fengyang0329. All rights reserved.
//

#import "TestJSONSerializationCrashVC.h"

@interface TestJSONSerializationCrashVC ()

@end

@implementation TestJSONSerializationCrashVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.didSelectRowWithEvent = YES;
    self.titleArray = @[
        @{
            @"title" : @"testJSONObjectWithData",
            @"detail" : @"data is nil"
         },
        @{
            @"title" : @"testdataWithJSONObject",
            @"detail": @"obj is nil"
         }
    ];
}
- (void)testJSONObjectWithData
{
    id data = nil;
    NSError *error;
    NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"*******dic:%@",dic);
}

- (void)testdataWithJSONObject
{
    id obj = nil;
    NSError *error;
    NSData *data = [NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:&error];
    NSLog(@"*******data:%@",data);

}

@end
