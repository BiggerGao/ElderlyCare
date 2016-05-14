//
//  JZZManager.m
//  ZJZWeather
//
//  Created by Jzzhou on 16/5/11.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import "JZZManager.h"
#import "JZZClient.h"

#import <TSMessages/TSMessage.h>

@interface JZZManager () <CLLocationManagerDelegate>

@property (nonatomic, strong, readwrite) JZZRealTimeCondition *realTimeCondition;
@property (nonatomic, strong, readwrite) JZZLifeCondition *lifeCondition;
@property (nonatomic, strong, readwrite) NSArray *lifeArray;
@property (nonatomic, strong, readwrite) JZZForecast *forecast;
@property (nonatomic, strong, readwrite) NSString *currentLocation;
@property (nonatomic, strong, readwrite) NSArray *imageArray;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) JZZClient *client;
@property (nonatomic, assign) BOOL isFirstUpdate;

@end

@implementation JZZManager

+ (instancetype)sharedManager {
    static JZZManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _imageArray = @[@"life_ziwaixian", @"life_sport-1", @"life_aircondition-1", @"life_cold", @"life_dress", @"life_carwash1"];
        _client = [[JZZClient alloc] init];
        
        [[[[RACObserve(self, currentLocation) ignore:nil]
         flattenMap:^RACStream *(NSString *newLocation) {
             return [self updateCurrentConditions];
             
         }] deliverOn:[RACScheduler mainThreadScheduler]]
         subscribeError:^(NSError *error) {
             [TSMessage showNotificationWithTitle:@"错误" subtitle:@"网络连接失败" type:TSMessageNotificationTypeError];
         }];
    }
    return self;
}

#pragma mark - 更新天气数据
- (RACSignal *)updateCurrentConditions {
    return [[self.client fetchCurrentConditionForLocation:self.currentLocation] doNext:^(NSDictionary *dict) {
        self.realTimeCondition = dict[@"realtime"];
        self.lifeCondition = dict[@"life"];
        self.forecast = dict[@"forecast"];
//        NSLog(@"%@\n%@\n%@", _realTimeCondition, _lifeCondition, _forecast);
        
        self.lifeArray = @[_lifeCondition.ziWaiXian, _lifeCondition.yunDong, _lifeCondition.ganMao, _lifeCondition.chuanYi];
//        _lifeCondition.kongTiao/_lifeCondition.xiChe
    }];
}

#pragma mark - 定位城市

- (void)findCurrentLocation {
    self.isFirstUpdate = YES;
    if (! [CLLocationManager locationServicesEnabled]) {
        [TSMessage showNotificationWithTitle:@"未开启定位服务"
                                    subtitle:@"请开启定位服务定位您所在城市."
                                        type:TSMessageNotificationTypeError];
    }
    else if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager startUpdatingLocation];
    }
    else {
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    if (self.isFirstUpdate) {
        self.isFirstUpdate = NO;
        return;
    }
    CLLocation *newLocation = [locations lastObject];
    
    // 获取当前所在城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    // 反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (! error) {
            if ([placemarks count] > 0) {
                CLPlacemark *placemark = [placemarks firstObject];

                // 获取城市
                NSString *city = placemark.locality;
                if (! city) {
                    // 四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                    city = placemark.administrativeArea;
                }
//                NSLog(@"%@", city);
                self.currentLocation = city;
            } else if ([placemarks count] == 0) {
                [TSMessage showNotificationWithTitle:@"GPS故障"
                                            subtitle:@"定位城市失败"
                                                type:TSMessageNotificationTypeError];
            }
        } else {
            [TSMessage showNotificationWithTitle:@"网络错误"
                                        subtitle:@"请检查您的网络"
                                            type:TSMessageNotificationTypeError];
//            NSLog(@"%@", error);
        }
    }];
    [self.locationManager stopUpdatingLocation];
}

@end
