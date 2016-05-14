//
//  ViewController.m
//  ZJZWeather
//
//  Created by Jzzhou on 16/5/10.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import "JZZWeatherController.h"
#import <LBBlurredImage/UIImageView+LBBlurredImage.h>
#import <MJRefresh/MJRefresh.h>
#import "JZZManager.h"
#import "JZZLifeCellTableViewCell.h"
#import "JZZForecastDetailController.h"
#import <Masonry.h>

static NSString *const LifeCellIdentifier = @"ZJZLifeCell";

@interface JZZWeatherController ()
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *blurredImageView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, assign) CGFloat screenHeight;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation JZZWeatherController

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"紫外线", @"出行", @"感冒", @"穿衣"];
    }
    return _titleArray;
}

- (void)injected {
    // 1
    self.screenHeight = [UIScreen mainScreen].bounds.size.height - self.tabBarController.tabBar.bounds.size.height;
    
    UIImage *background = [UIImage imageNamed:@"bg"];
    
    // 2
    self.backgroundImageView = [[UIImageView alloc] initWithImage:background];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundImageView];
    
    // 3
    self.blurredImageView = [[UIImageView alloc] init];
    self.blurredImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.blurredImageView.alpha = 0;
    [self.blurredImageView setImageToBlur:background blurRadius:10 completionBlock:nil];
    [self.view addSubview:self.blurredImageView];
    
    // 4
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor colorWithWhite:100 alpha:0.2];
    self.tableView.pagingEnabled = YES;
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [[JZZManager sharedManager] findCurrentLocation];
        [self.tableView.mj_header endRefreshing];
    }];

    [self.tableView.mj_header beginRefreshing];
    
    // 初始化UI
    
    CGRect headerFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.screenHeight);
    CGFloat inset = 20;
    CGFloat temperatureHeight = 110;
    CGFloat windHeight = 40;
    CGFloat iconHeight = 30;
    CGFloat dateHeight = 30;
    CGRect windSpeedFrame = CGRectMake(inset, headerFrame.size.height - windHeight, headerFrame.size.width - 2*inset, windHeight);
    CGRect temperatureFrame = CGRectMake(inset, headerFrame.size.height - temperatureHeight - windHeight, headerFrame.size.width - 2*inset, temperatureHeight);
    CGRect dateFrame = CGRectMake(inset, headerFrame.size.height - windHeight - temperatureHeight - iconHeight - dateHeight, headerFrame.size.width - 2*inset, dateHeight);
    CGRect iconFrame = CGRectMake(inset, temperatureFrame.origin.y - iconHeight, iconHeight, iconHeight);
    CGRect conditionsFrame = iconFrame;
    // make the conditions text a little smaller than the view
    // and to the right of our icon
    conditionsFrame.size.width = self.view.bounds.size.width - 2*inset - iconHeight - 10;
    conditionsFrame.origin.x = iconFrame.origin.x + iconHeight + 10;
    
    _headView = [[UIView alloc] initWithFrame:headerFrame];
    _headView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = _headView;
    
    // bottom left
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:dateFrame];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.textColor = [UIColor whiteColor];
    dateLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    [_headView addSubview:dateLabel];
    
    // bottom left
    UILabel *temperatureLabel = [[UILabel alloc] initWithFrame:temperatureFrame];
    temperatureLabel.backgroundColor = [UIColor clearColor];
    temperatureLabel.textColor = [UIColor whiteColor];
    temperatureLabel.text = @"0°";
    temperatureLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:120];
    [_headView addSubview:temperatureLabel];
    
    // bottom left
    UILabel *windSpeedLabel = [[UILabel alloc] initWithFrame:windSpeedFrame];
    windSpeedLabel.backgroundColor = [UIColor clearColor];
    windSpeedLabel.textColor = [UIColor whiteColor];
    windSpeedLabel.text = @"";
    windSpeedLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    [_headView addSubview:windSpeedLabel];
    
    // bottom left
    UILabel *conditionsLabel = [[UILabel alloc] initWithFrame:conditionsFrame];
    conditionsLabel.backgroundColor = [UIColor clearColor];
    conditionsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    conditionsLabel.textColor = [UIColor whiteColor];
    [_headView addSubview:conditionsLabel];
    
    // bottom left
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:iconFrame];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    iconView.backgroundColor = [UIColor clearColor];
    [_headView addSubview:iconView];
    
    // top
    UILabel *cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, 30)];
    cityLabel.backgroundColor = [UIColor clearColor];
    cityLabel.textColor = [UIColor whiteColor];
    cityLabel.text = @"Loading...";
    cityLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:30];
    cityLabel.textAlignment = NSTextAlignmentCenter;
    [_headView addSubview:cityLabel];

    // top_back
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 30, 30)];
    [button setImage:[UIImage imageNamed:@"img_back"] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(popController) forControlEvents:UIControlEventTouchUpInside];
    [self.headView addSubview:button];
    
    [[RACObserve([JZZManager sharedManager], realTimeCondition)
     deliverOn:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(JZZRealTimeCondition *newCondition) {
         if (! newCondition) {
             return ;
         }
         temperatureLabel.text = [NSString stringWithFormat:@"%.0f°", newCondition.temperature.floatValue];
         cityLabel.text = newCondition.locationName;
         conditionsLabel.text = newCondition.weatherInfo;
         iconView.image = [UIImage imageNamed:[newCondition imageName]];
         windSpeedLabel.text =[NSString stringWithFormat:@"风速 %@ / %@  %@", newCondition.windSpeed, newCondition.windPower, newCondition.windDirect];
         NSString *date = newCondition.date;
         NSArray *array = [date componentsSeparatedByString:@"-"];
         NSString *newDate = [NSString stringWithFormat:@"%@年%@月%@日", array[0], array[1], array[2]];
         dateLabel.text = [NSString stringWithFormat:@"%@ 星期%@", newDate, [newCondition.week stringValue]];
     }];
     
    [[RACObserve([JZZManager sharedManager], lifeCondition)
     deliverOn:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(JZZLifeCondition *newCondition) {
         [self.tableView reloadData];
     }];
    
    [[JZZManager sharedManager] findCurrentLocation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self injected];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
   return UIStatusBarStyleLightContent;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    self.backgroundImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.screenHeight);
    self.blurredImageView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.screenHeight);
    self.tableView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.screenHeight);
}

