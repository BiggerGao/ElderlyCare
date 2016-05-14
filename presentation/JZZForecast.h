//
//  JZZForecast.h
//  ZJZWeather
//
//  Created by Jzzhou on 16/5/10.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface JZZForecast : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong)NSArray *weather;

@end
