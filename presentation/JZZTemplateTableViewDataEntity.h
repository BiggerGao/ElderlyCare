//
//  JZZTableViewDataEntity.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/28.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JZZTemplateTableViewDataEntity : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) UIImage *avatar;

// cache
@property (nonatomic, assign) CGFloat cellHeight;

@end
