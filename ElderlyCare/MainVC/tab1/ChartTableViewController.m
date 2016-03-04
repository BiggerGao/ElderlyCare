//
//  detailVC.m
//  CareElder
//
//  Created by Jzzhou on 16/1/29.
//
//

#import "ChartTableViewController.h"

#import "ZFChartViewController.h"
#import "MinStatusBL.h"

@interface ChartTableViewController ()

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation ChartTableViewController

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
    ZFChartViewController *viewController = [[ZFChartViewController alloc] init];
    kChartType type = (kChartType)[indexPath row];
    
    MinStatusBL *minStatusBL = [[MinStatusBL alloc] init];
    // 选择扇形图
    if(type == KChartTypePieChart)
    {
        [minStatusBL getDataOfOneHour:@"anna" at:_selectedTime withChartType:2];
    } else { // 选择柱形或折线图
        [minStatusBL getDataOfOneHour:@"anna" at:_selectedTime withChartType:1];
    }
    
    viewController.chartType = type;
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
