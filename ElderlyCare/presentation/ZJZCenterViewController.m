//
//  CenterViewController.m
//  CareElder
//
//  Created by Jzzhou on 16/3/3.
//
//

#import "ZJZCenterViewController.h"
#import "ZJZLoginViewController.h"
#import "ZJZNavigationController.h"

#import "ZJZCenterItem.h"
#import "ZJZCenterSection.h"
#import "ZJZKeeper.h"
#import "ZJZKeeperBL.h"
#import "ZJZOldManBL.h"
#import "GlobalVariables.h"

@interface ZJZCenterViewController ()

@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, getter=isLogIn) BOOL logIn;
@property (nonatomic, strong) ZJZKeeper *keeper;
@end

@implementation ZJZCenterViewController

// 数据懒加载
- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"个人中心";

    [self addLoginViewController];
}

- (void)addLoginViewController {
    ZJZLoginViewController *loginController = [[ZJZLoginViewController alloc] init];
    ZJZNavigationController *navigationController = [[ZJZNavigationController alloc] initWithRootViewController:loginController];
    loginController.delegate = self;
    [self presentViewController:navigationController animated:NO completion:nil];
}


- (void)initTableView {
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
    // 第一组
    ZJZCenterSection *section1 = [ZJZCenterSection initWithHeaderTitle:@"看护人" footerTitle:nil];
    ZJZCenterItem *item1 = [ZJZCenterItem initWithTitle:_keeper.nickName];
    item1.image = [UIImage imageNamed:@"me"];
    item1.height = 64;
    [section1 addItem:item1];
    
    ZJZCenterItem *item2 = [ZJZCenterItem initWithTitle:@"Live with health"];
    item2.type = UITableViewCellAccessoryNone;
    [section1 addItem:item2];
    // 保存到groups中
    [self.groups addObject:section1];
    
    [self addTableView];
}

- (void)addTableView {
    
    // 第二组 老人
    ZJZCenterSection *section2 = [ZJZCenterSection initWithHeaderTitle:@"老人" footerTitle:nil];
    ZJZCenterItem *older1 = [ZJZCenterItem initWithTitle:@"Bob"];
    older1.image = [UIImage imageNamed:@"me"];
    older1.height = 64;
    [section2 addItem:older1];
    
    ZJZCenterItem *older2 = [ZJZCenterItem initWithTitle:@"Joe"];
    older2.image = [UIImage imageNamed:@"me"];
    older2.height = 64;
    [section2 addItem:older2];
    
    ZJZCenterItem *older3 = [ZJZCenterItem initWithTitle:@"Marshall"];
    older3.image = [UIImage imageNamed:@"me"];
    older3.height = 64;
    [section2 addItem:older3];
    
    [self.groups addObject:section2];
    
    [self.tableView reloadData];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - 委托响应
- (void)transferKeeperInfo:(ZJZKeeper *)keeper {
    _keeper = keeper;
    [self initTableView];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZJZCenterSection *group = self.groups[section];
    if (section > 0) {
        return group.items.count + 1;
    }
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    ZJZCenterSection *section = self.groups[indexPath.section];
    
    BOOL b_addCell = (indexPath.row == section.items.count);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (!b_addCell) {
        ZJZCenterItem *item = section.items[indexPath.row];
        cell.textLabel.text = item.title;
        cell.imageView.image = item.image;
        cell.accessoryType = item.type;
    } else {
        
    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.userInteractionEnabled = NO;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    ZJZCenterSection *group = self.groups[section];
    return group.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    ZJZCenterSection *group = self.groups[section];
    return group.footerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJZCenterSection *section = self.groups[indexPath.section];
    if (indexPath.row == section.items.count) {
        return 44;
    }
    ZJZCenterItem *item = section.items[indexPath.row];
    
    return item.height;
}

#pragma mark - tableViewDelegate
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.section == 1 && indexPath.row == 0) {
//        ZJZKeeperBL *infoBL = [[ZJZKeeperBL alloc] init];
//        [infoBL findAllInfo:_username];
//        [self performSegueWithIdentifier:@"ShowDaysInfo" sender:self];
//    }    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ZJZCenterSection *group = self.groups[indexPath.section];
        [group.items removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView reloadData];
    } else {
        
    }
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJZCenterSection *group = self.groups[indexPath.section];
//    if (indexPath.section == 0) {
//        return UITableViewCellEditingStyleNone;
//    }
    if (indexPath.row == group.items.count) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

#pragma mark - UIViewController生命周期函数，响应编辑事件
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing:editing animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
