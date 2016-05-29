//
//  JZZTableViewDelegateObj.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/28.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import "JZZTemplateTableViewDelegateObj.h"
#import "JZZTemplateTableViewCell.h"
#import "JZZTemplateTableViewDataEntity.h"

@interface JZZTemplateTableViewDelegateObj ()
@property (nonatomic, strong) JZZTemplateTableViewCell *templateCell;
@end

@implementation JZZTemplateTableViewDelegateObj


+ (instancetype)createTableViewDelegateWithDataList:(NSArray *)dataList {
    return [[self alloc] initTableViewDelegateWithDataList:dataList];
}

- (instancetype)initTableViewDelegateWithDataList:(NSArray *)dataList {
    if (self = [super init]) {
        self.dataList = dataList;
    }
    return self;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
#ifdef IOS_8_NEW_FEATURE_SELF_SIZING
    return UITableViewAutomaticDimension;
#else
    
    if (! _templateCell) {
        _templateCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JZZTemplateTableViewCell class])];
        _templateCell.tag = -1000; //For debug dealloc
    }
    
    JZZTemplateTableViewDataEntity *dataEntity = _dataList[indexPath.row];
    
    if (dataEntity.cellHeight <= 0) {
        [_templateCell setupData:dataEntity];
        dataEntity.cellHeight = [_templateCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height + 0.5f;
        NSLog(@"Calculate: %ld, height: %g", (long) indexPath.row, dataEntity.cellHeight);
    } else {
        NSLog(@"Get cache: %ld, height: %g", (long) indexPath.row, dataEntity.cellHeight);
    }
    return dataEntity.cellHeight;
#endif
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JZZTemplateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([JZZTemplateTableViewCell class]) forIndexPath:indexPath];
    [cell setupData:_dataList[indexPath.row]];
    return cell;
}
@end
