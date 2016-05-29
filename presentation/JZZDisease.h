//
//  JZZDisease.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/27.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface JZZDisease : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *place;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *department;

@end
