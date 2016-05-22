//
//  CenterViewController.m
//  CareElder
//
//  Created by Jzzhou on 16/3/3.
//
//

#import "ZJZCenterViewController.h"
#import "ZJZLoginViewController.h"
#import "ZJZKeeperViewController.h"
#import "ZJZAddOldManViewController.h"
#import "ZJZDeviceIDViewController.h"
#import "ZJZOldManCell.h"
#import "ZJZOldManListViewController.h"

#import "SJAvatarBrowser.h"

#import "ZJZCenterItem.h"
#import "ZJZCenterSection.h"
#import "ZJZKeeper.h"
#import "ZJZKeeperDAO.h"
#import "ZJZOldMan.h"
#import "ZJZOldManDAO.h"
#import "Color-Tool.h"


static NSString *const CellKeeperIdentifier = @"CellKeeperIdentifier";
static NSString *const CellPrimaryOldManIdentifier = @"CellPrimaryOldManIdentifier";
static NSString *const CellOldManIdentifier = @"CellOldManIdentifier";
static NSString *const CellAddIdentifier = @"CellAddIdentifier";

@interface ZJZCenterViewController ()

@property (nonatomic, getter=isLogIn) BOOL logIn;
@property (nonatomic, strong) ZJZKeeper *keeper;
@property (nonatomic, strong) NSArray *oldManArray;
@property (nonatomic, strong) UIButton *addOldManBtn;
@property (nonatomic, strong) NSMutableArray *oldManAvatarNameArr;
@property (nonatomic, strong) NSMutableArray *oldWomanAvatarNameArr;

@end

@implementation ZJZCenterViewController

#pragma mark - 数据懒加载

- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (NSMutableArray *)oldManAvatarNameArr {
    if (!_oldManAvatarNameArr) {
        _oldManAvatarNameArr = [NSMutableArray array];
        for (int i = 1; i <= 2; ++i) {
            NSString *name = [NSString stringWithFormat:@"oldman%d", i];
            [_oldManAvatarNameArr addObject:name];
        }
    }
    return _oldManAvatarNameArr;
}

- (NSMutableArray *)oldWomanAvatarNameArr {
    if (!_oldManAvatarNameArr) {
        _oldManAvatarNameArr = [NSMutableArray array];
        for (int i = 1; i <= 1; ++i) {
            NSString *name = [NSString stringWithFormat:@"oldman%d", i];
            [_oldManAvatarNameArr addObject:name];
        }
    }
    return _oldManAvatarNameArr;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - 请登录
- (UIButton *)withoutLogInButton {
    if (!_withoutLogInButton) {
        _withoutLogInButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 85, self.view.bounds.size.width - 40, 37)];
        [_withoutLogInButton setTitle:@"请登陆" forState:UIControlStateNormal];
        [_withoutLogInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _withoutLogInButton.titleLabel.font = [UIFont systemFontOfSize:17];
        _withoutLogInButton.backgroundColor = ZJZColor(213, 54, 65, 1);
        _withoutLogInButton.layer.cornerRadius = 5.0f;
        
        [_withoutLogInButton addTarget:self action:@selector(addLoginViewController) forControlEvents:UIControlEventTouchUpInside];
    }
    return _withoutLogInButton;
}



- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.withoutLogInButton];
}


#pragma mark - 登陆成功 初始化
- (void)initKeeper {
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.view addSubview:self.tableView];
    // Keeper
    ZJZCenterSection *section1 = [ZJZCenterSection initWithHeaderTitle:@"看护人" footerTitle:nil];
    ZJZCenterItem *item1 = [ZJZCenterItem initWithTitle:_keeper.nickname];
    
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *keeperPhotoPath = [documentPath stringByAppendingPathComponent:[_keeper getKeeperPhoto]];
    item1.imageName = [NSString stringWithContentsOfFile:keeperPhotoPath encoding:NSUTF8StringEncoding error:nil];
    if (!item1.imageName) {
        item1.imageName =@"keeper";
    }
    item1.height = 60;
    
    [section1 addItem:item1];
    
    ZJZCenterItem *item2 = [ZJZCenterItem initWithTitle:@"Live with health"];
    item2.type = UITableViewCellAccessoryNone;
    [section1 addItem:item2];

    [self.groups addObject:section1];
    
    // Old Men
    [self initOldMan];
}

- (void)initOldMan
{
    ZJZCenterSection *section2 = [ZJZCenterSection initWithHeaderTitle:@"首要分析对象" footerTitle:nil];
    ZJZCenterItem *item = [ZJZCenterItem initWithTitle:@"未设置"];
    [section2 addItem:item];
    [self.groups addObject:section2];
    
    ZJZOldManDAO *oldManDAO = [ZJZOldManDAO sharedManager];
    oldManDAO.oldManCenterDelegate = self;
    [oldManDAO findOldManList:self.keeper];
}


