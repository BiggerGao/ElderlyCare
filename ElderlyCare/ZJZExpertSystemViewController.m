//
//  ExpertSystemViewController.m
//  CareElder
//
//  Created by Jzzhou on 16/3/3.
//
//

#import "ZJZExpertSystemViewController.h"

@interface ZJZExpertSystemViewController ()

@end

@implementation ZJZExpertSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"专家系统";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    NSDictionary *naviTitleDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Futura-Medium" size:20.0], NSFontAttributeName, nil];
    [self.navigationController.navigationBar setTitleTextAttributes:naviTitleDict];
    
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
