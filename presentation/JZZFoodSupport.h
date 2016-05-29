//
//  JZZFoodSupport.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/27.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface JZZFoodSupport : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *food;
@property (nonatomic, copy) NSString *foodText;

@end
