//
//  JZZDiseaseManager.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/27.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "JZZDisease.h"
#import "JZZSymptom.h"
#import "JZZFoodSupport.h"
#import "JZZDrugSupport.h"

@interface JZZDiseaseManager : NSObject

@property (nonatomic, readonly, strong) JZZDisease *disease;
@property (nonatomic, readonly, strong) JZZFoodSupport *foodSupport;
@property (nonatomic, readonly, strong) JZZSymptom *symptom;
@property (nonatomic, readonly, strong) JZZDrugSupport *drugSupport;


+ (instancetype)shareManager;

- (RACSignal *)fetchDiseaseMessageWithURL:(NSURL *)url;

@end
