//
//  AppDelegate.m
//  CareElder
//
//  Created by Jzzhou on 16/2/29.
//
//

#import "AppDelegate.h"
#import "ZFConst.h"
#import "TTViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // navigationBar 全局设置
    UINavigationBar* navigationBar = [UINavigationBar appearance];
    navigationBar.translucent = NO;
    [navigationBar setBarStyle:UIBarStyleBlack];
    
    NSDictionary *naviTitleDict = @{NSFontAttributeName: [UIFont fontWithName:@"Futura-Medium" size:20.0]};
    [navigationBar setTitleTextAttributes:naviTitleDict];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [navigationBar setBarTintColor:ZFColor(213, 54, 65, 1)];
    
    // 返回键全局设置
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    // tabBar全局设置
    UITabBar *tabBar = [UITabBar appearance];
    [tabBar setSelectionIndicatorImage:[UIImage imageNamed:@"selectedTabBar"]];
    [tabBar setSelectedImageTintColor:[UIColor whiteColor]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
