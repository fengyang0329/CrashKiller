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
    self.didSelectRowWithEvent = YES;
    self.titleArray = @[
        @{
            @"title" : @"testSubstringFromIndex",
            @"detail" : @"NSString *sub = [@\"ff\" substringFromIndex:-100];"
         },
        @{
            @"title" : @"testSubstringToIndex",
            @"detail": @"NSString *sub = [@\"ff\" substringToIndex:100];"
         },
        @{
            @"title" : @"testSubstringWithRange",
            @"detail": @"[@\"ff\" substringWithRange:NSMakeRange(100, 100)];"
         },
        @{
            @"title" : @"testInitWithStringWhenNil",
            @"detail": @"NSString *str = [[NSString alloc] initWithString:nil];"
         },
        @{
            @"title" : @"testInitWithUTF8StringWhenNil",
            @"detail": @"NSString *str = [[NSString alloc] initWithUTF8String:nil];"
         },
        @{
            @"title" : @"testinitWithCStringWhenNil",
            @"detail": @"id obj;\nconst char *cString = [obj UTF8String];\nNSString *str = [[NSString alloc] initWithCString:cString encoding:NSUTF8StringEncoding];"
         },
        @{
            @"title" : @"testCharacterAtIndex",
            @"detail": @"[@\"gg\" characterAtIndex:2];"
         },
        @{
            @"title" : @"testStringByAppendingStringWithNil",
            @"detail": @"[@\"gg\" stringByAppendingString:nil];"
         },
        @{
            @"title" : @"testTaggedPointerStringSubstringFromIndex",
            @"detail": @"NSString *str = [NSString stringWithFormat:@\"%@\",@(100)];\n[str substringFromIndex:10];"
         },
        @{
            @"title" : @"testTaggedPointerStringSubstringToIndex",
            @"detail": @" NSString *str = [NSString stringWithFormat:@\"%@\",@(100)];\n[str substringToIndex:10];"
         },
        @{
            @"title" : @"testTaggedPointerStringSubstringWithRange",
            @"detail": @"NSString *str = [NSString stringWithFormat:@\"%@\",@(100)];\nNSLog(@\"%@\",[str substringWithRange:NSMakeRange(NSNotFound, NSNotFound)]);"
         },
        @{
            @"title" : @"testTaggedPointerStringStringByAppendingStringWithNil",
            @"detail": @"NSString *str = [NSString stringWithFormat:@\"%@\",@(100)];\n[str stringByAppendingString:nil];"
         },
        @{
            @"title":@"MutableString:"
        },
        @{
            @"title" : @"testMutableStringInitWithStringWhenNil",
            @"detail": @"[[NSMutableString alloc] initWithString:nil];"
         },
        @{
            @"title" : @"testMutableStringInitWithUTF8StringWhenNil",
            @"detail": @"[[NSMutableString alloc] initWithUTF8String:nil];"
         },
        @{
            @"title" : @"testMutableStringInitWithCStringWhenNil",
            @"detail": @" id obj;\nconst char *cString = [obj UTF8String];\n[[NSMutableString alloc] initWithCString:cString encoding:NSUTF8StringEncoding];"
         },
        @{
            @"title" : @"testMutableStringStringByAppendingStringAppendString",
            @"detail": @"NSMutableString *str = [NSMutableString stringWithString:@\"g\"];NSLog(@\"%@\", [str stringByAppendingString:nil]);"
         },
        @{
            @"title" : @"testMutableStringAppendString",
            @"detail": @"NSMutableString *str = [NSMutableString stringWithString:@\"g\"];\n[str appendString:nil];\nNSLog(@\"%@\",str);"
         },
        @{
            @"title" : @"testMutableStringInsertStringAtIndex",
            @"detail": @"NSMutableString *str = [NSMutableString stringWithString:@\"g\"];\n[str insertString:nil atIndex:0];\n[str insertString:@\"gg\" atIndex:100];"
         },
        @{
            @"title" : @"testMutableStringdeleteCharactersInRange",
            @"detail": @"NSMutableString *str = [NSMutableString stringWithString:@\"delete\"];\n[str deleteCharactersInRange:NSMakeRange(NSNotFound, NSNotFound)];"
         },
        @{
            @"title" : @"testMutableStringSubstringFromIndex",
            @"detail": @"NSMutableString *str = [NSMutableString stringWithString:@\"delete\"];\n[str substringFromIndex:-100];"
         },
        @{
            @"title" : @"testMutableStringSubstringToIndex",
            @"detail": @"NSMutableString *str = [NSMutableString stringWithString:@\"delete\"];\n[str substringToIndex:100];"
         },
        @{
            @"title" : @"testMutableStringSubstringWithRange",
            @"detail": @"NSMutableString *str = [NSMutableString stringWithString:@\"delete\"];\n[str substringWithRange:NSMakeRange(100, 100)];"
         }
    ];
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
//    NSLog(@"%@",[str substringWithRange:NSMakeRange(NSNotFound, NSNotFound)]);
}
- (void)testMutableStringdeleteCharactersInRange
{
    NSMutableString *str = [NSMutableString stringWithString:@"delete"];
    [str deleteCharactersInRange:NSMakeRange(0, 1)];
//    NSLog(@"***delete:%@",str);
    [str deleteCharactersInRange:NSMakeRange(NSNotFound, NSNotFound)];
//    NSLog(@"***delete2:%@",str);
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
//   NSLog(@"%@",[@"ff" substringWithRange:NSMakeRange(NSNotFound, NSNotFound)]);
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
