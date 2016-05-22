//
//  ZJZChooseWeatherController.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/22.
//  Copyright © 2016 Jzzhou. All rights reserved.
//

#import "ZJZChooseWeatherController.h"
#import "JZZWeatherController.h"

@interface ZJZChooseWeatherController ()
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *controllers;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ZJZChooseWeatherController
- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"老人出行建议", @"我的出行建议"];
    }
    return _titleArray;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"出行建议";
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.controllers = @[
                         [[JZZWeatherController alloc] initWithType:JZZWeatherTypeOldMan],
                         [[JZZWeatherController alloc] initWithType:JZZWeatherTypeMyself]
                         ];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [self.navigationController pushViewController:self.controllers[indexPath.row] animated:YES];
}

@end
