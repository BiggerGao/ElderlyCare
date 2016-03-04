//
//  ZFChartViewController.m
//  CareElder
//
//  Created by Jzzhou on 16/3/1.
//
//

#import "ZFChartViewController.h"
#import "ZFChart.h"

@interface ZFChartViewController ()

@property (strong, nonatomic) NSArray *xLineTitleArray;
@property (strong, nonatomic) NSArray *xLineValueArray;

@end

@implementation ZFChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"选择" style:UIBarButtonItemStyleDone target:self action:nil];
    
    self.navigationItem.rightBarButtonItem = item;
    
    self.view.backgroundColor = ZFWhite;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadData:)
                                                 name:@"2.5MinXMLFileParseEndNoti"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadData:)
                                                 name:@"1HourXMLFileParseEndNoti"
                                               object:nil];
    
}

- (void)loadData:(NSNotification *)noti;
{
    _dict = noti.object;
    _date = [_dict objectForKey:@"date"];
    _theData = [_dict objectForKey:@"1HourData"];
    NSArray *strArr = [_date componentsSeparatedByString:@"-"];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@年%@月%@号",strArr[0], strArr[1], strArr[2]];

    
    switch (self.chartType) {
        case 0:
            [self showBarChart];
            break;
        case 1:
            [self showLineChart];
            break;
        case 2:
            [self showPieChart];
            break;
            
        default:
            break;
    }

}

