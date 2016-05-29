//
//  ZJZForthViewController.m
//  ContainerViewControllerDemo
//
//  Created by Jzzhou on 16/3/17.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import "ZJZForthViewController.h"
#import "JZZDiseaseManager.h"
#import "JZZTemplateTableViewDelegateObj.h"
#import "JZZTemplateTableViewCell.h"
#import "JZZTemplateTableViewDataEntity.h"

@interface ZJZForthViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JZZTemplateTableViewDelegateObj *tableDelegate;
@end

@implementation ZJZForthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
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

    // 可用药物
    [[RACObserve([JZZDiseaseManager shareManager], drugSupport)
      deliverOn:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(JZZDrugSupport *drugSupport) {
         if (! drugSupport) {
             return ;
         }
         NSDictionary *dict = @{@"可用药物" : drugSupport.drug,
                                @"详情" : drugSupport.drugText
                                };
         
         NSMutableArray *tmpData = [NSMutableArray array];
         NSArray *keys = dict.allKeys;
         for (int i = (int)keys.count - 1; i >= 0; --i) {
             JZZTemplateTableViewDataEntity *entity = [JZZTemplateTableViewDataEntity new];
             //             entity.avatar = [UIImage imageNamed:@"bluefaces_1"];
             entity.title = keys[i];
             entity.title = keys[i];
             entity.content = [dict[keys[i]] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
             entity.content = [entity.content stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
             entity.content = [entity.content stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
             
             [tmpData addObject:entity];
         }
         _tableDelegate.dataList = tmpData;
         [_tableView reloadData];
     }];
}



@end
