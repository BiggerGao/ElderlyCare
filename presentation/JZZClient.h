//
//  JZZClient.h
//  ZJZWeather
//
//  Created by Jzzhou on 16/5/11.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@import CoreLocation;
@interface JZZClient : NSObject

- (RACSignal *)fetchJSONFromURL:(NSURL *)url;
- (RACSignal *)fetchCurrentConditionForLocation:(NSString *)city;

@end
