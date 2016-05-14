//
//  JZZLifeCondition.h
//  ZJZWeather
//
//  Created by Jzzhou on 16/5/10.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface JZZLifeCondition : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *date;

@property (nonatomic, strong) NSArray *ziWaiXian;
@property (nonatomic, strong) NSArray *yunDong;

@property (nonatomic, strong) NSArray *ganMao;
@property (nonatomic, strong) NSArray *chuanYi;

// @property (nonatomic, strong) NSArray *kongTiao;
// @property (nonatomic, strong) NSArray *xiChe;

@end
