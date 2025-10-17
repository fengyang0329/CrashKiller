//
//  BaseTestViewController.h
//  CoreEngine_Example
//
//  Created by 龙章辉 on 2021/6/24.
//  Copyright © 2021 fengyang0329. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseTestViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, assign) BOOL didSelectRowWithEvent;


- (void)alertWithTitle:(NSString *)title message:(NSString *)message completionHandler:(void(^)(void))completionHandler;
@end

