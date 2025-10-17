//
//  MOPerson.m
//  CrashKiller_Example
//
//  Created by 龙章辉 on 2021/4/1.
//  Copyright © 2021 fengyang0329. All rights reserved.
//

#import "MOPerson.h"

@implementation MOPerson

//- (NSString *)getName {
//  return @"getName";
//}
//- (NSString *)name {
//  return @"name";
//}
//- (NSString *)isName {
//  return @"isName";
//}
//- (NSString *)_name {
//  return @"_name";
//}

- (NSUInteger)countOfName { // 必须实现
  NSLog(@"%s", __func__);
  return 1;
}
// 下面两个方法，实现其中一个
//- (id)objectInNameAtIndex:(NSUInteger)index { // 优先调用
//  NSLog(@"%s", __func__);
//  return self.names[index];
//}
//// 上一个方法未实现，则会调用该方法
//- (NSArray *)nameAtIndexes:(NSIndexSet *)indexes {
//  NSLog(@"%s", __func__);
//  return [self.names objectsAtIndexes:indexes];
//}

@end
