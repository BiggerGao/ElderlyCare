//
//  JZZCondition.h
//  ZJZWeather
//
//  Created by Jzzhou on 16/5/10.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface JZZRealTimeCondition : MTLModel<MTLJSONSerializing>

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *moon;
@property (nonatomic, strong) NSNumber *week;

@property (nonatomic, strong) NSString *humidity;
@property (nonatomic, strong) NSString *temperature;
@property (nonatomic, strong) NSString *weatherInfo;
@property (nonatomic, strong) NSString *weatherIcon;

@property (nonatomic, strong) NSString *locationName;
@property (nonatomic, strong) NSString *windSpeed;
@property (nonatomic, strong) NSString *windDirect;
@property (nonatomic, strong) NSString *windPower;

- (NSString *)imageName;
+ (NSDictionary *)imageMap;

@end
