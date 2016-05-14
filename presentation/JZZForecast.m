//
//  JZZForecast.m
//  ZJZWeather
//
//  Created by Jzzhou on 16/5/10.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import "JZZForecast.h"

@implementation JZZForecast

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"weather": @"weather"
             };
}

@end
