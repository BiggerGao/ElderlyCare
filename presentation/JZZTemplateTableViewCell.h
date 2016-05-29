//
//  JZZTableViewCell.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/28.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JZZTemplateTableViewDataEntity;

@interface JZZTemplateTableViewCell : UITableViewCell

- (void)setupData:(JZZTemplateTableViewDataEntity *)dataEntity;

@end
