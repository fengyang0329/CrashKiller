//
//  CrashObject.h
//  CrashKiller_Example
//
//  Created by 龙章辉 on 2021/4/1.
//  Copyright © 2021 fengyang0329. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CrashObject : NSObject

@property (nonatomic, copy) NSString *name;

+ (id)classFunc;

- (id)instanceFunc;
@end

NS_ASSUME_NONNULL_END
