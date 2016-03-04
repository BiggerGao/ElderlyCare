//
//  CalendarVC.m
//  CareElder
//
//  Created by Jzzhou on 16/1/10.
//
//

#import "CalendarVC.h"
#import "CalendarHomeViewController.h"
#import "CalendarViewController.h"

//#import "FSCalendar/FSCalendar.h"

@interface CalendarVC ()
{
    CalendarHomeViewController *chvc;
}

@end

@implementation CalendarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.tabBarController.tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"selectedTabBar"]];
    //[self.navigationController.tabBarController.tabBar setSelectedImageTintColor:[UIColor whiteColor]];
    
    self.navigationItem.title = @"时间表";
    [self.navigationController.navigationBar setBarStyle:UIBarStyleDefault];
    
    if (!chvc) {
        chvc = [[CalendarHomeViewController alloc]init];
        
        chvc.calendartitle = @"时间表";
        
        [chvc setDays:365 ToDateforString:nil];
    }
    
    [self.view addSubview:chvc.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
