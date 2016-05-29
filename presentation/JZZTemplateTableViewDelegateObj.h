//
//  JZZTableViewDelegateObj.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/28.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZZTemplateTableViewDelegateObj : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataList;

+ (instancetype)createTableViewDelegateWithDataList:(NSArray *)dataList;

@end
