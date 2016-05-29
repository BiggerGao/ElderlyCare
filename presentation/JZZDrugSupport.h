//
//  JZZDrugSupport.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/27.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface JZZDrugSupport : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *drug;
@property (nonatomic, copy) NSString *drugText;

@end
