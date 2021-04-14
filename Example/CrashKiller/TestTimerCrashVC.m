//
//  TestTimerCrashVC.m
//  CrashKiller_Example
//
//  Created by 龙章辉 on 2021/4/2.
//  Copyright © 2021 fengyang0329. All rights reserved.
//

#import "TestTimerCrashVC.h"

@interface TestTimerCrashVC ()

@property(nonatomic,strong)NSTimer *timer;

@end

@implementation TestTimerCrashVC

- (void)dealloc
{
    NSLog(@"***********%s",__func__);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(timerFunc:) userInfo:nil repeats:YES];
}
- (void)timerFunc:(NSTimer *)t
{
    NSLog(@"*********");
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
