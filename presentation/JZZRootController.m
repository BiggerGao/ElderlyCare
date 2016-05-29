//
//  JZZRootController.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/27.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import "JZZRootController.h"
#import "ZJZFirstViewController.h"
#import "ZJZSecondViewController.h"
#import "ZJZThirdViewController.h"
#import "ZJZForthViewController.h"
#import "JZZDiseaseManager.h"

@interface JZZRootController ()

@end


@implementation JZZRootController


- (void)injected {
    self.title = @"专家推荐";
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    self.contentViewFrame = CGRectMake(0, 44, screenSize.width, screenSize.height);
    self.tabBar.frame = CGRectMake(0, 0, screenSize.width, 44);
    
    self.tabBar.itemTitleColor = [UIColor lightGrayColor];
    self.tabBar.itemTitleSelectedColor = [UIColor redColor];
    self.tabBar.itemTitleFont = [UIFont systemFontOfSize:17];
    self.tabBar.itemTitleSelectedFont = [UIFont systemFontOfSize:22];
    
    [self.tabBar setScrollEnabledAndItemWidth: screenSize.width/self.viewControllers.count];
    [self setContentScrollEnabledAndTapSwitchAnimated:NO];
    self.tabBar.itemFontChangeFollowContentScroll = NO;
    self.tabBar.itemSelectedBgScrollFollowContent = YES;
    self.tabBar.userInteractionEnabled = NO;
    self.tabBar.itemSelectedBgColor = [UIColor redColor];
    [self.tabBar setItemSelectedBgInsets:UIEdgeInsetsMake(40, 10, 0, 10) tapSwitchAnimated:NO];

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViewControllers];
    
    [self injected];

}

- (void)initViewControllers {
    
    ZJZFirstViewController *controller1 = [[ZJZFirstViewController alloc] init];
    controller1.yp_tabItemTitle = @"患病";
    
    ZJZSecondViewController *controller2 = [[ZJZSecondViewController alloc] init];
    controller2.yp_tabItemTitle = @"饮食";
    
    ZJZThirdViewController *controller3 = [[ZJZThirdViewController alloc] init];
    controller3.yp_tabItemTitle = @"症状";
    
    ZJZForthViewController *controller4 = [[ZJZForthViewController alloc] init];
    controller4.yp_tabItemTitle = @"药物";
    
    
    self.viewControllers = [NSMutableArray arrayWithObjects:controller1, controller2, controller3, controller4, nil];
    
}

@end
