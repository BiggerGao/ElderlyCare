//
//  ZJZThirdViewController.m
//  ContainerViewControllerDemo
//
//  Created by Jzzhou on 16/3/17.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import "ZJZThirdViewController.h"
#import "JZZDiseaseManager.h"
#import "JZZTemplateTableViewDelegateObj.h"
#import "JZZTemplateTableViewCell.h"
#import "JZZTemplateTableViewDataEntity.h"

@interface ZJZThirdViewController ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) JZZTemplateTableViewDelegateObj *tableDelegate;
@end

@implementation ZJZThirdViewController

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
    // 发病症状
    [[RACObserve([JZZDiseaseManager shareManager], symptom)
      deliverOn:[RACScheduler mainThreadScheduler]]
     subscribeNext:^(JZZSymptom *symptom) {
         if (! symptom) {
             return ;
         }
         NSDictionary *dict = @{@"症状" : symptom.symptom,
                                @"表现" : symptom.symptomText
                                };
         
         NSMutableArray *tmpData = [NSMutableArray array];
         NSArray *keys = dict.allKeys;
         for (int i = 0; i < keys.count; ++i) {
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

- (UIRectEdge)edgesForExtendedLayout {
    return UIRectEdgeNone;
}

@end
