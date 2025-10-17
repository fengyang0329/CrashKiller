//
//  TestDataCrashVC.m
//  CrashKiller_Example
//
//  Created by 龙章辉 on 2021/9/12.
//  Copyright © 2021 fengyang0329. All rights reserved.
//

#import "TestDataCrashVC.h"

@interface TestDataCrashVC ()

@end

@implementation TestDataCrashVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.didSelectRowWithEvent = YES;
    self.titleArray = @[
        @{
            @"title" : @"testSubdataWithRangeForNSZeroData",
            @"detail" : @"NSData *data3=  [NSData data];\n[data3 subdataWithRange:NSMakeRange(10, 10)];"
         },
        @{
            @"title" : @"testSubdataWithRange",
            @"detail": @"NSData *data = [@\"ff\" dataUsingEncoding:NSUTF8StringEncoding];\n[data subdataWithRange:NSMakeRange(10, 10)];"
         },
        @{
            @"title" : @"testRangeOfDataForNSZeroData",
            @"detail": @"NSData *data =  [NSData data];\n[data rangeOfData:nil options:nil range:NSMakeRange(10, 10)];"
         },
       @{
           @"title" : @"testRangeOfData",
           @"detail": @"NSData *data = [@\"ff\" dataUsingEncoding:NSUTF8StringEncoding];\n[data rangeOfData:nil options:nil range:NSMakeRange(10, 10)];"
        },
        @{
            @"title" : @"testInitWithBase64EncodedString",
            @"detail": @"[[NSData alloc] initWithBase64EncodedString:nil options:nil];"
         },
        @{
            @"title" : @"testInitWithBase64EncodedData",
            @"detail": @"[[NSData alloc] initWithBase64EncodedData:nil options:nil];"
         }
    ];
}

- (void)testSubdataWithRangeForNSZeroData
{
    NSData *data =  [NSData data];
    [data subdataWithRange:NSMakeRange(10, 10)];
}

- (void)testSubdataWithRange
{
    NSData *data = [@"ff" dataUsingEncoding:NSUTF8StringEncoding];
    [data subdataWithRange:NSMakeRange(10, 10)];
}

- (void)testRangeOfDataForNSZeroData
{
    NSData *data =  [NSData data];
    [data rangeOfData:nil options:nil range:NSMakeRange(10, 10)];
}

- (void)testRangeOfData
{
    NSData *data = [@"ff" dataUsingEncoding:NSUTF8StringEncoding];
    [data rangeOfData:nil options:nil range:NSMakeRange(10, 10)];
}

- (void)testInitWithBase64EncodedString
{
    [[NSData alloc] initWithBase64EncodedString:nil options:nil];
}

- (void)testInitWithBase64EncodedData
{
    [[NSData alloc] initWithBase64EncodedData:nil options:nil];
}
//- (vo)

//- (void)ff
//{
//    NSData *data = [NSData dataWithData:nil] ;
//    [data writeToFile:nil atomically:YES];
//    NSData *data2 = [@"ff" dataUsingEncoding:NSUTF8StringEncoding];
////    [NSData data];
////    [data2 subdataWithRange:NSMakeRange(10, 10)];
//    NSData *data3=  [NSData data];
//    [data3 subdataWithRange:NSMakeRange(10, 10)];
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
