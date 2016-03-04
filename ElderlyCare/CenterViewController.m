//
//  CenterViewController.m
//  CareElder
//
//  Created by Jzzhou on 16/3/3.
//
//

#import "CenterViewController.h"

@interface CenterViewController ()

@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.navigationItem.title = @"个人中心";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    NSDictionary *naviTitleADict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Futura-Medium" size:20.0],NSFontAttributeName,nil];//[UIColor whiteColor],NSForegroundColorAttributeName,
    [self.navigationController.navigationBar setTitleTextAttributes:naviTitleADict];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:213/255.0 green:54/255.0 blue:65/255.0 alpha:1]];
    
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
