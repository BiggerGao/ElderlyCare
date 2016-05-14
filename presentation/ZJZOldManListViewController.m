//
//  ZJZOldManInfoViewController.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/4/1.
//
//

#import "ZJZOldManListViewController.h"
#import "ZJZDaysInfoTableViewController.h"
#import <MBProgressHUD.h>
#import "Color-Tool.h"
#import "GlobalVariablesManager.h"
#import "ZJZOldManDetailViewController.h"
#import "ZJZOldManProfileViewController.h"
#import "ZJZOldManFamilyBindingView.h"
#import "ZJZOldManCityBindingView.h"

@interface ZJZOldManListViewController ()
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, strong) NSArray *exampleControllers;
@end

@implementation ZJZOldManListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.exampleControllers = @[
                                [[ZJZOldManProfileViewController alloc] initWithTitle:@"老人资料" oldMan:_oldMan],
                                [[ZJZOldManDetailViewController alloc] initWithTitle:@"亲属绑定" viewClass:ZJZOldManFamilyBindingView.class],
                                [[ZJZOldManDetailViewController alloc] initWithTitle:@"城市绑定" viewClass:ZJZOldManCityBindingView.class],
                                ];
    self.navigationItem.title = _oldMan.name;
    _titleArray = @[@[@"老人资料", @"亲属绑定", @"城市绑定",@"运动情况"], @[@"设为主要查看对象"]];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [_titleArray[0] count];
    } else {
        return [_titleArray[1] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = _titleArray[indexPath.section];
    
    if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OldManInfoCell"];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = array[indexPath.row];
        cell.textLabel.textColor = ZJZBLUECOLOR;
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OldManInfoCell"];
    if (indexPath.section == 0) {
        
    }
    cell.textLabel.text = array[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 3)
    {
        ZJZDaysInfoTableViewController *daysInfoVC = [[ZJZDaysInfoTableViewController alloc] init];
        daysInfoVC.oldMan = _oldMan;
        [self.navigationController pushViewController:daysInfoVC animated:YES];
    }
    else if (indexPath.section == 0)
    {
        // 其他view
        UIViewController *viewController = self.exampleControllers[indexPath.row];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if (indexPath.section == 1) {
        GlobalVariablesManager *manager = [GlobalVariablesManager sharedManager];
        manager.currOldMan = _oldMan;
        
        [self.delegate passPrimaryOldMan:_oldMan];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"设置成功";
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.8 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // Do something...
            [self.navigationController popViewControllerAnimated:YES];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }
}

@end
