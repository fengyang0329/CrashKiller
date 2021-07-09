//
//  BaseTestViewController.m
//  CoreEngine_Example
//
//  Created by 龙章辉 on 2021/6/24.
//  Copyright © 2021 fengyang0329. All rights reserved.
//

#import "BaseTestViewController.h"

@interface BaseTestViewController ()

@end

@implementation BaseTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
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

    return self.didSelectRowWithEvent?90:44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellID];
    }
    NSDictionary *dic = _titleArray[indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"title"];
    cell.detailTextLabel.text = @"";
    cell.detailTextLabel.textColor = [UIColor grayColor];
    if ([dic.allKeys containsObject:@"detail"]) {
        NSString *detailText = dic[@"detail"];
        cell.detailTextLabel.text = detailText;
        cell.detailTextLabel.numberOfLines = 0;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.didSelectRowWithEvent) {

        NSDictionary *item =  self.titleArray[indexPath.row];
        NSString *title = item[@"title"];
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        SEL sel = NSSelectorFromString(title);
        if ([self respondsToSelector:sel]) {
            [self performSelector:sel];
        }
    #pragma clang diagnostic pop

    }else{

        NSDictionary *item =  _titleArray[indexPath.row];
        NSString *title = item[@"title"];
        Class cls = NSClassFromString([item objectForKey:@"class"]);
        UIViewController *vc = (UIViewController *)[[cls alloc] init];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)alertWithTitle:(NSString *)title message:(NSString *)message completionHandler:(void(^)(void))completionHandler
{

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction* ok = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK")
                                                 style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction* action)
                         {
        if (completionHandler) {
            completionHandler();
        }
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
