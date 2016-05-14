//
//  detailVC.m
//  CareElder
//
//  Created by Jzzhou on 16/2/29.
//
//

#import "ZJZChartTableViewController.h"

#import "ZFChartViewController.h"
#import "ZJZKeeperDAO.h"
#import "ZJZOldManDAO.h"
#import "GlobalVariablesManager.h"
#import <MBProgressHUD.h>

@interface ZJZChartTableViewController ()

@property (nonatomic, copy) NSArray *titleArray;

@end

@implementation ZJZChartTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"运动状况查询";
    
    self.titleArray = @[@"当日运动统计", @"当日行为趋势", @"当日运动评估"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZFChartViewController *chartViewController = [[ZFChartViewController alloc] init];
    kChartType type = (kChartType)[indexPath row];
    
    ZJZOldManDAO *oldManDAO = [[ZJZOldManDAO alloc] init];
    GlobalVariablesManager *manager = [GlobalVariablesManager sharedManager];
    ZJZOldMan *currOldMan = manager.currOldMan;
    if (!currOldMan) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"未设置看护对象";
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.7 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
        return;
    }
    // 选择扇形图
    if(type == KChartTypePieChart)
    {
        [oldManDAO findOldManInfo:currOldMan.deviceID at:_selectedTime withChartType:2];
    } else { // 选择柱形或折线图
        [oldManDAO findOldManInfo:currOldMan.deviceID at:_selectedTime withChartType:1];
    }
    
    chartViewController.chartType = type;
    [self.navigationController pushViewController:chartViewController animated:YES];
}

@end
