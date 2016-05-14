//
//  JZZCondition.m
//  ZJZWeather
//
//  Created by Jzzhou on 16/5/10.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import "JZZRealTimeCondition.h"

@implementation JZZRealTimeCondition

+ (NSDictionary *)imageMap {
    static NSDictionary *_imageMap = nil;
    if (!_imageMap) {
        _imageMap = @{
                      @"0" : @"weather-clear",
                      @"1" : @"weather-broken",
                      @"2" : @"weather-broken",
                      @"3" : @"weather-rain",
                      @"4" : @"weather-tstorm",
                      @"5" : @"weather-tstorm",
                      @"6" : @"weather-rain",
                      @"7" : @"weather-rain",
                      @"8" : @"weather-rain",
                      @"9" : @"weather-shower",
                      @"10" : @"weather-shower",
                      @"11" : @"weather-shower",
                      @"12" : @"weather-shower",
                      @"13" : @"weather-snow",
                      @"14" : @"weather-snow",
                      @"15" : @"weather-snow",
                      @"16" : @"weather-snow",
                      @"17" : @"weather-snow",
                      @"18" : @"weather-mist",
                      @"19" : @"weather-rain-night",
                      @"20" : @"weather-scattered",
                      @"21" : @"weather-rain",
                      @"22" : @"weather-rain",
                      @"23" : @"weather-shower",
                      @"24" : @"weather-shower",
                      @"25" : @"weather-shower",
                      @"26" : @"weather-snow",
                      @"27" : @"weather-snow",
                      @"28" : @"weather-snow",
                      @"29" : @"weather-mist",
                      @"30" : @"weather-mist",
                      @"31" : @"weather-mist",
                      @"53" : @"weather-mist"
                      };
    }
    return _imageMap;
}

- (NSString *)imageName {
    NSString *image = [JZZRealTimeCondition imageMap][self.weatherIcon];
    return image;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"date": @"date",
             @"moon": @"moon",
             @"week": @"week",
             @"humidity": @"weather.humidity",
             @"temperature": @"weather.temperature",
             @"weatherInfo": @"weather.info",
             @"weatherIcon": @"weather.img",
             @"locationName": @"city_name",
             @"windSpeed": @"wind.windspeed",
             @"windDirect": @"wind.direct",
             @"windPower": @"wind.power"
             };
}


//+ (NSValueTransformer *)dateJSONTransformer {
//    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^id(NSNumber *updateTimeNumber) {
//        return [NSDate dateWithTimeIntervalSince1970:[updateTimeNumber floatValue]];
//    } reverseBlock:^id(NSDate *date) {
//        return [NSNumber numberWithFloat:[date timeIntervalSince1970]];
//    }];
//}

@end
