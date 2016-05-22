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
#import "ZJZOldManDAO.h"
#import <MBProgressHUD.h>

@interface ZJZDaysInfoTableViewController ()

@end

@implementation ZJZDaysInfoTableViewController

- (void)viewWillAppear:(BOOL)animated {
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ZJZOldManDAO *oldManDAO = [ZJZOldManDAO sharedManager];
    oldManDAO.oldManDaysDelegate = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [oldManDAO findAllSportStatistic:_oldMan.deviceID];
    });
}

#pragma marn - 委托协议
- (void)transferAllDays:(NSArray*)daysList {
    _dailyList = [NSArray arrayWithArray:daysList];
    [self showDays];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)showDays
{
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

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

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"%@共有%lu条记录", _oldMan.name, (unsigned long)self.dateList.count];
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZFChartViewController *chartViewController = [[ZFChartViewController alloc] init];
    
    ZJZOldManDAO *oldManDAO = [[ZJZOldManDAO alloc] init];

    NSString *date = _dateList[indexPath.row];
    // 选择扇形图
    [oldManDAO findOldManInfo:_oldMan.deviceID at:date withChartType:2];
   
    chartViewController.chartType = 2;
    [self.navigationController pushViewController:chartViewController animated:YES];
}

@end