#pragma mark - Primary methods
- (void)popController {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [JZZManager sharedManager].lifeArray.count + 1;
    }
    return [JZZManager sharedManager].forecast.weather.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell = [self configureHeaderCellWithtitle:@"老人小贴士"];
        }
        else {
//            static BOOL isRegNib = NO;
//            if (! isRegNib) {
//                [self.tableView registerNib:[UINib nibWithNibName:@"JZZLifeCellTableViewCell" bundle:nil] forCellReuseIdentifier:LifeCellIdentifier];
//            }
            JZZLifeCondition *life = [JZZManager sharedManager].lifeCondition;
            cell = [self configureLifeCellAtIndexPath:indexPath life:life];
        }
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell = [self configureHeaderCellWithtitle:@"天气预报"];
        }
        else {
            cell = [self configureForecastCellAtIndexPath:indexPath];
        }
    }
    return cell;
}

- (UITableViewCell *)configureHeaderCellWithtitle:(NSString *)title {
    static NSString *HeadCellIdentifier = @"HeadCellIdentifier";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:HeadCellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:HeadCellIdentifier];
    }
//    cell.userInteractionEnabled = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    cell.textLabel.text = title;
    cell.detailTextLabel.text = @"";
    cell.imageView.image = nil;
    
    return cell;
}

- (UITableViewCell *)configureLifeCellAtIndexPath:(NSIndexPath *)indexPath life:(JZZLifeCondition *)life {
//    JZZLifeCellTableViewCell *lifeCell = [self.tableView dequeueReusableCellWithIdentifier:LifeCellIdentifier];
//    NSArray *lifeArray = [JZZManager sharedManager].lifeArray;
//    lifeCell.catagoryImgeView.image = [UIImage imageNamed:[JZZManager sharedManager].imageArray[indexPath.row - 1]];
//    lifeCell.catagoryTitle.text = self.titleArray[indexPath.row - 1];
//    lifeCell.roughDescription.text = lifeArray[indexPath.row - 1][0];
//    lifeCell.describeTextView.text = lifeArray[indexPath.row - 1][1];
    
    UITableViewCell *lifeCell = [self.tableView dequeueReusableCellWithIdentifier:LifeCellIdentifier];
    if (! lifeCell) {
        lifeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:LifeCellIdentifier];
    }
    NSArray *lifeArray = [JZZManager sharedManager].lifeArray;
//    lifeCell.catagoryImgeView.image = [UIImage imageNamed:[JZZManager sharedManager].imageArray[indexPath.row - 1]];
    lifeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    lifeCell.textLabel.text = self.titleArray[indexPath.row - 1];
    lifeCell.detailTextLabel.text = lifeArray[indexPath.row - 1][0];
    lifeCell.textLabel.textColor = [UIColor whiteColor];
    lifeCell.detailTextLabel.textColor = [UIColor whiteColor];
    lifeCell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
//    lifeCell.describeTextView.text = lifeArray[indexPath.row - 1][1];
    return lifeCell;
}

- (UITableViewCell *)configureForecastCellAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ForecastCellIdentifier = @"ForecastIdentifier";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ForecastCellIdentifier];
    if (! cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ForecastCellIdentifier];
    }
    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];
    cell.detailTextLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18];
    NSDictionary *forecastInfoDict = [JZZManager sharedManager].forecast.weather[indexPath.row - 1];
    if (indexPath.row == 1) {
        cell.textLabel.text = @"今天";
    }
    else {
        cell.textLabel.text = forecastInfoDict[@"date"];
    }
    cell.detailTextLabel.text = [NSString stringWithFormat:@"星期%@", forecastInfoDict[@"week"]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    return cell;
}

#pragma mark - UITableviewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        return 80;
//    }
//    if (indexPath.section == 0) {
//        return 130;
//    }
//    else {
        NSInteger cellCount = [self tableView:tableView numberOfRowsInSection:indexPath.section];
        return self.screenHeight / (CGFloat)cellCount;
//    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 || indexPath.section == 0) {
        return;
    }
    JZZForecastDetailController *detailController = [[JZZForecastDetailController alloc] init];
    NSDictionary *forecastInfoDict = [JZZManager sharedManager].forecast.weather[indexPath.row - 1];
    if (indexPath.row == 1) {
        detailController.title = @"今天";
    }
    else {
        detailController.title = forecastInfoDict[@"date"];
    }
    detailController.infoDict = forecastInfoDict[@"info"];
    [self.navigationController pushViewController:detailController animated:YES];
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat height = scrollView.bounds.size.height;
    CGFloat position = MAX(scrollView.contentOffset.y, 0.0);
    CGFloat percent = MIN(position / height, 1.0);
    self.blurredImageView.alpha = percent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
