//
//  ZJZDaysInfoTableViewController.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/3/10.
//
//

#import "ZJZDaysInfoTableViewController.h"
#import "ZJZDailyInfo.h"
#import "ZFChartViewController.h"
#import "ZJZUserInfoBL.h"

@interface ZJZDaysInfoTableViewController ()

@end

@implementation ZJZDaysInfoTableViewController

- (NSMutableArray *)dailyList {
    if (!_dailyList) {
        _dailyList = [NSMutableArray new];
    }
    return _dailyList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(showDays:)
                                                 name:@"AllSportStatisticNoti"
                                               object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showDays:(NSNotification *)noti
{
    _dailyList = noti.object;
    NSMutableArray *tempArr = [NSMutableArray new];
    for (ZJZDailyInfo *dailyInfo in _dailyList) {
        NSString *text = dailyInfo.date;
        NSArray *strArr = [text componentsSeparatedByString:@" "];
        NSArray *strArr1 = [strArr[0] componentsSeparatedByString:@"/"];
        NSString *date = [NSString stringWithFormat:@"%@-%@-%@", strArr1[0], strArr1[1], strArr1[2]];
        [tempArr addObject:date];
    }
    _dateList = [tempArr copy];
    [self.tableView reloadData];
    self.navigationItem.title = @"运动记录表🏃";
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dateList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = _dateList[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZFChartViewController *chartViewController = [[ZFChartViewController alloc] init];
    
    ZJZUserInfoBL *infoBL = [[ZJZUserInfoBL alloc] init];

    NSString *date = _dateList[indexPath.row];
    // 选择扇形图
    [infoBL getUserInfo:@"anna" at:date withChartType:2];
   
    chartViewController.chartType = 2;
    [self.navigationController pushViewController:chartViewController animated:YES];
}

@end
