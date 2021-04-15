//
//  KILLViewController.m
//  CrashKiller
//
//  Created by fengyang0329 on 03/29/2021.
//  Copyright (c) 2021 fengyang0329. All rights reserved.
//

#import "KILLViewController.h"
#include <objc/runtime.h>
#import "CrashObject.h"
#import <CrashKiller.h>


@interface Person : NSObject

- (void)fun;

@end

@implementation Person

- (void)fun {
    NSLog(@"fun");
}

@end

@interface KILLViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation KILLViewController
{
    NSArray *_titleArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.title = @"防崩溃测试";
    _titleArray = @[
        @{
            @"title" : @"Unrecognized Selector Crash",
            @"class" : @"TestUnrecognizedSelVC"
        },
        @{
            @"title" : @"KVO Crash",
            @"class" : @"TestKVOCrashVC"
        },
        @{
            @"title" : @"KVC Crash",
            @"class" : @"TestKVCCrashVC"
        },
        @{
            @"title" : @"NSTimer Crash",
            @"class" : @"TestTimerCrashVC"
        },
        @{
            @"title" : @"NSNull Crash",
            @"class" : @"TestNullVC"
        },
        @{
            @"title" : @"Containers Crash",
            @"class" : @"TestContainerCrashVC"
        }
    ];
    [self.view addSubview:self.tableView];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    }
    cell.textLabel.text = [_titleArray[indexPath.row] objectForKey:@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSDictionary *item =  _titleArray[indexPath.row];
    NSString *title = item[@"title"];
    Class cls = NSClassFromString([item objectForKey:@"class"]);
    UIViewController *vc = (UIViewController *)[[cls alloc] init];
    vc.title = title;
    [self.navigationController pushViewController:vc animated:YES];
}


//
////// 重写 resolveInstanceMethod: 添加对象方法实现
////+ (BOOL)resolveInstanceMethod:(SEL)sel {
////    if (sel == @selector(fun)) { // 如果是执行 fun 函数，就动态解析，指定新的 IMP
////        //特殊参数：v@:,具体可参考官方文档：https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtTypeEncodings.html#//apple_ref/doc/uid/TP40008048-CH100
////        class_addMethod([self class], sel, (IMP)funMethod, "v@:");
////        return YES;
////    }
////    return [super resolveInstanceMethod:sel];
////}
//
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    return YES; // 为了进行下一步 消息接受者重定向
//}
//
//// 消息接受者重定向
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(fun)) {
//        return [[Person alloc] init];
//        // 返回 Person 对象，让 Person 对象接收这个消息
//    }
//
//    return [super forwardingTargetForSelector:aSelector];
//}
//
////void funMethod(id obj, SEL _cmd) {
////    NSLog(@"funMethod"); //新的 fun 函数
////}


//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    return YES; // 为了进行下一步 消息接受者重定向
//}
//
//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    return nil; // 为了进行下一步 消息重定向
//}
//
//// 获取函数的参数和返回值类型，返回签名
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    if ([NSStringFromSelector(aSelector) isEqualToString:@"fun"]) {
//        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//    }
//    return [super methodSignatureForSelector:aSelector];
//}
//
//// 消息重定向
//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    SEL sel = anInvocation.selector;   // 从 anInvocation 中获取消息
//    Person *p = [[Person alloc] init];
//    if([p respondsToSelector:sel]) {   // 判断 Person 对象方法是否可以响应 sel
//        [anInvocation invokeWithTarget:p];  // 若可以响应，则将消息转发给其他对象处理
//    } else {
//        [self doesNotRecognizeSelector:sel];  // 若仍然无法响应，则报错：找不到响应方法
//    }
//}



@end
