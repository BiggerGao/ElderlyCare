//
//  detailVC.m
//  CareElder
//
//  Created by Jzzhou on 16/2/29.
//
//

#import "ZJZChartTableViewController.h"

#import "ZFChartViewController.h"
#import "ZJZUserInfoBL.h"

@interface ZJZChartTableViewController ()

@property (nonatomic, copy) NSArray *titleArray;

@end

@implementation ZJZChartTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"运动状况查询";
    
    self.titleArray = @[@"查看柱形图", @"查看折线图", @"查看扇形图"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    ZJZUserInfoBL *infoBL = [[ZJZUserInfoBL alloc] init];
    // 选择扇形图
    if(type == KChartTypePieChart)
    {
        [infoBL getUserInfo:@"anna" at:_selectedTime withChartType:2];
    } else { // 选择柱形或折线图
        [infoBL getUserInfo:@"anna" at:_selectedTime withChartType:1];
    }
    
    chartViewController.chartType = type;
    [self.navigationController pushViewController:chartViewController animated:YES];
}

@end
