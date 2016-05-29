//
//  JZZSymptom.h
//  ElderlyCare
//
//  Created by Jzzhou on 16/5/27.
//  Copyright © 2016年 Jzzhou. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface JZZSymptom : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *symptom;
@property (nonatomic, copy) NSString *symptomText;

@end
