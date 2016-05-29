//
//  JZZWeatherManager.h
//  ZJZWeather
//
//  Created by Jzzhou on 16/5/11.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "JZZRealTimeCondition.h"
#import "JZZLifeCondition.h"
#import "JZZForecast.h"

@interface JZZWeatherManager : NSObject
@property (nonatomic, strong, readonly) NSString *currentLocation;
@property (nonatomic, strong, readonly) JZZRealTimeCondition *realTimeCondition;
@property (nonatomic, strong, readonly) JZZLifeCondition *lifeCondition;
@property (nonatomic, strong, readonly) NSArray *lifeArray;
@property (nonatomic, strong, readonly) JZZForecast *forecast;
@property (nonatomic, strong, readonly) NSArray *imageArray;

+ (instancetype)sharedManager;

- (void)findCurrentLocation;
- (void)findOldManCurrentLocation;
@end
