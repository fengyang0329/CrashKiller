//
//  TestStringCrashVC.m
//  CrashKiller_Example
//
//  Created by 龙章辉 on 2021/4/13.
//  Copyright © 2021 fengyang0329. All rights reserved.
//

#import "TestStringCrashVC.h"

@interface TestStringCrashVC ()

@end

@implementation TestStringCrashVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    [self testSubstringFromIndex];
//    [self testSubstringToIndex];
//    [self testSubstringWithRange];
//    [self testInitWithStringWhenNil];
//    [self testInitWithUTF8StringWhenNil];
//    [self testinitWithCStringWhenNil];
//    [self testCharacterAtIndex];
//    [self testStringByAppendingStringWithNil];

//    [self testTaggedPointerStringSubstringFromIndex];
//    [self testTaggedPointerStringSubstringToIndex];
//    [self testTaggedPointerStringSubstringWithRange];
//    [self testTaggedPointerStringStringByAppendingStringWithNil];

//        [self testMutableStringInitWithStringWhenNil];
//        [self testMutableStringInitWithUTF8StringWhenNil];
//    [self testMutableStringInitWithCStringWhenNil];
//    [self testMutableStringStringByAppendingStringAppendString];
//    [self testMutableStringAppendString];
//    [self testMutableStringInsertStringAtIndex];
//    [self testMutableStringdeleteCharactersInRange];
//    [self testMutableStringSubstringFromIndex];
//    [self testMutableStringSubstringToIndex];
    [self testMutableStringSubstringWithRange];
}

#pragma mark 可变string

- (void)testMutableStringSubstringFromIndex
{
    NSMutableString *str = [NSMutableString stringWithString:@"delete"];
    [str substringFromIndex:-100];
}

- (void)testMutableStringSubstringToIndex
{
    NSMutableString *str = [NSMutableString stringWithString:@"delete"];
    [str substringToIndex:100];
}
- (void)testMutableStringSubstringWithRange
{
    NSMutableString *str = [NSMutableString stringWithString:@"delete"];
    [str substringWithRange:NSMakeRange(100, 100)];
    NSLog(@"%@",[str substringWithRange:NSMakeRange(NSNotFound, NSNotFound)]);
}
- (void)testMutableStringdeleteCharactersInRange
{
    NSMutableString *str = [NSMutableString stringWithString:@"delete"];
    [str deleteCharactersInRange:NSMakeRange(0, 1)];
    NSLog(@"***delete:%@",str);
    [str deleteCharactersInRange:NSMakeRange(NSNotFound, NSNotFound)];
    NSLog(@"***delete2:%@",str);
}

- (void)testMutableStringInitWithStringWhenNil
{
    [[NSMutableString alloc] initWithString:nil];
}
- (void)testMutableStringInitWithUTF8StringWhenNil
{
     [[NSMutableString alloc] initWithUTF8String:nil];
}
- (void)testMutableStringInitWithCStringWhenNil
{
    id obj;
    const char *cString = [obj UTF8String];
   [[NSMutableString alloc] initWithCString:cString encoding:NSUTF8StringEncoding];
}
- (void)testMutableStringStringByAppendingStringAppendString
{
    NSMutableString *str = [NSMutableString stringWithString:@"g"];
    NSLog(@"%@", [str stringByAppendingString:nil]);
}
- (void)testMutableStringAppendString
{
    NSMutableString *str = [NSMutableString stringWithString:@"g"];
    [str appendString:nil];
    NSLog(@"%@",str);
}
- (void)testMutableStringInsertStringAtIndex
{
    NSMutableString *str = [NSMutableString stringWithString:@"g"];
    [str insertString:nil atIndex:0];
    [str insertString:@"gg" atIndex:100];

}


- (void)testStringByAppendingStringWithNil
{
    [@"gg" stringByAppendingString:nil];
}
- (void)testCharacterAtIndex
{
    [@"gg" characterAtIndex:2];
}
- (void)testInitWithUTF8StringWhenNil
{
    NSString *str = [[NSString alloc] initWithUTF8String:nil];
}
- (void)testInitWithStringWhenNil
{
    NSString *str = [[NSString alloc] initWithString:nil];
}
- (void)testinitWithCStringWhenNil
{
    id obj;
    const char *cString = [obj UTF8String];
   NSString *str = [[NSString alloc] initWithCString:cString encoding:NSUTF8StringEncoding];
}

- (void)testSubstringFromIndex
{
    NSString *sub = [@"ff" substringFromIndex:-100];
}

- (void)testSubstringToIndex
{
    NSString *sub = [@"ff" substringToIndex:100];
}
- (void)testSubstringWithRange
{
    [@"ff" substringWithRange:NSMakeRange(100, 100)];
   NSLog(@"%@",[@"ff" substringWithRange:NSMakeRange(NSNotFound, NSNotFound)]);
}

- (void)testTaggedPointerStringSubstringFromIndex
{
    NSString *str = [NSString stringWithFormat:@"%@",@(100)];
    [str substringFromIndex:10];
}
- (void)testTaggedPointerStringSubstringToIndex
{
    NSString *str = [NSString stringWithFormat:@"%@",@(100)];
    [str substringToIndex:10];
}
- (void)testTaggedPointerStringSubstringWithRange
{
    NSString *str = [NSString stringWithFormat:@"%@",@(100)];
    NSLog(@"%@",[str substringWithRange:NSMakeRange(NSNotFound, NSNotFound)]);
}

- (void)testTaggedPointerStringStringByAppendingStringWithNil
{
    NSString *str = [NSString stringWithFormat:@"%@",@(100)];
    [str stringByAppendingString:nil];
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
