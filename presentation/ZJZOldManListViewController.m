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
#import "ZJZOldManCityBindingViewController.h"
#import "ZJZOldManProfileViewController.h"
#import "ZJZOldManFamilierBindingViewController.h"


@interface ZJZOldManListViewController ()
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, strong) NSArray *exampleControllers;
@end

@implementation ZJZOldManListViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.exampleControllers = @[
                                [[ZJZOldManProfileViewController alloc] initWithTitle:@"老人资料" oldMan:_oldMan],
                                [[ZJZOldManCityBindingViewController alloc] initWithTitle:@"居住城市" oldMan:_oldMan],
                                [[ZJZOldManFamilierBindingViewController alloc] initWithTitle:@"老人亲属" oldMan:_oldMan]
                                ];
    self.navigationItem.title = _oldMan.name;
    _titleArray = @[@[@"老人运动情况", @"老人详细资料", @"老人居住城市", @"老人亲属"], @[@"设为主要查看对象"]];
}


- (void)showTelNumber:(UITapGestureRecognizer*)sender {
//    __weak typeof(self) wself = self;
//    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
//                                                             delegate:wself
//                                                    cancelButtonTitle:@"取消"
//                                               destructiveButtonTitle:nil
//                                                    otherButtonTitles:_oldMan.emergencyTel, nil];
//    actionSheet.actionSheetStyle = UIActionSheetStyleAutomatic;
//    [actionSheet showInView:self.view];
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", _oldMan.emergencyTel];
    UIWebView *callWebView = [[UIWebView alloc] init];
    [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebView];
}

#pragma mark - actionsheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        return;
    }
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@", _oldMan.emergencyTel];
    UIWebView *callWebView = [[UIWebView alloc] init];
    [callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebView];
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
    if (indexPath.section == 0 && indexPath.row == 3) {
        UIImage *telImage = [UIImage imageNamed:@"telephone"];
        
        UIImageView *telImageView = [[UIImageView alloc] initWithImage:telImage];
        telImageView.userInteractionEnabled = YES;
        [telImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTelNumber:)]];
        
        cell.accessoryView = telImageView;
    }
    cell.textLabel.text = array[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0 && indexPath.row == 0)
    {
        ZJZDaysInfoTableViewController *daysInfoVC = [[ZJZDaysInfoTableViewController alloc] init];
        daysInfoVC.oldMan = _oldMan;
        [self.navigationController pushViewController:daysInfoVC animated:YES];
    }
    else if (indexPath.section == 0)
    {
        // 其他view
        UIViewController *viewController = self.exampleControllers[indexPath.row - 1];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if (indexPath.section == 1) {
        GlobalVariablesManager *manager = [GlobalVariablesManager sharedManager];
        [manager setCurrOldMan:self.oldMan];
        
        [self.delegate passPrimaryOldMan:_oldMan];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"设置成功";
        
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            // Do something...
            [self.navigationController popViewControllerAnimated:YES];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    }
    
    
}

@end
