//
//  NSObject+CrashKillerMethodSwizzling.m
//  CrashKiller
//
//  Created by 龙章辉 on 2021/3/29.
//

#import "NSObject+CrashKillerMethodSwizzling.h"

@implementation NSObject (CrashKillerMethodSwizzling)

+ (void)crashKillerMethodSwizzlingClassMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector withClass:(Class)targetClass {

    //如果没有开启防护，则不做任何处理
    if ([CrashKillerManager shareManager].isStart) {
        crashKillerSwizzlingClassMethod(targetClass, originalSelector, swizzledSelector);
    }
}

+ (void)crashKillerMethodSwizzlingInstanceMethod:(SEL)originalSelector withMethod:(SEL)swizzledSelector withClass:(Class)targetClass {

    //如果没有开启防护，则不做任何处理
    if ([CrashKillerManager shareManager].isStart) {
        crashKillerSwizzlingInstanceMethod(targetClass, originalSelector, swizzledSelector);
    }
}

// 交换两个类方法的实现
void crashKillerSwizzlingClassMethod(Class class, SEL originalSelector, SEL swizzledSelector) {

    Method originalMethod = class_getClassMethod(class, originalSelector);
    Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
    Class metacls = objc_getMetaClass(NSStringFromClass(class).UTF8String);
    BOOL didAddMethod = class_addMethod(metacls,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(metacls,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}



// 交换两个对象方法的实现
void crashKillerSwizzlingInstanceMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

    BOOL didAddMethod = class_addMethod(class,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));

    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
