//
//  TestArrayCrashVC.m
//  CrashKiller_Example
//
//  Created by 龙章辉 on 2021/4/13.
//  Copyright © 2021 fengyang0329. All rights reserved.
//

#import "TestArrayCrashVC.h"

@interface TestArrayCrashVC ()

@end

@implementation TestArrayCrashVC

- (void)testInitWithNilObject
{
    [NSArray arrayWithObject:nil];
}
- (void)testArrayByAddingNilObject
{
    id obj;
    NSArray *arr = [NSArray arrayWithObject:@"ff"];
    [arr arrayByAddingObject:obj];
}
- (void)testObjectAtIndexWhenArrayCount0
{
    NSArray *_arr = @[];
    [_arr objectAtIndex:3];
}
- (void)testObjectAtIndexWhenArrayCount1
{
    NSArray *_arr = @[@"f"];
    [_arr objectAtIndex:3];
}

- (void)testSubarrayWithRangeWhenArrayCount0
{
    [@[] subarrayWithRange:NSMakeRange(2, 2)];
}
- (void)testSubarrayWithRangeBeyondBounds
{
    [@[@"3"] subarrayWithRange:NSMakeRange(0, 2) ];
}
- (void)testObjectsAtIndexesWithNil
{
    [@[] objectsAtIndexes:nil];
}
- (void)testObjectsAtIndexesWithEmptyArray
{
    [@[] objectsAtIndexes:[NSIndexSet indexSetWithIndex:2]];
}
- (void)testObjectsAtIndexesWithBeyondBounds
{
    [@[@"3"] objectsAtIndexes:[NSIndexSet indexSetWithIndex:2]];
//    [@[@"55"] objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(3, 2)]];
}


#pragma mark 可变数组
- (void)testMutableArrayAddNil
{
    NSMutableArray *array = [@[@"value", @"value1"]  mutableCopy];
    [array addObject:nil];
}
- (void)testRemoveObjectsInRangeWithEmptyArray
{
    NSMutableArray *array = [@[]  mutableCopy];
    [array removeObjectAtIndex:5];
}
- (void)testRemoveObjectsInRangeWithBeyondBounds
{
    NSMutableArray *array = [@[@"value", @"value1"]  mutableCopy];
    [array removeObjectAtIndex:5];
}
- (void)testRemoveObjectsInRange
{
    NSMutableArray *array = [NSMutableArray array];
    [array removeObjectsInRange:NSMakeRange(3, 2)];
}

- (void)testMutableArrayInsertBeyondBounds
{
    NSMutableArray *array = [@[@"value", @"value1"]  mutableCopy];
    [array insertObject:@"2" atIndex:6];
}
- (void)testReplaceObjectAtIndexWithNil
{
    NSMutableArray *array = [@[@"value", @"value1"]  mutableCopy];
    [array replaceObjectAtIndex:4 withObject:nil];
}

- (void)testReplaceObjectAtIndexWithBeyondBounds
{
    NSMutableArray *array = [@[@"value", @"value1"]  mutableCopy];
    [array replaceObjectAtIndex:4 withObject:@"2"];
}

- (void)testMutableArrayObjectAtIndexWithCount0
{
    NSMutableArray *array = [@[]  mutableCopy];
    [array objectAtIndex:100];
}

