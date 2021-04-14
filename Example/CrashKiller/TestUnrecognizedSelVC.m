//
//  TestUnrecognizedSelVC.m
//  CrashKiller_Example
//
//  Created by 龙章辉 on 2021/4/2.
//  Copyright © 2021 fengyang0329. All rights reserved.
//

#import "TestUnrecognizedSelVC.h"
#import "CrashObject.h"

@interface TestUnrecognizedSelVC ()

@end

@implementation TestUnrecognizedSelVC
{
    NSArray *_titleArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupDataSource];

    [self setupUI];
}

- (void)setupDataSource {
    _titleArray = @[
                    @"找不到 button 响应事件",
                    @"找不到控制器中的方法(未声明未实现)",
                    @"找不到对象方法(声明了没有实现)",
                    @"找不到类方法(声明了没有实现)",
                    @"调用 null 对象的方法",
                    @"传参类型不匹配",
                    @"id 类型",
                    ];
}

- (void)setupUI {
    CGFloat buttonWidth = (CGRectGetWidth([UIScreen mainScreen].bounds)-60);
    CGFloat buttonHeight = 44;
    CGFloat buttonSpace = 30;
    CGFloat buttonGap = 10;
    for (int i = 0; i < _titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 1000+i;
        [button setTitle:_titleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        button.titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        button.frame = CGRectMake(buttonSpace, 100+(buttonHeight+buttonGap)*i, buttonWidth, buttonHeight);
        if (i == 0) {
            [button addTarget:self action:@selector(undefinedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        }

        button.layer.cornerRadius = 5;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        button.backgroundColor = [UIColor colorWithRed:214/255.0 green:235/255.0 blue:253/255.0 alpha:1];
        [self.view addSubview:button];
    }
}


- (void)buttonClick:(UIButton *)button {
    NSInteger buttonTag = button.tag;
    switch (buttonTag) {
        case 1000: {

        }
            break;
        case 1001: {
            [self performSelector:@selector(undefinedVCSelector)];
        }
            break;
        case 1002: {
            CrashObject *object = [[CrashObject alloc] init];
            [object instanceFunc];
        }
            break;
        case 1003: {
            [CrashObject classFunc];
        }
            break;
        case 1004: {
            [[NSNull null] performSelector:@selector(undefinedSelector)];
        }
            break;
        case 1005: {
            [self gg3:@123];
        }
            break;
        case 1006: {
            id str = @123;
            [str appendString:@"Hello World"];
        }
            break;
        default:
            break;
    }
}

- (void)gg3:(NSString *)str
{
   //没有对参数进行类型判断
   NSInteger length = str.length;
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
