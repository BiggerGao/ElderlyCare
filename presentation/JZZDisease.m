//
//  JZZDisease.m
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/27.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import "JZZDisease.h"

@implementation JZZDisease

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"place":@"place",
             @"message":@"message",
             @"department":@"department"
             };
}

@end
