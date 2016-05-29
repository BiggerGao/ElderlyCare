//
//  ZJZFirstViewController.m
//  ContainerViewControllerDemo
//
//  Created by Jzzhou on 16/3/17.
//  Copyright © 2016 Jzzhou. All rights reserved.
//

#import "ZJZFirstViewController.h"
#import "JZZDiseaseManager.h"
#import "GlobalVariablesManager.h"
#import "JZZTemplateTableViewDelegateObj.h"
#import "JZZTemplateTableViewCell.h"
#import "JZZTemplateTableViewDataEntity.h"
#import <Masonry.h>

@interface ZJZFirstViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JZZTemplateTableViewDelegateObj *tableDelegate;

@end

@implementation ZJZFirstViewController

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (! [GlobalVariablesManager sharedManager].currOldMan) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"未选择老人" message:@"亲，请先选择指定老人" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
        
        return;
    }
    
    _tableDelegate = [[JZZTemplateTableViewDelegateObj alloc] init];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.delegate = _tableDelegate;
    _tableView.dataSource = _tableDelegate;
    _tableView.estimatedRowHeight = 80.0f;
    _tableView.tableFooterView = [UIView new];
    
#ifdef IOS_8_NEW_FEATURE_SELF_SIZING
    // ios 8 的 self-sizing特性
    if ([UIDevice currentDevice].systemVersion.integerValue > 7) {
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
#endif
    
    // 注册cell
    [_tableView registerClass:[JZZTemplateTableViewCell class] forCellReuseIdentifier:NSStringFromClass([JZZTemplateTableViewCell class])];
    [self.view addSubview:_tableView];
    
    // 病情描述
    [[RACObserve([JZZDiseaseManager shareManager], disease)
      deliverOn:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(JZZDisease *disease) {
         if (! disease) {
             return ;
         }
         NSDictionary *dict = @{@"患病部位" : disease.place,
                                @"医院负责部门" : disease.department,
                                @"详细信息" : disease.message
                                };
         
         NSMutableArray *tmpData = [NSMutableArray array];
         NSArray *keys = dict.allKeys;
         for (int i = 0; i < keys.count; ++i) {
             JZZTemplateTableViewDataEntity *entity = [JZZTemplateTableViewDataEntity new];
//             entity.avatar = [UIImage imageNamed:@"bluefaces_1"];
             entity.title = keys[i];
             entity.content = dict[keys[i]];
             [tmpData addObject:entity];
         }
         _tableDelegate.dataList = tmpData;
         [_tableView reloadData];
     }];
}


//- (UIRectEdge)edgesForExtendedLayout {
//    return UIRectEdgeNone;
//}

@end