- (void)showBarChart{
    CGFloat height = SCREEN_HEIGHT - self.navigationController.navigationBar.bounds.size.height - self.tabBarController.tabBar.bounds.size.height;
    ZFBarChart *barChart = [[ZFBarChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    
    [self setXLineTitleArrayForBarOrLineChart];
    [self setXLineValueArrayForBarOrLineChart];
    
    if([_theData count] == 0) {
        barChart.title = [NSString stringWithFormat:@"没有今天的运动数据."];
        [self.view addSubview:barChart];
        return;
    }
    if (!_date) {
        barChart.title = [NSString stringWithFormat:@"网络无连接"];
        [self.view addSubview:barChart];
        return;
    }
    
    int stepCnt = 0;
    for (NSString *stepStr in _xLineValueArray) {
        stepCnt += [stepStr intValue];
    }
    barChart.title = [NSString stringWithFormat:@"今日步行总数:%d",stepCnt];
    
    barChart.xLineValueArray = [[NSMutableArray alloc] initWithArray:_xLineValueArray];
    barChart.xLineTitleArray = [[NSMutableArray alloc] initWithArray:_xLineTitleArray];
    
    barChart.yLineMaxValue = 3000;
    barChart.yLineSectionCount = 6;
    
    [self.view addSubview:barChart];
    [barChart strokePath];
}

- (void)showLineChart{
    CGFloat height = SCREEN_HEIGHT - self.navigationController.navigationBar.bounds.size.height - self.tabBarController.tabBar.bounds.size.height;
    ZFLineChart *lineChart = [[ZFLineChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    
    [self setXLineTitleArrayForBarOrLineChart];
    [self setXLineValueArrayForBarOrLineChart];
    
    if([_theData count] == 0) {
        lineChart.title = [NSString stringWithFormat:@"没有今天的运动数据."];
        [self.view addSubview:lineChart];
        return;
    }
    if (!_date) {
        lineChart.title = [NSString stringWithFormat:@"网络无连接"];
        [self.view addSubview:lineChart];
        return;
    }

    int stepCnt = 0;
    for (NSString *stepStr in _xLineValueArray) {
        stepCnt += [stepStr intValue];
    }
    lineChart.title = [NSString stringWithFormat:@"今日步行总数:%d",stepCnt];
    
    lineChart.xLineValueArray = [[NSMutableArray alloc] initWithArray:_xLineValueArray];
    lineChart.xLineTitleArray = [[NSMutableArray alloc] initWithArray:_xLineTitleArray];
    
    lineChart.yLineMaxValue = 3000;
    lineChart.yLineSectionCount = 6;
    
    [self.view addSubview:lineChart];
    [lineChart strokePath];
}

- (void)showPieChart{
    CGFloat height = SCREEN_HEIGHT - self.navigationController.navigationBar.bounds.size.height - self.tabBarController.tabBar.bounds.size.height;
    ZFPieChart *pieChart = [[ZFPieChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, height)];
    
    if([_theData count] == 0) {
        pieChart.title = [NSString stringWithFormat:@"没有今天的运动数据."];
        [self.view addSubview:pieChart];
        return;
    }
    if (!_date) {
        pieChart.title = [NSString stringWithFormat:@"网络无连接"];
        [self.view addSubview:pieChart];
        return;
    }
    
    NSMutableDictionary *dateDict = [_theData lastObject];
    [dateDict removeObjectForKey:@"Date"];
    [dateDict removeObjectForKey:@"deviceID"];
    
    NSDictionary *reverseDict = [[NSDictionary alloc] initWithObjects:@[@"跑步", @"走路", @"静坐", @"睡觉"] forKeys:@[dateDict[@"run"], dateDict[@"walk"], dateDict[@"rest"], dateDict[@"sleep"]]];

    NSArray *sortedArray = [[reverseDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSNumber *number1 = [[NSNumber alloc] initWithFloat:[obj1 floatValue]];
        NSNumber *number2 = [[NSNumber alloc] initWithFloat:[obj2 floatValue]];
        NSComparisonResult *result = [number1 compare:number2];
        return result == NSOrderedDescending;
    }];
    
    NSArray *nameArray = [[NSArray alloc] initWithObjects:
                          [reverseDict[sortedArray[1]] stringByAppendingString:@"(优秀)"],
                          [reverseDict[sortedArray[0]] stringByAppendingString:@"(保持)"],
                          [reverseDict[sortedArray[2]] stringByAppendingString:@"(良好)"],
                          [reverseDict[sortedArray[3]] stringByAppendingString:@"(警告)"], nil];
                          
    NSArray *valueArray = [[NSArray alloc] initWithObjects:
                           sortedArray[1],
                           sortedArray[0],
                           sortedArray[2],
                           sortedArray[3], nil];
                           
    
    pieChart.nameArray = [NSMutableArray arrayWithArray:nameArray];
    pieChart.valueArray = [NSMutableArray arrayWithArray:valueArray];
    
    pieChart.colorArray = [NSMutableArray arrayWithObjects:GREAT_COLOR, GOOD_COLOR, WARNING_COLOR, UNHEALTHY_COLOR, nil];
    pieChart.percentType = kPercentTypeInteger;
    pieChart.title = @"今日运动评估:";
    
    [self.view addSubview:pieChart];
    [pieChart strokePath];
}


// 设置Bar或LineX横坐标标题
- (void)setXLineTitleArrayForBarOrLineChart
{
    _xLineTitleArray = [[NSArray alloc] initWithObjects:@"03:00", @"04:00", @"05:00", @"06:00", @"07:00", @"08:00", @"09:00", @"10:00", @"11:00", @"12:00", @"13:00", @"14:00", @"15:00", @"16:00", @"17:00", @"18:00", @"19:00", @"20:00", @"21:00", @"22:00", @"23:00", @"00:00", @"01:00", @"02:00", nil];
}

// 设置Bar或LineX横坐标对应值
- (void)setXLineValueArrayForBarOrLineChart
{
    NSMutableArray *xLineValueArrayBetween0To3 = [NSMutableArray new];
    NSMutableArray *xLineValueArrayAfter3 = [NSMutableArray new];
    
    for (int i = 0; i < _theData.count; ++i) {
        NSDictionary *hourInfo = [_theData objectAtIndex:i];
        NSString *sportTimePerHourStr = [hourInfo objectForKey:@"sport"];
        int step = [sportTimePerHourStr floatValue] * 60 * SPROT_PARAM_PER_MIN;
        NSString *stepStr = [NSString stringWithFormat:@"%d", step];
        
        NSString *date = [hourInfo objectForKey:@"Date"];
        NSString *dateTime = [date substringWithRange:NSMakeRange(date.length - 8, 8)];
        if ([[dateTime substringToIndex:1] isEqualToString:@" "]) {
            dateTime = [dateTime substringWithRange: NSMakeRange(1, 1)];
        } else {
            dateTime = [dateTime substringWithRange: NSMakeRange(0, 2)];
        }

        if ([dateTime intValue] < 3) {
            [xLineValueArrayBetween0To3 addObject:stepStr];
        } else {
            [xLineValueArrayAfter3 addObject:stepStr];
        }
    }
    NSMutableArray *xLineValueArray = [[NSMutableArray alloc] initWithArray:xLineValueArrayAfter3];
    for (int i = 0; i < xLineValueArrayBetween0To3.count; ++i) {
        [xLineValueArray addObject:[xLineValueArrayBetween0To3 objectAtIndex:i]];
    }
        
    _xLineValueArray = xLineValueArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
