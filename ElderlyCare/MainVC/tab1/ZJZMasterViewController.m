//
//  CYCalendarVC.m
//  CareElder
//
//  Created by Jzzhou on 16/2/28.
//
//

#import "ZJZMasterViewController.h"
#import "ZJZChartTableViewController.h"
#import "ZJZUserInfoBL.h"

#define IOS6_LATER (floor(NSFoundationVersionNumber)>NSFoundationVersionNumber_iOS_6_1)

@interface ZJZMasterViewController ()
{
    UIScrollView        *_detailScrollView;
    UILabel             *_lunarLabel;
    UILabel             *_constellationLabel;
    UILabel             *_weekdayLabel;
    UILabel             *_yiLabel;
    UILabel             *_jiLabel;
    UILabel             *_ganZhiLabel;
    UILabel             *_chongShaLabel;
    UILabel             *_wuXingLabel;
}

@end

@implementation ZJZMasterViewController
{
    NSString *_previousSelectedDate;
    NSString *_selectedTime;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController.tabBarController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"selectedTabBar"]];
    [self.navigationController.tabBarController.tabBar setSelectedImageTintColor:[UIColor whiteColor]];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    NSDictionary *naviTitleADict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Futura-Medium" size:20.0],NSFontAttributeName,nil];//[UIColor whiteColor],NSForegroundColorAttributeName,
    [self.navigationController.navigationBar setTitleTextAttributes:naviTitleADict];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:213/255.0 green:54/255.0 blue:65/255.0 alpha:1]];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
 
    self.navigationItem.title = @"时间表";
    
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.delegate = self;
    [self.view addSubview:calendar];
    
     // iOS 7 specific
    self.navigationController.navigationBar.translucent = NO;
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        calendar.frame=CGRectMake(0, 20, calendar.frame.size.width, calendar.frame.size.height);
    }
    
    _detailScrollView=[[UIScrollView alloc] init];
    
    [self.view addSubview:_detailScrollView];
    
    _lunarLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    [_lunarLabel setFont:[UIFont systemFontOfSize:14]];
    [_lunarLabel setTextColor:[UIColor blackColor]];
    [_detailScrollView addSubview:_lunarLabel];
    
    _ganZhiLabel=[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_lunarLabel.frame), 10, 220, 20)];
    [_ganZhiLabel setFont:[UIFont systemFontOfSize:13]];
    [_ganZhiLabel setTextColor:[UIColor blackColor]];
    [_detailScrollView addSubview:_ganZhiLabel];
    
    _constellationLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_lunarLabel.frame), 40, 20)];
    [_constellationLabel setFont:[UIFont systemFontOfSize:12]];
    [_constellationLabel setTextColor:[UIColor blackColor]];
    [_detailScrollView addSubview:_constellationLabel];
    
    _weekdayLabel =[[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_constellationLabel.frame), CGRectGetMaxY(_lunarLabel.frame), 100, 20)];
    [_weekdayLabel setFont:[UIFont systemFontOfSize:12]];
    [_weekdayLabel setTextColor:[UIColor blackColor]];
    [_detailScrollView addSubview:_weekdayLabel];
    
    _yiLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_constellationLabel.frame), 300, 20)];
    [_yiLabel setFont:[UIFont systemFontOfSize:12]];
    [_yiLabel setTextColor:[UIColor blackColor]];
    [_detailScrollView addSubview:_yiLabel];
    
    _jiLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_yiLabel.frame), 300, 20)];
    [_jiLabel setFont:[UIFont systemFontOfSize:12]];
    [_jiLabel setTextColor:[UIColor blackColor]];
    [_detailScrollView addSubview:_jiLabel];
    
    _chongShaLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_jiLabel.frame), 300, 20)];
    [_chongShaLabel setFont:[UIFont systemFontOfSize:12]];
    [_chongShaLabel setTextColor:[UIColor blackColor]];
    [_detailScrollView addSubview:_chongShaLabel];
    
    _wuXingLabel =[[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_chongShaLabel.frame), 300, 20)];
    [_wuXingLabel setFont:[UIFont systemFontOfSize:12]];
    [_wuXingLabel setTextColor:[UIColor blackColor]];
    [_detailScrollView addSubview:_wuXingLabel];
    
    [_detailScrollView setContentSize:CGSizeMake(320, 160)];
}


-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    _previousSelectedDate = nil;
    
    NSDate *currentDate = [NSDate date];
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:currentDate]; // Get necessary date components
    
    [components month]; //gives you month
    [components day]; //gives you day
    [components year];
    
    if (month==[components month]) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        [calendarView markDates:dates];
    }
    
    [_detailScrollView setFrame:CGRectMake(0, targetHeight+(IOS6_LATER?20:0), 320, self.view.bounds.size.height-targetHeight)];
}


#pragma mark - 单击或双击日期事件
-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date lunarDict:(NSMutableDictionary*) dict
{
    [_lunarLabel setText:[dict objectForKey:@"LunarDate"]];
    [_constellationLabel setText:[dict objectForKey:@"Constellation"]];
    [_weekdayLabel setText:[dict objectForKey:@"Weekday"]];
    
    [_yiLabel setText:[dict objectForKey:@"Yi"]];
    [_jiLabel setText:[dict objectForKey:@"Ji"]];
    [_ganZhiLabel setText:[dict objectForKey:@"GanZhi"]];
    [_chongShaLabel setText:[dict objectForKey:@"Chong"]];
    [_wuXingLabel setText:[dict objectForKey:@"WuXing"]];
    
    NSString *time = [dict objectForKey:@"GregorianDate"];

    NSString *timeStr = [NSString stringWithFormat:@"%@-%@-%@",
                         [time substringWithRange:NSMakeRange(0, 4)],
                         [time substringWithRange:NSMakeRange(4, 2)],
                         [time substringWithRange:NSMakeRange(6, 2)]];

    // 单击
    if (![_previousSelectedDate isEqualToString:time]) {
        _previousSelectedDate = time;
        return;
    }
    
    _selectedTime = timeStr;
    [self performSegueWithIdentifier:@"toSelectChartTableView" sender:nil];
}

#pragma mark - 数据存储传递
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ZJZChartTableViewController *descon = (ZJZChartTableViewController *)segue.destinationViewController;
    descon.selectedTime = _selectedTime;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
