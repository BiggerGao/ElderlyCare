//
//  JZZClient.m
//  ZJZWeather
//
//  Created by Jzzhou on 16/5/11.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import "JZZClient.h"
#import <CoreLocation/CoreLocation.h>
#import "JZZRealTimeCondition.h"
#import "JZZLifeCondition.h"
#import "JZZForecast.h"
#import <TSMessages/TSMessage.h>

@interface JZZClient ()
@property (nonatomic, strong) NSURLSession *session;
@end

static NSString *API = @"http://op.juhe.cn/onebox/weather/query?cityname=%@&dtype=&key=e77e5f1da4a8dd88274e0a737c1e8377";

@implementation JZZClient

- (instancetype)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:config];
    }
    return self;
}

- (RACSignal *)fetchJSONFromURL:(NSURL *)url {
//    NSLog(@"Fetching: %@", url.absoluteString);
    
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSURLSessionDataTask *dataTask = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (! error) {
                NSError *jsonError = nil;
                id json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                
                if ([json isKindOfClass:[NSDictionary class]]) {
//                    NSLog(@"%@", json[@"result"]);
                    if (json[@"result"] == [NSNull null]) {
                        [TSMessage showNotificationWithTitle:@"错误" subtitle:@"暂不支持该城市" type:TSMessageNotificationTypeError];
                        [subscriber sendCompleted];
                    }
                }
                if (! jsonError) {
                    [subscriber sendNext:json];
                }
                else {
                    [subscriber sendError:jsonError];
                }
            }
            else {
                [subscriber sendError:error];
            }
            
            [subscriber sendCompleted];
        }];
        
        [dataTask resume];
        
        return [RACDisposable disposableWithBlock:^{
            [dataTask cancel];
        }];
    }] doError:^(NSError *error) {
//        NSLog(@"%@",error);
    }];
}

- (RACSignal *)fetchCurrentConditionForLocation:(NSString *)city {
    NSString *urlString = [[NSString stringWithFormat:API, city] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    return [[self fetchJSONFromURL:url] map:^id(NSDictionary* json) {
        NSDictionary *realTimeDict = json[@"result"][@"data"][@"realtime"];
        NSDictionary *lifeConditionDict = json[@"result"][@"data"][@"life"];
        NSDictionary *forecastDict = json[@"result"][@"data"];
        
        id realTime = [MTLJSONAdapter modelOfClass:[JZZRealTimeCondition class] fromJSONDictionary:realTimeDict error:nil];
        id lifeCondition = [MTLJSONAdapter modelOfClass:[JZZLifeCondition class] fromJSONDictionary:lifeConditionDict error:nil];
        id forecast = [MTLJSONAdapter modelOfClass:[JZZForecast class] fromJSONDictionary:forecastDict error:nil];
        return @{@"realtime": realTime,
                 @"life": lifeCondition,
                 @"forecast":forecast};
    }];
}
@end
