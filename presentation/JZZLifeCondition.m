//
//  JZZLifeCondition.m
//  ZJZWeather
//
//  Created by Jzzhou on 16/5/10.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import "JZZLifeCondition.h"

@implementation JZZLifeCondition

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"date": @"date",
//             @"kongTiao": @"info.kongtiao",
             @"yunDong": @"info.yundong",
             @"ziWaiXian": @"info.ziwaixian",
//             @"xiChe": @"info.xiche",
             @"ganMao": @"info.ganmao",
             @"chuanYi": @"info.chuanyi"
             };
}

@end