- (void)testMutableArrayObjectAtIndexWithBeyondBounds
{
    NSMutableArray *array = [@[@"value", @"value1"]  mutableCopy];
    [array objectAtIndex:100];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.didSelectRowWithEvent = YES;
    self.titleArray = @[
        @{
            @"title" : @"testInitWithNilObject",
            @"detail": @"[NSArray arrayWithObject:nil];"
        },
        @{
            @"title" : @"testArrayByAddingNilObject",
            @"detail": @"NSArray *arr = [NSArray arrayWithObject:@\"ff\"];\n[arr arrayByAddingObject:nil];"
        },
        @{
            @"title" : @"testObjectAtIndexWhenArrayCount0",
            @"detail":@"NSArray *_arr = @[];\n[_arr objectAtIndex:3];"
        },
        @{
            @"title" : @"testObjectAtIndexWhenArrayCount1",
            @"detail":@" NSArray *_arr = @[@\"f\"];\n[_arr objectAtIndex:3];"
        },
        @{
            @"title" : @"testSubarrayWithRangeWhenArrayCount0",
            @"detail" :@"[@[] subarrayWithRange:NSMakeRange(2, 2)];"
        },
        @{
            @"title" : @"testSubarrayWithRangeBeyondBounds",
            @"detail":@"[@[@\"3\"] subarrayWithRange:NSMakeRange(0, 2) ];"
        },
        @{
            @"title" : @"testObjectsAtIndexesWithNil",
            @"detail": @"[@[] objectsAtIndexes:nil];"
        },
        @{
            @"title" : @"testObjectsAtIndexesWithEmptyArray",
            @"detail": @"[@[] objectsAtIndexes:[NSIndexSet indexSetWithIndex:2]];"
        },
        @{
            @"title" : @"testObjectsAtIndexesWithBeyondBounds",
            @"detail": @"[@[@\"3\"] objectsAtIndexes:[NSIndexSet indexSetWithIndex:2]];"
        },
        @{
            @"title" : @"可变数组："
        },
        @{
            @"title" : @"testMutableArrayAddNil",
            @"detail": @"NSMutableArray *array=[@[@\"value\", @\"value1\"] mutableCopy];\n[array addObject:nil];"
        },
        @{
            @"title" : @"testMutableArrayInsertBeyondBounds",
            @"detail": @"NSMutableArray *array=[@[@\"value\", @\"value1\"] mutableCopy];\n[array insertObject:@\"2\" atIndex:6];"
        },
        @{
            @"title" : @"testReplaceObjectAtIndexWithNil",
            @"detail": @"NSMutableArray *array=[@[@\"value\", @\"value1\"] mutableCopy];\n[array replaceObjectAtIndex:4 withObject:nil];"
        },
        @{
            @"title" : @"testReplaceObjectAtIndexWithBeyondBounds",
            @"detail": @"NSMutableArray *array=[@[@\"value\", @\"value1\"] mutableCopy];\n[array replaceObjectAtIndex:4 withObject:@\"2\"];"
        },
        @{
            @"title" : @"testMutableArrayObjectAtIndexWithCount0",
            @"detail": @"NSMutableArray *array=[@[]  mutableCopy];\n[array objectAtIndex:100];"
        },
        @{
            @"title" : @"testMutableArrayObjectAtIndexWithBeyondBounds",
            @"detail" : @"NSMutableArray *array=[@[@\"value\", @\"value1\"] mutableCopy];\n[array objectAtIndex:100];"
        },
        @{
            @"title" : @"testMutableArrayRemoveObjectsAtIndexesWithEmptyArray",
            @"detail" : @"NSMutableArray *mut1=[NSMutableArray new];\n[mut1 removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(10, 1)]];"
        },
        @{
            @"title" : @"testMutableArrayRemoveObjectsAtIndexesWithNil",
            @"detail" : @"NSMutableArray *mut1=[@[@\"value\", @\"value1\"] mutableCopy];\n[mut1 removeObjectsAtIndexes:nil];"
        },
        @{
            @"title" : @"testMutableArrayRemoveObjectsAtIndexesWithBeyondBounds",
            @"detail" : @"NSMutableArray *mut1=[@[@\"value\", @\"value1\"] mutableCopy];\n[mut1 removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 100)]];"
        },
        @{
            @"title":@"testRemoveObjectsInRange",
            @"detail":@"NSMutableArray *array=[NSMutableArray array];\n[array removeObjectsInRange:NSMakeRange(3, 2)];"
        },
        @{
            @"title" : @"testMutableArrayRemoveObjectInRangeWithEmptyArray",
            @"detail":@"NSMutableArray *mut1 = [@[@\"value\", @\"value1\"] mutableCopy];\n[mut1 removeObject:nil inRange:NSMakeRange(0, 6)];"
        },
        @{
            @"title" : @"testMutableArrayRemoveObjectInRangeWithBeyondBounds",
            @"detail":@"NSMutableArray *mut1=[NSMutableArray new];\n[mut1 removeObject:@\"fd\" inRange:NSMakeRange(5, 8)];"
        },
        @{
            @"title":@"testMutableArrayObjectAtIndexedSubscript",
            @"detail":@"NSMutableArray *mut1 = [NSMutableArray new];\nmut1[0];"
        }
    ];
}


- (void)testMutableArrayObjectAtIndexedSubscript
{
    NSMutableArray *mut1 = [NSMutableArray new];
    mut1[0];
}

- (void)testMutableArrayRemoveObjectsAtIndexesWithEmptyArray
{
    NSMutableArray *mut1 = [NSMutableArray new];
    [mut1 removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(10, 1)]];
}
- (void)testMutableArrayRemoveObjectsAtIndexesWithNil
{
    NSMutableArray *mut1 = [@[@"value", @"value1"]  mutableCopy];
    [mut1 removeObjectsAtIndexes:nil];
}

- (void)testMutableArrayRemoveObjectsAtIndexesWithBeyondBounds
{
    NSMutableArray *mut1 = [@[@"value", @"value1"]  mutableCopy];
    [mut1 removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 100)]];
//    [mut1 removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(100, 3)]];
}

- (void)testMutableArrayRemoveObjectInRangeWithEmptyArray
{
    NSMutableArray *mut1 = [@[@"value", @"value1"]  mutableCopy];
    [mut1 removeObject:nil inRange:NSMakeRange(0, 6)];
}
- (void)testMutableArrayRemoveObjectInRangeWithBeyondBounds
{
    NSMutableArray *mut1 = [NSMutableArray new];
    [mut1 removeObject:@"fd" inRange:NSMakeRange(5, 8)];
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
