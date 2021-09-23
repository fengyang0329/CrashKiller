//
//  TestFileManagerCrashVC.m
//  CrashKiller_Example
//
//  Created by 龙章辉 on 2021/9/10.
//  Copyright © 2021 fengyang0329. All rights reserved.
//

#import "TestFileManagerCrashVC.h"

@interface TestFileManagerCrashVC ()
{
    NSFileManager *fm;
}
@end

@implementation TestFileManagerCrashVC

- (void)viewDidLoad {
    [super viewDidLoad];
    fm = [NSFileManager defaultManager];
    self.didSelectRowWithEvent = YES;
    self.titleArray = @[
        @{
            @"title" : @"testFileExistsAtPath",
            @"detail" : @"path is nil"
         },
        @{
            @"title" : @"testFileExistsAtPathisDirectory",
            @"detail": @"path is nil"
         },
        @{
            @"title" : @"testMoveItemAtPath",
            @"detail": @"path is nil"
         },
       @{
           @"title" : @"testmoveItemAtURL",
           @"detail": @"url is nil"
        },
        @{
            @"title" : @"testCopyItemAtPath",
            @"detail": @"path is nil"
         },
        @{
            @"title" : @"testCopyItemAtURL",
            @"detail": @"url is nil"
         }
    ];
}
- (void)testFileExistsAtPath
{
    [fm fileExistsAtPath:nil];
}
- (void)testFileExistsAtPathisDirectory
{
    BOOL dir;
    [fm fileExistsAtPath:nil isDirectory:&dir];
}
- (void)testMoveItemAtPath
{
    [fm moveItemAtPath:nil toPath:nil error:nil];
}
- (void)testmoveItemAtURL
{
    [fm moveItemAtURL:nil toURL:nil error:nil];
}
- (void)testCopyItemAtPath
{
    [fm copyItemAtPath:nil toPath:nil error:nil];
}
- (void)testCopyItemAtURL
{
    [fm copyItemAtURL:nil toURL:nil error:nil];
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
