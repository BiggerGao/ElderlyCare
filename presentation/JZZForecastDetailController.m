//
//  JZZForecastDetailController.m
//  ZJZWeather
//
//  Created by Jzzhou on 16/5/12.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import "JZZForecastDetailController.h"
#import "JZZRealTimeCondition.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>

@interface JZZForecastDetailController ()
@property (nonatomic, strong) NSArray *keys;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *blurredImageView;
@end

@implementation JZZForecastDetailController

+ (NSDictionary *)hourMap {
    static NSDictionary *_hourMap = nil;
    if (!_hourMap) {
        _hourMap = @{
                     @"dawn":@"黎明",
                     @"day":@"白天",
                     @"night":@"夜晚"
                     };
    }
    return _hourMap;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    _keys = [_infoDict allKeys];
}

- (void)injected {
    _tableView = [[UITableView alloc] init];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor colorWithWhite:100 alpha:0.2];
    [self.view addSubview:_tableView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGRect bounds = self.view.bounds;
    self.tableView.frame = bounds;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"bg"];
    self.backgroundImageView = [[UIImageView alloc] initWithImage:image];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundImageView];
    
    self.blurredImageView = [[UIImageView alloc] initWithImage:image];
    self.blurredImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.blurredImageView setImageToBlur:image blurRadius:10 completionBlock:nil];
    [self.view addSubview:self.blurredImageView];
    
    [self injected];
}

#pragma mark - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _keys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    NSArray *array = self.infoDict[_keys[indexPath.row]];
    NSString *dayID = array[0];
    cell.imageView.image = [UIImage imageNamed:[JZZRealTimeCondition imageMap][dayID]];
    NSString *hourStr = [JZZForecastDetailController hourMap][_keys[indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@°", hourStr, array[2]];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.text = [array[1] copy];
    cell.userInteractionEnabled = NO;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

@end