#pragma mark - 登陆委托响应
- (void)logoutKeeper {
    [self.groups removeAllObjects];
    [self.oldManAvatarNameArr removeAllObjects];
    self.oldManAvatarNameArr = nil;
    self.keeper = nil;
    [self.tableView reloadData];
    [self.tableView removeFromSuperview];
    [self.view addSubview:self.withoutLogInButton];
    
    [self addLoginViewController];
}

- (void)transferKeeperInfo:(ZJZKeeper *)keeper {
    [_withoutLogInButton removeFromSuperview];
    _withoutLogInButton = nil;
    _keeper = keeper;
    [self initKeeper];
}

#pragma mark - 初始化老人列表
- (void)transOldManInfo:(NSArray *)oldManArray {
    _oldManArray = oldManArray;
    
    ZJZCenterSection *section3 = [ZJZCenterSection initWithHeaderTitle:@"老人" footerTitle:nil];

    // 第二组 老人
    for (ZJZOldMan *oldMan in self.oldManArray) {
        ZJZCenterItem *older = [self setOldManItem:oldMan];
        [section3 addItem:older];
    }
    [self.groups addObject:section3];
    
    [self.tableView reloadData];
}

- (void)passPrimaryOldMan:(ZJZOldMan *)oldMan {
    self.primaryOldMan = oldMan;
    ZJZCenterSection *section = self.groups[1];
    [section.items removeAllObjects];
    ZJZCenterItem *item = [self setOldManItem:oldMan];
    [section addItem:item];
    
    [self.tableView reloadData];
}

#pragma mark - 添加老人按钮响应
- (void)addOldMan
{
    ZJZDeviceIDViewController *deviceIDViewController = [[ZJZDeviceIDViewController alloc] init];
    deviceIDViewController.keeperID = _keeper.keeperID;
    [self.navigationController pushViewController:deviceIDViewController animated:YES];
}

#pragma mark - private method

- (ZJZCenterItem *)setOldManItem:(ZJZOldMan*)oldMan {
    ZJZCenterItem *item = [ZJZCenterItem initWithOldman:oldMan];
    item.height = 80;
    item.type = UITableViewCellAccessoryDisclosureIndicator;
    item.imageName = oldMan.avatarName;
    if (!item.imageName) {
        if (self.oldManAvatarNameArr) {
            NSString *string = [[_oldManAvatarNameArr firstObject] copy];
            item.imageName = [string copy];
            oldMan.avatarName = [string copy];
            [_oldManAvatarNameArr removeObjectAtIndex:0];
        }
    }
    return item;
}


- (void)setUserImageView:(UIImageView*)imageView
{
    NSLog(@"%ld", (long)imageView.tag);
    CGFloat radius = CGRectGetHeight([imageView bounds]) / 2;
    NSLog(@"%f", radius);
    //圆角的半径
    imageView.layer.cornerRadius = CGRectGetHeight([imageView bounds]) / 2;
    //是否显示圆角以外的部分
    imageView.layer.masksToBounds = YES;
    //边框宽度
    imageView.layer.borderWidth = 2.5;
    //边框颜色
    imageView.layer.borderColor = [ZJZColor(213, 54, 65, 1) CGColor];
}

- (void)showAvatar:(UITapGestureRecognizer*)sender {
    [SJAvatarBrowser showImage:(UIImageView*)sender.view];
}

- (void)addLoginViewController {
    ZJZLoginViewController *loginController = [[ZJZLoginViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:loginController];
    loginController.delegate = self;
    [self presentViewController:navigationController animated:YES completion:nil];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!_groups.count) {
        return 0;
    }
    ZJZCenterSection *group = self.groups[section];
    if (section > 1) {
        return group.items.count + 1;
    }
    return group.items.count;
}

// Title
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (!_groups) {
        return nil;
    }
    ZJZCenterSection *group = self.groups[section];
    return group.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (!_groups) {
        return nil;
    }
    ZJZCenterSection *group = self.groups[section];
    return group.footerTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!_groups) {
        return 0;
    }
    ZJZCenterSection *section = self.groups[indexPath.section];
    if (indexPath.row == section.items.count) {
        return 44;
    }
    ZJZCenterItem *item = section.items[indexPath.row];
    
    return item.height;
}

// Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJZCenterSection *section = self.groups[indexPath.section];
    
    // Keeper section
    if (indexPath.section == 0 && indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellKeeperIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellKeeperIdentifier];
        }
        ZJZCenterItem *item = section.items[indexPath.row];
        cell.textLabel.text = item.title;
        
        if (item.imageName) {
            cell.imageView.image = [UIImage imageNamed:item.imageName];
            [self setUserImageView:cell.imageView];
            
            cell.imageView.userInteractionEnabled = YES;
            cell.imageView.tag = indexPath.row + indexPath.section * 100;
            UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAvatar:)];
            tapped.numberOfTapsRequired = 1;
            [cell.imageView addGestureRecognizer:tapped];
        }
        cell.accessoryType = item.type;
        
        if (indexPath.row == 1) {
            cell.userInteractionEnabled = NO;
        }
        return cell;
    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        static NSString const* CellSign = @"CellSign";
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellSign];
        
        ZJZCenterItem *item = section.items[indexPath.row];
        cell.textLabel.text = item.title;
        cell.accessoryType = item.type;
        cell.userInteractionEnabled = NO;
        return cell;
    }
    // Primary OldMan Section
    static BOOL isRegNib = NO;
    if (!isRegNib) {
        [tableView registerNib:[UINib nibWithNibName:@"ZJZOldManCell" bundle:nil] forCellReuseIdentifier:CellOldManIdentifier];
    }
    
    if (indexPath.section == 1) {
        ZJZCenterItem *item = section.items[indexPath.row];
        
        if ([item.title isEqualToString:@"未设置"]) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellPrimaryOldManIdentifier];
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellPrimaryOldManIdentifier];
            }
            cell.textLabel.text = item.title;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.userInteractionEnabled = NO;
            return cell;
        } else {
            ZJZOldManCell *cell = [tableView dequeueReusableCellWithIdentifier:CellOldManIdentifier forIndexPath:indexPath];
            cell.nameLabel.text = item.title;
            cell.headImageView.image = [UIImage imageNamed:item.imageName];
            [self setUserImageView:cell.headImageView];
            cell.headImageView.userInteractionEnabled = YES;
            cell.headImageView.tag = indexPath.row + indexPath.section * 100;
            UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAvatar:)];
            tapped.numberOfTapsRequired = 1;
            [cell.headImageView addGestureRecognizer:tapped];
            
            cell.oldMan = _oldManArray[indexPath.row];
            cell.accessoryType = item.type;
            return cell;
        }
        
    }
    // oldman section
    BOOL b_addCell = (indexPath.row == section.items.count);
    
    if (!b_addCell) {
        
        ZJZOldManCell *cell = [tableView dequeueReusableCellWithIdentifier:CellOldManIdentifier forIndexPath:indexPath];
        
        ZJZCenterItem *item = section.items[indexPath.row];
        cell.nameLabel.text = item.title;
        
        cell.headImageView.image = [UIImage imageNamed:item.imageName];
        [self setUserImageView:cell.headImageView];
        cell.headImageView.userInteractionEnabled = YES;
        cell.headImageView.tag = indexPath.row + indexPath.section * 100;
        UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAvatar:)];
        tapped.numberOfTapsRequired = 1;
        [cell.headImageView addGestureRecognizer:tapped];
        
        cell.oldMan = _oldManArray[indexPath.row];
        cell.accessoryType = item.type;
            return cell;
        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellAddIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellAddIdentifier];
        }

        if (!_addOldManBtn) {
            _addOldManBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            _addOldManBtn.frame = CGRectMake(15,0,400,44);
            _addOldManBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
            
            [_addOldManBtn setTitle:@"添加老人" forState:UIControlStateNormal];
            [_addOldManBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
            
            _addOldManBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            [_addOldManBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_addOldManBtn setTintColor:[UIColor whiteColor]];
            [_addOldManBtn addTarget:self action:@selector(addOldMan) forControlEvents:UIControlEventTouchUpInside];
            [cell.contentView addSubview:_addOldManBtn];
            _addOldManBtn.hidden = YES;
        }
        
        return cell;
    }
}


#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        ZJZKeeperViewController *keeperViewController = [[ZJZKeeperViewController alloc] init];
        keeperViewController.titleStr = _keeper.nickname;
        keeperViewController.delegate = self;
        [self.navigationController pushViewController:keeperViewController animated:YES];
        return;
    }
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ZJZOldManListViewController *oldManInfoVC = [storyboard instantiateViewControllerWithIdentifier:@"ZJZOldMan"];
    ZJZOldMan *oldMan = [[ZJZOldMan alloc] init];
    if (indexPath.section == 1 && indexPath.row == 0) {
        oldMan = _primaryOldMan;
    } else {
        oldMan = _oldManArray[indexPath.row];
    }

    oldManInfoVC.oldMan = [oldMan copy];
    oldManInfoVC.delegate = self;
    [self.navigationController pushViewController:oldManInfoVC animated:YES];
    
    return;
}


#pragma mark - tableViewDelegate 编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 || indexPath.section == 1) {
        return NO;
    }
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJZCenterSection *group = self.groups[indexPath.section];
    
    if (indexPath.row == group.items.count) {
        return UITableViewCellEditingStyleInsert;
    } else {
        return UITableViewCellEditingStyleDelete;
    }
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"TEST");
}

- (void)tableView:(UITableView *)tableView
didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"End,TEST");
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


#pragma mark - UIViewController生命周期函数，响应编辑事件
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [self.tableView setEditing:editing animated:YES];
    if (editing) {
        self.addOldManBtn.hidden = NO;
    } else {
        self.addOldManBtn.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
