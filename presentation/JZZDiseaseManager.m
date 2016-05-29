//
//  JZZDiseaseManager.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/27.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import "JZZDiseaseManager.h"
#import "GlobalVariablesManager.h"
#import "JZZDiseaseClient.h"
#import <TSMessage.h>

@interface JZZDiseaseManager ()

@property (nonatomic, readwrite, strong) JZZDisease *disease;
@property (nonatomic, readwrite, strong) JZZFoodSupport *foodSupport;
@property (nonatomic, readwrite, strong) JZZSymptom *symptom;
@property (nonatomic, readwrite, strong) JZZDrugSupport *drugSupport;
@property (nonatomic, strong) JZZDiseaseClient *client;

@end

@implementation JZZDiseaseManager

static JZZDiseaseManager *_sharedManager = nil;
static const NSString *kPrefixString = @"http://www.tngou.net/api/disease/name?name=";


+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (instancetype)init {
    if (self = [super init]) {
        _client = [[JZZDiseaseClient alloc] init];
        
        [[[[RACObserve([GlobalVariablesManager sharedManager], currOldMan) ignore:nil]
           flattenMap:^RACStream *(ZJZOldMan *currOldMan) {
               NSString *urlString = [[NSString stringWithFormat:@"%@%@",kPrefixString, currOldMan.illness] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
               NSURL *url = [NSURL URLWithString:urlString];
               return [self fetchDiseaseMessageWithURL:url];
               
           }] deliverOn:[RACScheduler mainThreadScheduler]]
         subscribeError:^(NSError *error) {
             [TSMessage showNotificationWithTitle:@"错误" subtitle:@"网络连接失败" type:TSMessageNotificationTypeError];
         }];
    }
    return self;
}

- (RACSignal *)fetchDiseaseMessageWithURL:(NSURL *)url {
    return [[self.client fetchAllDiseaseMessageFromURL:url] doNext:^(NSDictionary *jsonDict) {
        self.disease = [MTLJSONAdapter modelOfClass:[JZZDisease class] fromJSONDictionary:jsonDict error:nil];
        self.foodSupport = [MTLJSONAdapter modelOfClass:[JZZFoodSupport class] fromJSONDictionary:jsonDict error:nil];
        self.symptom = [MTLJSONAdapter modelOfClass:[JZZSymptom class] fromJSONDictionary:jsonDict error:nil];
        self.drugSupport = [MTLJSONAdapter modelOfClass:[JZZDrugSupport class] fromJSONDictionary:jsonDict error:nil];
        
    }];
}

@end
