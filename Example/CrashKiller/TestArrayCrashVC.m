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
    id obj;
    [NSArray arrayWithObject:obj];
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
    id obj;
    [@[] objectsAtIndexes:obj];
}
- (void)testObjectsAtIndexesWithEmptyArray
{
    [@[] objectsAtIndexes:[NSIndexSet indexSetWithIndex:2]];
}
- (void)testObjectsAtIndexesWithBeyondBounds
{
    [@[@"3"] objectsAtIndexes:[NSIndexSet indexSetWithIndex:2]];
    [@[@"55"] objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(3, 2)]];
}


#pragma mark 可变数组
- (void)testMutableArrayAddNil
{
    id obj;
    NSMutableArray *array = [@[@"value", @"value1"]  mutableCopy];
    [array addObject:obj];
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

- (void)testMutableArrayInsertBeyondBounds
{
    NSMutableArray *array = [@[@"value", @"value1"]  mutableCopy];
    [array insertObject:@"2" atIndex:6];
}
- (void)testReplaceObjectAtIndexWithNil
{
    id obj;
    NSMutableArray *array = [@[@"value", @"value1"]  mutableCopy];
    [obj replaceObjectAtIndex:4 withObject:@"ff"];
    [array replaceObjectAtIndex:4 withObject:obj];
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
    [self testInitWithNilObject];
    [self testArrayByAddingNilObject];
    [self testObjectAtIndexWhenArrayCount0];
    [self testObjectAtIndexWhenArrayCount1];
    [self testSubarrayWithRangeWhenArrayCount0];
    [self testSubarrayWithRangeBeyondBounds];
    [self testObjectsAtIndexesWithNil];
    [self testObjectsAtIndexesWithEmptyArray];
    [self testObjectsAtIndexesWithBeyondBounds];

    [self testMutableArrayAddNil];
    [self testMutableArrayInsertBeyondBounds];

    [self testReplaceObjectAtIndexWithNil];
    [self testReplaceObjectAtIndexWithBeyondBounds];

    [self testMutableArrayObjectAtIndexWithCount0];
    [self testMutableArrayObjectAtIndexWithBeyondBounds];

    [self testMutableArrayRemoveObjectsAtIndexesWithEmptyArray];
    [self testMutableArrayRemoveObjectsAtIndexesWithNil];
    [self testMutableArrayRemoveObjectsAtIndexesWithBeyondBounds];

    [self testMutableArrayRemoveObjectInRangeWithEmptyArray];
    [self testMutableArrayRemoveObjectInRangeWithBeyondBounds];
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
    [mut1 removeObjectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(100, 3)]];
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
