//
//  CenterViewController.m
//  CareElder
//
//  Created by Jzzhou on 16/3/3.
//
//

#import "ZJZCenterViewController.h"
#import "ZJZLoginViewController.h"
#import "ZJZCenterItem.h"
#import "ZJZCenterSection.h"
#import "ZJZUserInfoBL.h"

@interface ZJZCenterViewController ()

@property (nonatomic, strong) ZJZLoginViewController *loginViewController;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, strong) NSMutableArray *groups;
@property (nonatomic, getter=isLogIn) BOOL logIn;

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
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"个人中心";
    
    _logIn = NO;
    
    if (!_logIn) {
        self.view.backgroundColor = [UIColor whiteColor];
        _loginViewController = [[ZJZLoginViewController alloc] init];
        [self.view addSubview:_loginViewController.view];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(addTableView:)
                                                 name:@"LoginNotification"
                                               object:nil];
}

- (void)addTableView:(NSNotification *)noti {
    _username = (NSString *)noti.object;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];

    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    // 第一组
    ZJZCenterSection *section1 = [ZJZCenterSection initWithHeaderTitle:@"被看护人" footerTitle:nil];
    ZJZCenterItem *item1 = [ZJZCenterItem initWithTitle:@"Anna"];
    item1.image = [UIImage imageNamed:@"me"];
    item1.height = 64;
    [section1 addItem:item1];
    
    ZJZCenterItem *item2 = [ZJZCenterItem initWithTitle:@"Live with health"];
    item2.type = UITableViewCellAccessoryNone;
    [section1 addItem:item2];
    // 保存到groups中
    [self.groups addObject:section1];
    
    [_tableView reloadData];
    
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZJZCenterSection *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    ZJZCenterSection *section = self.groups[indexPath.section];
    ZJZCenterItem *item = section.items[indexPath.row];
    cell.textLabel.text = item.title;
    cell.imageView.image = item.image;
    cell.accessoryType = item.type;
    
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
    ZJZCenterItem *item = section.items[indexPath.row];
    return item.height;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        ZJZUserInfoBL *infoBL = [ZJZUserInfoBL new];
        [infoBL findAllInfo:_username];
        [self performSegueWithIdentifier:@"ShowDaysInfo" sender:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
